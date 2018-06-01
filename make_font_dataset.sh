#!/bin/bash


# Generate Synthetic text images using the convert/imagemagick library 
# Make sure to create train data before test and val 
if [ $# -ne 2 ] 
then 
echo "Please specify how many random words would you like to generate and the directory!" 1>&2 
echo "example: ./random-word-generator 3 train" 1>&2 
echo "This will generate 3 random words in dir train" 1>&2 
exit 0
fi

# Go to the dir 
mkdir $2 $2A $2B	 
cd $2
 
# Constants 
X=0
ALL_NON_RANDOM_WORDS=/usr/share/dict/words
MAX_WORD_LENGTH=9
MIN_WORD_LENGTH=4
# Probablity * 10 change of getting a captial letter
PROB=0
# total number of non-random words available 
non_random_words=`cat $ALL_NON_RANDOM_WORDS | wc -l` 

if [ $2 = "train" ];
then
	echo "Generating Training data"
	# rm train.txt
	# touch train.txt
else
	echo "Generating $2 data"
	# Check file exista to check data
	if [ -f "../train/train.txt" ];
	then
		echo "Training data present. Making sure that $2 and traning data is disjoint"
	else
		echo "No training data present to check $2 and training data is disjoint"
		exit 0
	fi
fi
 
# while loop to generate random words  
# number of random generated words depends on supplied argument 

for i in $(seq 1 1 "$1") 
do 
random_number=`od -N3 -An -i /dev/urandom | 
awk -v f=0 -v r="$non_random_words" '{printf "%i\n", f + r * $1 / 16777216}'` 

random_word=$(sed `echo $random_number`"q;d" $ALL_NON_RANDOM_WORDS)
# If word size greater than MAX_WORD_LENGTH find another word or already present in train.txt
while [ $(echo $random_word | wc -m) -gt $MAX_WORD_LENGTH -o $(grep -F "$random_word" ../train/train.txt | wc -m ) -gt 0 ];
do 
	echo "Already present: $random_word"
	random_number=`od -N3 -An -i /dev/urandom | awk -v f=0 -v r="$non_random_words" '{printf "%i\n", f + r * $1 / 16777216}'` 
	random_word=$(sed `echo $random_number`"q;d" $ALL_NON_RANDOM_WORDS)
	echo "New word: $random_word"
done

while [ $(echo $random_word | wc -m) -lt $MIN_WORD_LENGTH -o $(grep -F "$random_word" ../train/train.txt | wc -m ) -gt 0 ];
do 
	echo "Already present: $random_word"
	random_number=`od -N3 -An -i /dev/urandom | awk -v f=0 -v r="$non_random_words" '{printf "%i\n", f + r * $1 / 16777216}'` 
	random_word=$(sed `echo $random_number`"q;d" $ALL_NON_RANDOM_WORDS)
	echo "New word: $random_word"
done

# Append word to the folder
echo $random_word >> ../train/train.txt

# Randomly capitalize few words with probablity 0.1
RANDOM=$(tr -dc 0-9 < /dev/urandom | head -c10);
# Check probablity
if [ $(expr $RANDOM % 10 ) -lt $PROB ];
then
	word_length=$( echo $random_word | wc -m)
	for x in $(seq 0 1  $word_length )
	do
	# Generate random word
		# If yes convert from lower to upper at random position
		# echo "Before: $random_word"
		# Capitalize the letter at index x
		ind_word=$(echo ${random_word:$x:1} | tr '[a-z]' '[A-Z]' )
		new_word=$( echo ${random_word:0:$x}$ind_word${random_word:$x+1:$word_length} )
		# Replace word
		random_word=$new_word

		# echo "After: $random_word" 

	done
fi	

# Create first random word in candy.ttf 
convert -background white -fill black -font Helvetica -size 256x128 -gravity center label:$random_word  x.jpg;

# Create of Another text
convert -background white -fill black -font ../styles/RemachineScript_PERSONAL_USE_ONLY.ttf -pointsize 132 -size 256x128 -gravity center label:$random_word  y.jpg;

ii=$(expr ${i} + '0')

# For cycle gan make 2 more repo to x,y seprately
cp x.jpg ../$2A/$ii.jpg
cp y.jpg ../$2B/$ii.jpg
# Merge horizontally
convert +append x.jpg y.jpg $(echo $ii.jpg)
done

rm x.jpg y.jpg
cd ..