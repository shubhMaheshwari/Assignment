# Introduction

- Student nam:  Shubh Maheshwari
- Student Roll Number: 20161170
- Code Review of: 20161170/old
- Lines of code reviewed: 375
- Number of classes: 6
- Number of methods: 30
- Bugs identified: 8 (pseudo) & 0 (fatal) 
- Code smells identified: 434

## Conventions and Smells

This file contains the details of the errors and styling problems before refactoring the code. 
The final score of the code after refactoring is -14.73/10.  The errors have been highlighted  below.



# Errors
## Module Assignment3.old.asciiDrawings
```
W: 30, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 30, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 30, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 30, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 30, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 30, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 30, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 31, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 31, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 32, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 32, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 32, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 32, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 32, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 32, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 32, 0: Anomalous Unicode escape in byte string: '\U'. String constant might be missing an r or u prefix. (anomalous-unicode-escape-in-string)
W: 61, 0: Anomalous backslash in string: '\:'. String constant might be missing an r prefix. (anomalous-backslash-in-string)
W: 64, 0: Anomalous backslash in string: '\:'. String constant might be missing an r prefix. (anomalous-backslash-in-string)
C:  2, 0: Trailing whitespace (trailing-whitespace)
W:  5, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:  6, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:  6, 0: Exactly one space required after comma
	cprint("###############################################################",'red',attrs=['bold'])
                                                                         ^ (bad-whitespace)
C:  6, 0: Exactly one space required after comma
	cprint("###############################################################",'red',attrs=['bold'])
                                                                               ^ (bad-whitespace)
C:  7, 0: Trailing whitespace (trailing-whitespace)
W:  7, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:  7, 0: Exactly one space required after comma
	cprint("#                        ..:::::::::..                        #",'red',attrs=['bold']) 
                                                                         ^ (bad-whitespace)
C:  7, 0: Exactly one space required after comma
	cprint("#                        ..:::::::::..                        #",'red',attrs=['bold']) 
                                                                               ^ (bad-whitespace)
C:  8, 0: Trailing whitespace (trailing-whitespace)
W:  8, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:  8, 0: Exactly one space required after comma
	cprint("#                   ..:::aad8888888baa:::..                   #",'red',attrs=['bold'])  
                                                                         ^ (bad-whitespace)
C:  8, 0: Exactly one space required after comma
	cprint("#                   ..:::aad8888888baa:::..                   #",'red',attrs=['bold'])  
                                                                               ^ (bad-whitespace)
C:  9, 0: Trailing whitespace (trailing-whitespace)
W:  9, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:  9, 0: Exactly one space required after comma
	cprint("#                .::::d:?88888888888?::8b::::.                #",'red',attrs=['bold'])  
                                                                         ^ (bad-whitespace)
C:  9, 0: Exactly one space required after comma
	cprint("#                .::::d:?88888888888?::8b::::.                #",'red',attrs=['bold'])  
                                                                               ^ (bad-whitespace)
C: 10, 0: Trailing whitespace (trailing-whitespace)
W: 10, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 10, 0: Exactly one space required after comma
	cprint("#              .:::d8888:?88888888??a888888b:::.              #",'red',attrs=['bold'])   
                                                                         ^ (bad-whitespace)
C: 10, 0: Exactly one space required after comma
	cprint("#              .:::d8888:?88888888??a888888b:::.              #",'red',attrs=['bold'])   
                                                                               ^ (bad-whitespace)
C: 11, 0: Trailing whitespace (trailing-whitespace)
W: 11, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 11, 0: Exactly one space required after comma
	cprint("#            .:::d8888888a8888888aa8888888888b:::.            #",'red',attrs=['bold'])   
                                                                         ^ (bad-whitespace)
C: 11, 0: Exactly one space required after comma
	cprint("#            .:::d8888888a8888888aa8888888888b:::.            #",'red',attrs=['bold'])   
                                                                               ^ (bad-whitespace)
C: 12, 0: Trailing whitespace (trailing-whitespace)
W: 12, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 12, 0: Exactly one space required after comma
	cprint("#           ::::dP::::::::88888888888::::::::Yb::::           #",'red',attrs=['bold'])   
                                                                         ^ (bad-whitespace)
C: 12, 0: Exactly one space required after comma
	cprint("#           ::::dP::::::::88888888888::::::::Yb::::           #",'red',attrs=['bold'])   
                                                                               ^ (bad-whitespace)
C: 13, 0: Trailing whitespace (trailing-whitespace)
W: 13, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 13, 0: Exactly one space required after comma
	cprint("#          ::::dP:::::::::Y888888888P:::::::::Yb::::          #",'red',attrs=['bold'])      
                                                                         ^ (bad-whitespace)
C: 13, 0: Exactly one space required after comma
	cprint("#          ::::dP:::::::::Y888888888P:::::::::Yb::::          #",'red',attrs=['bold'])      
                                                                               ^ (bad-whitespace)
C: 14, 0: Trailing whitespace (trailing-whitespace)
W: 14, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 14, 0: Exactly one space required after comma
	cprint("#         ::::d8:::::::::::Y8888888P:::::::::::8b::::         #",'red',attrs=['bold'])      
                                                                         ^ (bad-whitespace)
C: 14, 0: Exactly one space required after comma
	cprint("#         ::::d8:::::::::::Y8888888P:::::::::::8b::::         #",'red',attrs=['bold'])      
                                                                               ^ (bad-whitespace)
C: 15, 0: Trailing whitespace (trailing-whitespace)
W: 15, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 15, 0: Exactly one space required after comma
	cprint("#        .::::88::::::::::::Y88888P::::::::::::88::::.        #",'red',attrs=['bold'])     
                                                                         ^ (bad-whitespace)
C: 15, 0: Exactly one space required after comma
	cprint("#        .::::88::::::::::::Y88888P::::::::::::88::::.        #",'red',attrs=['bold'])     
                                                                               ^ (bad-whitespace)
C: 16, 0: Trailing whitespace (trailing-whitespace)
W: 16, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 16, 0: Exactly one space required after comma
	cprint("#        :::::Y8baaaaaaaaaa88P:T:Y88aaaaaaaaaad8P:::::        #",'red',attrs=['bold'])     
                                                                         ^ (bad-whitespace)
C: 16, 0: Exactly one space required after comma
	cprint("#        :::::Y8baaaaaaaaaa88P:T:Y88aaaaaaaaaad8P:::::        #",'red',attrs=['bold'])     
                                                                               ^ (bad-whitespace)
C: 17, 0: Trailing whitespace (trailing-whitespace)
W: 17, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 17, 0: Exactly one space required after comma
	cprint("#        :::::::Y88888888888P::|::Y88888888888P:::::::        #",'red',attrs=['bold'])     
                                                                         ^ (bad-whitespace)
C: 17, 0: Exactly one space required after comma
	cprint("#        :::::::Y88888888888P::|::Y88888888888P:::::::        #",'red',attrs=['bold'])     
                                                                               ^ (bad-whitespace)
C: 18, 0: Trailing whitespace (trailing-whitespace)
W: 18, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 18, 0: Exactly one space required after comma
	cprint("#        ::::::::::::::::888:::|:::888::::::::::::::::        #",'red',attrs=['bold'])     
                                                                         ^ (bad-whitespace)
C: 18, 0: Exactly one space required after comma
	cprint("#        ::::::::::::::::888:::|:::888::::::::::::::::        #",'red',attrs=['bold'])     
                                                                               ^ (bad-whitespace)
C: 19, 0: Trailing whitespace (trailing-whitespace)
W: 19, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 19, 0: Exactly one space required after comma
	cprint("#        `:::::::::::::::8888888888888b::::::::::::::'        #",'red',attrs=['bold'])      
                                                                         ^ (bad-whitespace)
C: 19, 0: Exactly one space required after comma
	cprint("#        `:::::::::::::::8888888888888b::::::::::::::'        #",'red',attrs=['bold'])      
                                                                               ^ (bad-whitespace)
C: 20, 0: Trailing whitespace (trailing-whitespace)
W: 20, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 20, 0: Exactly one space required after comma
	cprint("#         :::::::::::::::88888888888888::::::::::::::         #",'red',attrs=['bold'])    
                                                                         ^ (bad-whitespace)
C: 20, 0: Exactly one space required after comma
	cprint("#         :::::::::::::::88888888888888::::::::::::::         #",'red',attrs=['bold'])    
                                                                               ^ (bad-whitespace)
C: 21, 0: Trailing whitespace (trailing-whitespace)
W: 21, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 21, 0: Exactly one space required after comma
	cprint("#          :::::::::::::d88888888888888:::::::::::::          #",'red',attrs=['bold'])     
                                                                         ^ (bad-whitespace)
C: 21, 0: Exactly one space required after comma
	cprint("#          :::::::::::::d88888888888888:::::::::::::          #",'red',attrs=['bold'])     
                                                                               ^ (bad-whitespace)
C: 22, 0: Trailing whitespace (trailing-whitespace)
W: 22, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 22, 0: Exactly one space required after comma
	cprint("#           ::::::::::::88::88::88:::88::::::::::::           #",'red',attrs=['bold'])   
                                                                         ^ (bad-whitespace)
C: 22, 0: Exactly one space required after comma
	cprint("#           ::::::::::::88::88::88:::88::::::::::::           #",'red',attrs=['bold'])   
                                                                               ^ (bad-whitespace)
C: 23, 0: Trailing whitespace (trailing-whitespace)
W: 23, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 23, 0: Exactly one space required after comma
	cprint("#            `::::::::::88::88::88:::88::::::::::'            #",'red',attrs=['bold'])     
                                                                         ^ (bad-whitespace)
C: 23, 0: Exactly one space required after comma
	cprint("#            `::::::::::88::88::88:::88::::::::::'            #",'red',attrs=['bold'])     
                                                                               ^ (bad-whitespace)
C: 24, 0: Trailing whitespace (trailing-whitespace)
W: 24, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 24, 0: Exactly one space required after comma
	cprint("#              `::::::::88::88::P::::88::::::::'              #",'red',attrs=['bold'])   
                                                                         ^ (bad-whitespace)
C: 24, 0: Exactly one space required after comma
	cprint("#              `::::::::88::88::P::::88::::::::'              #",'red',attrs=['bold'])   
                                                                               ^ (bad-whitespace)
C: 25, 0: Trailing whitespace (trailing-whitespace)
W: 25, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 25, 0: Exactly one space required after comma
	cprint("#                `::::::88::88:::::::88::::::'                #",'red',attrs=['bold']) 
                                                                         ^ (bad-whitespace)
C: 25, 0: Exactly one space required after comma
	cprint("#                `::::::88::88:::::::88::::::'                #",'red',attrs=['bold']) 
                                                                               ^ (bad-whitespace)
W: 26, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 26, 0: Exactly one space required after comma
	cprint("#                   ``:::::::::::::::::::''                   #",'red',attrs=['bold'])
                                                                         ^ (bad-whitespace)
C: 26, 0: Exactly one space required after comma
	cprint("#                   ``:::::::::::::::::::''                   #",'red',attrs=['bold'])
                                                                               ^ (bad-whitespace)
W: 27, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 27, 0: Exactly one space required after comma
	cprint("#                        ``:::::::::''                        #",'red',attrs=['bold'])
                                                                         ^ (bad-whitespace)
C: 27, 0: Exactly one space required after comma
	cprint("#                        ``:::::::::''                        #",'red',attrs=['bold'])
                                                                               ^ (bad-whitespace)
W: 28, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 28, 0: Exactly one space required after comma
	cprint("###############################################################",'red',attrs=['bold'])
                                                                         ^ (bad-whitespace)
C: 28, 0: Exactly one space required after comma
	cprint("###############################################################",'red',attrs=['bold'])
                                                                               ^ (bad-whitespace)
C: 30, 0: Trailing whitespace (trailing-whitespace)
C: 30, 0: Line too long (106/100) (line-too-long)
W: 30, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 30, 0: Exactly one space required after comma
	cprint("			\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3",'blue',attrs=['bold'])	
                                                                                   ^ (bad-whitespace)
C: 30, 0: Exactly one space required after comma
	cprint("			\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3",'blue',attrs=['bold'])	
                                                                                          ^ (bad-whitespace)
C: 31, 0: Trailing whitespace (trailing-whitespace)
W: 31, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 31, 0: Exactly one space required after comma
	cprint("			\U0001F4A3BOMBER MAN\U0001F4A3","blue",attrs=['bold','underline'])	
                                           ^ (bad-whitespace)
C: 31, 0: Exactly one space required after comma
	cprint("			\U0001F4A3BOMBER MAN\U0001F4A3","blue",attrs=['bold','underline'])	
                                                  ^ (bad-whitespace)
C: 31, 0: Exactly one space required after comma
	cprint("			\U0001F4A3BOMBER MAN\U0001F4A3","blue",attrs=['bold','underline'])	
                                                                ^ (bad-whitespace)
C: 32, 0: Trailing whitespace (trailing-whitespace)
C: 32, 0: Line too long (108/100) (line-too-long)
W: 32, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 32, 0: Exactly one space required after comma
	cprint("			\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3\n",'blue',attrs=['bold'])			
                                                                                     ^ (bad-whitespace)
C: 32, 0: Exactly one space required after comma
	cprint("			\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3\U0001F4A3\n",'blue',attrs=['bold'])			
                                                                                            ^ (bad-whitespace)
W: 34, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 35, 0: Line too long (115/100) (line-too-long)
W: 35, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 36, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 37, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 38, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 39, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 40, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 41, 0: Trailing whitespace (trailing-whitespace)
W: 42, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 42, 0: Unnecessary parens after 'print' keyword (superfluous-parens)
C: 46, 0: Trailing whitespace (trailing-whitespace)
C: 46, 0: Line too long (112/100) (line-too-long)
W: 46, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 46, 0: Exactly one space required after comma
	cprint("		        88                                 88                                              ",'green')  
                                                                                                       ^ (bad-whitespace)
C: 47, 0: Trailing whitespace (trailing-whitespace)
C: 47, 0: Line too long (112/100) (line-too-long)
W: 47, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 47, 0: Exactly one space required after comma
	cprint("		  ,d    88                                 88                                              ",'green')    
                                                                                                       ^ (bad-whitespace)
C: 48, 0: Trailing whitespace (trailing-whitespace)
C: 48, 0: Line too long (112/100) (line-too-long)
W: 48, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 48, 0: Exactly one space required after comma
	cprint("		  88    88                                 88                                              ",'green')   
                                                                                                       ^ (bad-whitespace)
C: 49, 0: Trailing whitespace (trailing-whitespace)
C: 49, 0: Line too long (109/100) (line-too-long)
W: 49, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 49, 0: Exactly one space required after comma
	cprint("		MM88MMM 88,dPPYba,  ,adPPYYba, 8b,dPPYba,  88   ,d8 8b       d8  ,adPPYba,   88		   88  ",'green')   
                                                                                                    ^ (bad-whitespace)
C: 50, 0: Line too long (118/100) (line-too-long)
W: 50, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 50, 0: Exactly one space required after comma
	cprint("		  88    88P'    \"8a \"\"     `Y8 88P'   `\"8a 88 ,a8\"  `8b     d8' a8\"     \"8a  88        88 ",'green')
                                                                                                             ^ (bad-whitespace)
C: 51, 0: Trailing whitespace (trailing-whitespace)
C: 51, 0: Line too long (112/100) (line-too-long)
W: 51, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 51, 0: Exactly one space required after comma
	cprint("		  88    88       88 ,adPPPPP88 88       88 8888[     `8b   d8'  8b       d8  88        88  ",'green')    
                                                                                                       ^ (bad-whitespace)
C: 52, 0: Trailing whitespace (trailing-whitespace)
C: 52, 0: Line too long (115/100) (line-too-long)
W: 52, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 52, 0: Exactly one space required after comma
	cprint("		  88,   88       88 88,    ,88 88       88 88`\"Yba,   `8b,d8'   \"8a,   ,a8\"  88a      a88  ",'green')     
                                                                                                          ^ (bad-whitespace)
C: 53, 0: Trailing whitespace (trailing-whitespace)
C: 53, 0: Line too long (118/100) (line-too-long)
W: 53, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 53, 0: Exactly one space required after comma
	cprint("		  \"Y888 88       88 `\"8bbdP\"Y8 88       88 88   `Y8a    Y88'     `\"YbbdP\"'    `\"YbbdP'Y8   ",'green')    
                                                                                                             ^ (bad-whitespace)
C: 54, 0: Trailing whitespace (trailing-whitespace)
C: 54, 0: Line too long (112/100) (line-too-long)
W: 54, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 54, 0: Exactly one space required after comma
	cprint("		                                                        d8'                                ",'green')   
                                                                                                       ^ (bad-whitespace)
W: 55, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 55, 0: Exactly one space required after comma
	cprint("		                                                       d8'                   ",'green')
                                                                                         ^ (bad-whitespace)
C: 58, 0: Trailing whitespace (trailing-whitespace)
C: 59, 0: Trailing whitespace (trailing-whitespace)
W: 59, 0: Bad indentation. Found 8 spaces, expected 4 (bad-indentation)
C: 59, 0: Exactly one space required after comma
        cprint("     ___________   ",'yellow',attrs=['bold']) 
                                    ^ (bad-whitespace)
C: 59, 0: Exactly one space required after comma
        cprint("     ___________   ",'yellow',attrs=['bold']) 
                                             ^ (bad-whitespace)
C: 60, 0: Trailing whitespace (trailing-whitespace)
W: 60, 0: Bad indentation. Found 8 spaces, expected 4 (bad-indentation)
C: 60, 0: Exactly one space required after comma
        cprint("    '._==_==_=_.'  ",'yellow',attrs=['bold']) 
                                    ^ (bad-whitespace)
C: 60, 0: Exactly one space required after comma
        cprint("    '._==_==_=_.'  ",'yellow',attrs=['bold']) 
                                             ^ (bad-whitespace)
C: 61, 0: Trailing whitespace (trailing-whitespace)
W: 61, 0: Bad indentation. Found 8 spaces, expected 4 (bad-indentation)
C: 61, 0: Exactly one space required after comma
        cprint("    .-\:      /-.  ",'yellow',attrs=['bold']) 
                                    ^ (bad-whitespace)
C: 61, 0: Exactly one space required after comma
        cprint("    .-\:      /-.  ",'yellow',attrs=['bold']) 
                                             ^ (bad-whitespace)
C: 62, 0: Trailing whitespace (trailing-whitespace)
W: 62, 0: Bad indentation. Found 8 spaces, expected 4 (bad-indentation)
C: 62, 0: Exactly one space required after comma
        cprint("   | (|:.     |) | ",'yellow',attrs=['bold']) 
                                    ^ (bad-whitespace)
C: 62, 0: Exactly one space required after comma
        cprint("   | (|:.     |) | ",'yellow',attrs=['bold']) 
                                             ^ (bad-whitespace)
C: 63, 0: Trailing whitespace (trailing-whitespace)
W: 63, 0: Bad indentation. Found 8 spaces, expected 4 (bad-indentation)
C: 63, 0: Exactly one space required after comma
        cprint("    '-|:.     |-'  ",'yellow',attrs=['bold']) 
                                    ^ (bad-whitespace)
C: 63, 0: Exactly one space required after comma
        cprint("    '-|:.     |-'  ",'yellow',attrs=['bold']) 
                                             ^ (bad-whitespace)
C: 64, 0: Trailing whitespace (trailing-whitespace)
W: 64, 0: Bad indentation. Found 8 spaces, expected 4 (bad-indentation)
C: 64, 0: Exactly one space required after comma
        cprint("      \::.    /    ",'yellow',attrs=['bold']) 
                                    ^ (bad-whitespace)
C: 64, 0: Exactly one space required after comma
        cprint("      \::.    /    ",'yellow',attrs=['bold']) 
                                             ^ (bad-whitespace)
C: 65, 0: Trailing whitespace (trailing-whitespace)
W: 65, 0: Bad indentation. Found 8 spaces, expected 4 (bad-indentation)
C: 65, 0: Exactly one space required after comma
        cprint("       '::. .'     ",'yellow',attrs=['bold']) 
                                    ^ (bad-whitespace)
C: 65, 0: Exactly one space required after comma
        cprint("       '::. .'     ",'yellow',attrs=['bold']) 
                                             ^ (bad-whitespace)
C: 66, 0: Trailing whitespace (trailing-whitespace)
W: 66, 0: Bad indentation. Found 8 spaces, expected 4 (bad-indentation)
C: 66, 0: Exactly one space required after comma
        cprint("         ) (       ",'yellow',attrs=['bold']) 
                                    ^ (bad-whitespace)
C: 66, 0: Exactly one space required after comma
        cprint("         ) (       ",'yellow',attrs=['bold']) 
                                             ^ (bad-whitespace)
C: 67, 0: Trailing whitespace (trailing-whitespace)
W: 67, 0: Bad indentation. Found 8 spaces, expected 4 (bad-indentation)
C: 67, 0: Exactly one space required after comma
        cprint("       _.' '._     ",'yellow',attrs=['bold']) 
                                    ^ (bad-whitespace)
C: 67, 0: Exactly one space required after comma
        cprint("       _.' '._     ",'yellow',attrs=['bold']) 
                                             ^ (bad-whitespace)
C: 68, 0: Final newline missing (missing-final-newline)
W: 68, 0: Bad indentation. Found 8 spaces, expected 4 (bad-indentation)
C: 68, 0: Exactly one space required after comma
        cprint("      `\"\"\"\"\"\"\"`	   ",'yellow',attrs=['bold']) 
                                           ^ (bad-whitespace)
C: 68, 0: Exactly one space required after comma
        cprint("      `\"\"\"\"\"\"\"`	   ",'yellow',attrs=['bold']) 
                                                    ^ (bad-whitespace)
C:  1, 0: Invalid module name "asciiDrawings" (invalid-name)
C:  1, 0: Missing module docstring (missing-docstring)
C:  4, 0: Missing function docstring (missing-docstring)
C: 45, 0: Missing function docstring (missing-docstring)
C: 57, 0: Missing function docstring (missing-docstring)
```

## Module Assignment3.old.Block
```
W:  4, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:  5, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:  6, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:  7, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:  8, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:  9, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 10, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 11, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 12, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 13, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 14, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 16, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 16, 0: Exactly one space required after comma
	def getBlock(self,a,b):
                  ^ (bad-whitespace)
C: 16, 0: Exactly one space required after comma
	def getBlock(self,a,b):
                    ^ (bad-whitespace)
C: 17, 0: Trailing whitespace (trailing-whitespace)
W: 18, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 19, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 21, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 22, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 24, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 25, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 26, 0: Trailing whitespace (trailing-whitespace)
W: 27, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 28, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 30, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 31, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 33, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 34, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 36, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 37, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 39, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 40, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 42, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 43, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 45, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 46, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 47, 0: Trailing whitespace (trailing-whitespace)
W: 49, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 49, 0: Exactly one space required after comma
		elif a in ['1','2','3','4']:
                ^ (bad-whitespace)
C: 49, 0: Exactly one space required after comma
		elif a in ['1','2','3','4']:
                    ^ (bad-whitespace)
C: 49, 0: Exactly one space required after comma
		elif a in ['1','2','3','4']:
                        ^ (bad-whitespace)
C: 50, 0: Trailing whitespace (trailing-whitespace)
W: 50, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 51, 0: Trailing whitespace (trailing-whitespace)
W: 52, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 52, 0: No space allowed before :
		else :
       ^ (bad-whitespace)
W: 53, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 55, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 55, 0: Exactly one space required after comma
	def getColor(self,a):
                  ^ (bad-whitespace)
W: 56, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 57, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 59, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 60, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 62, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 63, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 64, 0: Trailing whitespace (trailing-whitespace)
W: 65, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 66, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 68, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 69, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 71, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 71, 0: No space allowed before :
		elif a == 'e' :
                ^ (bad-whitespace)
W: 72, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 74, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 74, 0: No space allowed before :
		elif a == 'E' :
                ^ (bad-whitespace)
W: 75, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 76, 0: Trailing whitespace (trailing-whitespace)
W: 78, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 78, 0: Exactly one space required after comma
		elif a in ['1','2','3','4']:
                ^ (bad-whitespace)
C: 78, 0: Exactly one space required after comma
		elif a in ['1','2','3','4']:
                    ^ (bad-whitespace)
C: 78, 0: Exactly one space required after comma
		elif a in ['1','2','3','4']:
                        ^ (bad-whitespace)
C: 79, 0: Trailing whitespace (trailing-whitespace)
W: 79, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 80, 0: Trailing whitespace (trailing-whitespace)
W: 81, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 81, 0: No space allowed before :
		else :
       ^ (bad-whitespace)
W: 82, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:  1, 0: Missing module docstring (missing-docstring)
C: 10, 2: Invalid attribute name "enemy1Upper" (invalid-name)
C: 13, 2: Invalid attribute name "enemy2Lower" (invalid-name)
C: 12, 2: Invalid attribute name "enemy2Upper" (invalid-name)
C:  8, 2: Invalid attribute name "bombermanUpper" (invalid-name)
C: 14, 2: Invalid attribute name "bombBlast" (invalid-name)
C:  9, 2: Invalid attribute name "bombermanLower" (invalid-name)
C: 11, 2: Invalid attribute name "enemy1Lower" (invalid-name)
C:  2, 0: Missing class docstring (missing-docstring)
R:  2, 0: Too many instance attributes (10/7) (too-many-instance-attributes)
C:  2, 0: Old-style class defined. (old-style-class)
C: 16, 1: Invalid method name "getBlock" (invalid-name)
C: 16, 1: Invalid argument name "a" (invalid-name)
C: 16, 1: Invalid argument name "b" (invalid-name)
C: 16, 1: Missing method docstring (missing-docstring)
R: 16, 1: Too many return statements (12/6) (too-many-return-statements)
C: 55, 1: Invalid method name "getColor" (invalid-name)
C: 55, 1: Invalid argument name "a" (invalid-name)
C: 55, 1: Missing method docstring (missing-docstring)
R: 55, 1: Too many return statements (9/6) (too-many-return-statements)
R: 55, 1: Method could be a function (no-self-use)
```

## Module Assignment3.old.Board
```
C:  1, 0: Trailing whitespace (trailing-whitespace)
W: 10, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 10, 0: Exactly one space required after comma
	def __init__(self,x,y,level):
                  ^ (bad-whitespace)
C: 10, 0: Exactly one space required after comma
	def __init__(self,x,y,level):
                    ^ (bad-whitespace)
C: 10, 0: Exactly one space required after comma
	def __init__(self,x,y,level):
                      ^ (bad-whitespace)
W: 11, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 11, 0: No space allowed after bracket
		orignal = [ [' ' for j in range(x)] for i in range(y)]
            ^ (bad-whitespace)
W: 12, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 13, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 15, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 15, 0: Exactly one space required after comma
		for j in range(1,y-1):
                  ^ (bad-whitespace)
C: 17, 0: Trailing whitespace (trailing-whitespace)
W: 17, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 18, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 18, 0: Exactly one space required around assignment
				horizontallist=[]
                  ^ (bad-whitespace)
W: 19, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 20, 0: Trailing whitespace (trailing-whitespace)
W: 20, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 21, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 22, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 23, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 25, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 26, 0: Trailing whitespace (trailing-whitespace)
W: 26, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 27, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 28, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 29, 0: Trailing whitespace (trailing-whitespace)
W: 30, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 31, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 31, 0: Exactly one space required after comma
			orignal[randint(1,y-2)][randint(1,x-2)] = '%'
                    ^ (bad-whitespace)
C: 31, 0: Exactly one space required after comma
			orignal[randint(1,y-2)][randint(1,x-2)] = '%'
                                    ^ (bad-whitespace)
W: 33, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 34, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 35, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 36, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 37, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 38, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 39, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 39, 0: Exactly one space required after comma
		self.enemy = EnemyArray(self.orignal,self.level,x,y)
                                      ^ (bad-whitespace)
C: 39, 0: Exactly one space required after comma
		self.enemy = EnemyArray(self.orignal,self.level,x,y)
                                                 ^ (bad-whitespace)
C: 39, 0: Exactly one space required after comma
		self.enemy = EnemyArray(self.orignal,self.level,x,y)
                                                   ^ (bad-whitespace)
W: 41, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 43, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 43, 0: Exactly one space required after comma
	def moveBomber(self,game,dirx,diry):
                    ^ (bad-whitespace)
C: 43, 0: Exactly one space required after comma
	def moveBomber(self,game,dirx,diry):
                         ^ (bad-whitespace)
C: 43, 0: Exactly one space required after comma
	def moveBomber(self,game,dirx,diry):
                              ^ (bad-whitespace)
W: 44, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 45, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 47, 0: Trailing whitespace (trailing-whitespace)
W: 47, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 48, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 49, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 50, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 52, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 54, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 55, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 57, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 58, 0: Trailing whitespace (trailing-whitespace)
W: 58, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 62, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 62, 0: Exactly one space required after comma
	def updateBomb(self,game):
                    ^ (bad-whitespace)
W: 63, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 63, 0: No space allowed before :
		try :
      ^ (bad-whitespace)
C: 64, 0: Trailing whitespace (trailing-whitespace)
W: 64, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 66, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 66, 0: Exactly one space required after comma
			dirx = [0,0,0,1,-1]
            ^ (bad-whitespace)
C: 66, 0: Exactly one space required after comma
			dirx = [0,0,0,1,-1]
              ^ (bad-whitespace)
C: 66, 0: Exactly one space required after comma
			dirx = [0,0,0,1,-1]
                ^ (bad-whitespace)
C: 66, 0: Exactly one space required after comma
			dirx = [0,0,0,1,-1]
                  ^ (bad-whitespace)
W: 67, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 67, 0: Exactly one space required after comma
			diry = [0,1,-1,0,0]
            ^ (bad-whitespace)
C: 67, 0: Exactly one space required after comma
			diry = [0,1,-1,0,0]
              ^ (bad-whitespace)
C: 67, 0: Exactly one space required after comma
			diry = [0,1,-1,0,0]
                 ^ (bad-whitespace)
C: 67, 0: Exactly one space required after comma
			diry = [0,1,-1,0,0]
                   ^ (bad-whitespace)
W: 69, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 70, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 70, 0: No space allowed before :
				if self.orignal[game.bomb.y][game.bomb.x] != 'b' :
                                                     ^ (bad-whitespace)
W: 71, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 72, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 74, 0: Trailing whitespace (trailing-whitespace)
W: 74, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 75, 0: Trailing whitespace (trailing-whitespace)
W: 76, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 78, 0: Trailing whitespace (trailing-whitespace)
W: 78, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 78, 0: Exactly one space required before assignment
				points  = 0 
            ^ (bad-whitespace)
W: 79, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 80, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 82, 0: Trailing whitespace (trailing-whitespace)
W: 82, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 83, 0: Trailing whitespace (trailing-whitespace)
W: 84, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 85, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 87, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 89, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 90, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 91, 0: Trailing whitespace (trailing-whitespace)
W: 92, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 94, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 95, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 97, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 98, 0: Trailing whitespace (trailing-whitespace)
W: 98, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 99, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:101, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:102, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:103, 0: Trailing whitespace (trailing-whitespace)
W:104, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:105, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:105, 0: Unnecessary parens after 'print' keyword (superfluous-parens)
C:106, 0: Trailing whitespace (trailing-whitespace)
W:106, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:108, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:110, 0: Trailing whitespace (trailing-whitespace)
C:111, 0: Trailing whitespace (trailing-whitespace)
W:111, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:113, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:115, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:116, 0: Trailing whitespace (trailing-whitespace)
W:116, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:118, 0: Trailing whitespace (trailing-whitespace)
W:118, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:118, 0: No space allowed before :
						else :	
           ^ (bad-whitespace)
C:120, 0: Trailing whitespace (trailing-whitespace)
C:121, 0: Trailing whitespace (trailing-whitespace)
W:121, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:122, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:123, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:124, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:125, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:126, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:127, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:129, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:130, 0: Trailing whitespace (trailing-whitespace)
W:130, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:131, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:132, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:133, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:134, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:135, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:137, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:138, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:139, 0: Trailing whitespace (trailing-whitespace)
W:139, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:139, 0: Unnecessary parens after 'print' keyword (superfluous-parens)
C:140, 0: Trailing whitespace (trailing-whitespace)
C:141, 0: Trailing whitespace (trailing-whitespace)
W:141, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:142, 0: Trailing whitespace (trailing-whitespace)
W:142, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:143, 0: Trailing whitespace (trailing-whitespace)
W:144, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:146, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:147, 0: Trailing whitespace (trailing-whitespace)
W:147, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:148, 0: Trailing whitespace (trailing-whitespace)
W:148, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:150, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:151, 0: Trailing whitespace (trailing-whitespace)
C:152, 0: Trailing whitespace (trailing-whitespace)
W:152, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:153, 0: Trailing whitespace (trailing-whitespace)
W:153, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:155, 0: Trailing whitespace (trailing-whitespace)
W:155, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:157, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:158, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:162, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:162, 0: Exactly one space required after comma
	def updateEnemy(self,game):
                     ^ (bad-whitespace)
W:163, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:164, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:165, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:166, 0: Trailing whitespace (trailing-whitespace)
W:166, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:168, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:169, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:170, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:171, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:172, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:172, 0: No space allowed before :
				if y > ex.y :
                ^ (bad-whitespace)
W:173, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:174, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:175, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:176, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:177, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:178, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:178, 0: No space allowed before :
					else :
          ^ (bad-whitespace)
W:179, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:180, 0: Trailing whitespace (trailing-whitespace)
W:182, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:182, 0: No space allowed before :
				elif y < ex.y :
                  ^ (bad-whitespace)
C:183, 0: Trailing whitespace (trailing-whitespace)
W:183, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:183, 0: No space allowed before :
					if self.orignal[ex.y - 1][ex.x] == ' ' : 
                                            ^ (bad-whitespace)
C:184, 0: Trailing whitespace (trailing-whitespace)
W:184, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:184, 0: No space allowed before bracket
						self.orignal[ex.y - 1 ][ex.x] = 'e'						
                            ^ (bad-whitespace)
W:185, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:186, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:187, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:188, 0: Trailing whitespace (trailing-whitespace)
W:188, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:188, 0: No space allowed before :
					else : 
          ^ (bad-whitespace)
W:189, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:190, 0: Trailing whitespace (trailing-whitespace)
W:192, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:192, 0: No space allowed before :
				elif y == ex.y :
                   ^ (bad-whitespace)
W:193, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:193, 0: No space allowed before :
					if x > ex.x :
                 ^ (bad-whitespace)
W:194, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:195, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:196, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:197, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:197, 0: No space allowed before bracket
						elif self.orignal[ex.y][ex.x +1 ] == 'b':
                                      ^ (bad-whitespace)
W:198, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:199, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:200, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:201, 0: Trailing whitespace (trailing-whitespace)
W:203, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:203, 0: No space allowed before :
					elif x < ex.x :
                   ^ (bad-whitespace)
W:204, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:205, 0: Trailing whitespace (trailing-whitespace)
W:205, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:206, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:207, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:208, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:209, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:210, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:211, 0: Trailing whitespace (trailing-whitespace)
C:213, 0: Trailing whitespace (trailing-whitespace)
W:213, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:213, 0: No space allowed before :
					else : 
          ^ (bad-whitespace)
W:214, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:216, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:216, 0: No space allowed before :
				else :
         ^ (bad-whitespace)
W:217, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:218, 0: Trailing whitespace (trailing-whitespace)
C:219, 0: Trailing whitespace (trailing-whitespace)
W:219, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:219, 0: No space allowed before :
			elif ex.status == 2 :		
                       ^ (bad-whitespace)
W:220, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:221, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:222, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:223, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:224, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:225, 0: Trailing whitespace (trailing-whitespace)
W:226, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:227, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:229, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:230, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:230, 0: Exactly one space required after comma
						print("Enemy:",ex.x,ex.y)
                    ^ (bad-whitespace)
C:230, 0: Exactly one space required after comma
						print("Enemy:",ex.x,ex.y)
                         ^ (bad-whitespace)
W:231, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:231, 0: Unnecessary parens after 'print' keyword (superfluous-parens)
C:232, 0: Trailing whitespace (trailing-whitespace)
W:232, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:233, 0: Trailing whitespace (trailing-whitespace)
W:235, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:236, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:237, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:238, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:239, 0: Trailing whitespace (trailing-whitespace)
W:239, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:241, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:242, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:244, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:245, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:245, 0: Exactly one space required after comma
						print("Enemy:",ex.x,ex.y)
                    ^ (bad-whitespace)
C:245, 0: Exactly one space required after comma
						print("Enemy:",ex.x,ex.y)
                         ^ (bad-whitespace)
W:246, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:246, 0: Unnecessary parens after 'print' keyword (superfluous-parens)
W:247, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:250, 0: Trailing whitespace (trailing-whitespace)
W:250, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:252, 0: Trailing whitespace (trailing-whitespace)
W:255, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:256, 0: Trailing whitespace (trailing-whitespace)
W:258, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:259, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:260, 0: Line too long (106/100) (line-too-long)
W:260, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:260, 0: Exactly one space required after comma
				cprint(self.block.getBlock(self.orignal[i][j],'Upper'),self.block.getColor(self.orignal[i][j]),end='')
                                                 ^ (bad-whitespace)
C:260, 0: Exactly one space required after comma
				cprint(self.block.getBlock(self.orignal[i][j],'Upper'),self.block.getColor(self.orignal[i][j]),end='')
                                                          ^ (bad-whitespace)
C:260, 0: Exactly one space required after comma
				cprint(self.block.getBlock(self.orignal[i][j],'Upper'),self.block.getColor(self.orignal[i][j]),end='')
                                                                                                  ^ (bad-whitespace)
W:261, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:261, 0: Unnecessary parens after 'print' keyword (superfluous-parens)
W:262, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:263, 0: Line too long (106/100) (line-too-long)
W:263, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:263, 0: Exactly one space required after comma
				cprint(self.block.getBlock(self.orignal[i][j],'Lower'),self.block.getColor(self.orignal[i][j]),end='')
                                                 ^ (bad-whitespace)
C:263, 0: Exactly one space required after comma
				cprint(self.block.getBlock(self.orignal[i][j],'Lower'),self.block.getColor(self.orignal[i][j]),end='')
                                                          ^ (bad-whitespace)
C:263, 0: Exactly one space required after comma
				cprint(self.block.getBlock(self.orignal[i][j],'Lower'),self.block.getColor(self.orignal[i][j]),end='')
                                                                                                  ^ (bad-whitespace)
C:264, 0: Trailing whitespace (trailing-whitespace)
W:264, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:264, 0: Unnecessary parens after 'print' keyword (superfluous-parens)
C:265, 0: Trailing newlines (trailing-newlines)
C:  1, 0: Missing module docstring (missing-docstring)
C:  1, 0: Multiple imports on one line (random, sys, os, time, copy) (multiple-imports)
W:  2, 0: Relative import 'Block', should be 'Assignment3.old.Block' (relative-import)
W:  3, 0: Relative import 'Person', should be 'Assignment3.old.Person' (relative-import)
C: 35, 2: Invalid attribute name "y" (invalid-name)
C: 34, 2: Invalid attribute name "x" (invalid-name)
C:  9, 0: Missing class docstring (missing-docstring)
C:  9, 0: Old-style class defined. (old-style-class)
C: 10, 1: Invalid argument name "x" (invalid-name)
C: 10, 1: Invalid argument name "y" (invalid-name)
E: 41,47: Instance of 'Bomber' has no 'man' member (no-member)
C: 43, 1: Invalid method name "moveBomber" (invalid-name)
C: 43, 1: Missing method docstring (missing-docstring)
C: 44, 2: Invalid variable name "x" (invalid-name)
C: 45, 2: Invalid variable name "y" (invalid-name)
C: 62, 1: Invalid method name "updateBomb" (invalid-name)
C: 62, 1: Missing method docstring (missing-docstring)
W:157, 2: No exception type(s) specified (bare-except)
W: 64, 3: Statement seems to have no effect (pointless-statement)
C: 79, 4: Consider using enumerate instead of iterating with range and len (consider-using-enumerate)
R: 63, 2: Too many nested blocks (7/5) (too-many-nested-blocks)
R: 63, 2: Too many nested blocks (7/5) (too-many-nested-blocks)
R: 63, 2: Too many nested blocks (8/5) (too-many-nested-blocks)
R: 63, 2: Too many nested blocks (8/5) (too-many-nested-blocks)
R: 63, 2: Too many nested blocks (6/5) (too-many-nested-blocks)
C:147, 4: Consider using enumerate instead of iterating with range and len (consider-using-enumerate)
R: 62, 1: Too many branches (31/12) (too-many-branches)
R: 62, 1: Too many statements (58/50) (too-many-statements)
C:162, 1: Invalid method name "updateEnemy" (invalid-name)
C:162, 1: Missing method docstring (missing-docstring)
C:169, 4: Invalid variable name "x" (invalid-name)
C:170, 4: Invalid variable name "y" (invalid-name)
R:162, 1: Too many branches (30/12) (too-many-branches)
R:162, 1: Too many statements (68/50) (too-many-statements)
C:255, 1: Missing method docstring (missing-docstring)
W:  1, 0: Unused import random (unused-import)
W:  1, 0: Unused import sys (unused-import)
W:  1, 0: Unused import time (unused-import)
W:  1, 0: Unused import copy (unused-import)
W:  1, 0: Unused import os (unused-import)
W:  3, 0: Unused Enemy1 imported from Person (unused-import)
W:  3, 0: Unused Enemy2 imported from Person (unused-import)
C:  4, 0: standard import "from random import randint" comes before "from Block import Block" (wrong-import-order)
C:  4, 0: Imports from package random are not grouped (ungrouped-imports)
```

## Module Assignment3.old.Bomb
```
W:  4, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:  4, 0: Exactly one space required after comma
	def __init__(self,x,y,time):
                  ^ (bad-whitespace)
C:  4, 0: Exactly one space required after comma
	def __init__(self,x,y,time):
                    ^ (bad-whitespace)
C:  4, 0: Exactly one space required after comma
	def __init__(self,x,y,time):
                      ^ (bad-whitespace)
W:  5, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:  6, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:  7, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:  9, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 10, 0: Final newline missing (missing-final-newline)
W: 10, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:  1, 0: Missing module docstring (missing-docstring)
W:  1, 0: Relative import 'Block', should be 'Assignment3.old.Block' (relative-import)
C:  6, 2: Invalid attribute name "y" (invalid-name)
C:  5, 2: Invalid attribute name "x" (invalid-name)
C:  3, 0: Missing class docstring (missing-docstring)
C:  3, 0: Old-style class defined. (old-style-class)
C:  4, 1: Invalid argument name "x" (invalid-name)
C:  4, 1: Invalid argument name "y" (invalid-name)
C:  9, 1: Missing method docstring (missing-docstring)
R:  3, 0: Too few public methods (1/2) (too-few-public-methods)
W:  1, 0: Unused Block imported from Block (unused-import)
```

## Module Assignment3.old.game
```
C:  1, 0: Trailing whitespace (trailing-whitespace)
C:  3, 0: No space allowed before comma
from asciiDrawings import instructions , thankyou, trophy
                                       ^ (bad-whitespace)
W:  8, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 10, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 11, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 12, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 13, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 14, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 15, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 17, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 18, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 19, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 20, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 21, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 22, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 23, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 24, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 25, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 28, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 31, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 34, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 34, 0: Exactly one space required after comma
	def __init__(self,level):
                  ^ (bad-whitespace)
W: 35, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 36, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 37, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 38, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 38, 0: Exactly one space required after comma
		self.board = Board(19,19,level)
                       ^ (bad-whitespace)
C: 38, 0: Exactly one space required after comma
		self.board = Board(19,19,level)
                          ^ (bad-whitespace)
W: 39, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 40, 0: Trailing whitespace (trailing-whitespace)
W: 40, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 41, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 42, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 45, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 45, 0: Exactly one space required after comma
	def input(self,timeout=1):
               ^ (bad-whitespace)
W: 46, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 47, 0: Trailing whitespace (trailing-whitespace)
W: 47, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 48, 0: Trailing whitespace (trailing-whitespace)
W: 49, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 50, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 51, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 53, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 54, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 56, 0: Trailing whitespace (trailing-whitespace)
W: 56, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 57, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 58, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 59, 0: Trailing whitespace (trailing-whitespace)
W: 59, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 61, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 62, 0: Trailing whitespace (trailing-whitespace)
W: 62, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 63, 0: Trailing whitespace (trailing-whitespace)
W: 63, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 64, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 64, 0: Exactly one space required after comma
				self.board.moveBomber(self,-1,0)
                              ^ (bad-whitespace)
C: 64, 0: Exactly one space required after comma
				self.board.moveBomber(self,-1,0)
                                 ^ (bad-whitespace)
C: 66, 0: Trailing whitespace (trailing-whitespace)
W: 66, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 67, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 67, 0: Exactly one space required after comma
				self.board.moveBomber(self,0,-1)
                              ^ (bad-whitespace)
C: 67, 0: Exactly one space required after comma
				self.board.moveBomber(self,0,-1)
                                ^ (bad-whitespace)
C: 69, 0: Trailing whitespace (trailing-whitespace)
W: 69, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 70, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 70, 0: Exactly one space required after comma
				self.board.moveBomber(self,0,1)
                              ^ (bad-whitespace)
C: 70, 0: Exactly one space required after comma
				self.board.moveBomber(self,0,1)
                                ^ (bad-whitespace)
C: 72, 0: Trailing whitespace (trailing-whitespace)
W: 72, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 73, 0: Trailing whitespace (trailing-whitespace)
W: 73, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 73, 0: Exactly one space required after comma
				self.board.moveBomber(self,1,0)			
                              ^ (bad-whitespace)
C: 73, 0: Exactly one space required after comma
				self.board.moveBomber(self,1,0)			
                                ^ (bad-whitespace)
W: 75, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 76, 0: Trailing whitespace (trailing-whitespace)
W: 76, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 76, 0: No space allowed before :
				if self.bomb == None : 				
                         ^ (bad-whitespace)
C: 77, 0: Trailing whitespace (trailing-whitespace)
W: 77, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 77, 0: Exactly one space required after comma
					self.bomb = Bomb(x,y,4)	
                       ^ (bad-whitespace)
C: 77, 0: Exactly one space required after comma
					self.bomb = Bomb(x,y,4)	
                         ^ (bad-whitespace)
W: 80, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 81, 0: Trailing whitespace (trailing-whitespace)
W: 81, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 83, 0: Trailing whitespace (trailing-whitespace)
W: 83, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 85, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 86, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 87, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 89, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 90, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 91, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 92, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 93, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 94, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 96, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 97, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 98, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 99, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:100, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:101, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:102, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:103, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:104, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:105, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:107, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:108, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:109, 0: Trailing whitespace (trailing-whitespace)
W:109, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:110, 0: Trailing whitespace (trailing-whitespace)
W:110, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:111, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:113, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:114, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:114, 0: Exactly one space required after comma
		print("		Lives:",end='')
                  ^ (bad-whitespace)
W:115, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:116, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:116, 0: Exactly one space required after comma
			cprint("\u2764 ",'red',attrs=['bold'],end='')
                   ^ (bad-whitespace)
C:116, 0: Exactly one space required after comma
			cprint("\u2764 ",'red',attrs=['bold'],end='')
                         ^ (bad-whitespace)
C:116, 0: Exactly one space required after comma
			cprint("\u2764 ",'red',attrs=['bold'],end='')
                                        ^ (bad-whitespace)
C:117, 0: Trailing whitespace (trailing-whitespace)
W:118, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:119, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:120, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:120, 0: No space allowed before :
			if ex.status != 0 :
                     ^ (bad-whitespace)
W:121, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:122, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:122, 0: Exactly one space required after comma
		print(" 	Enemies:",enemyCount,"		level:",self.board.level)
                    ^ (bad-whitespace)
C:122, 0: Exactly one space required after comma
		print(" 	Enemies:",enemyCount,"		level:",self.board.level)
                               ^ (bad-whitespace)
C:122, 0: Exactly one space required after comma
		print(" 	Enemies:",enemyCount,"		level:",self.board.level)
                                          ^ (bad-whitespace)
W:123, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:123, 0: Exactly one space required after comma
		print("		SCORE:",points," 	time:",self.time)
                  ^ (bad-whitespace)
C:123, 0: Exactly one space required after comma
		print("		SCORE:",points," 	time:",self.time)
                         ^ (bad-whitespace)
C:123, 0: Exactly one space required after comma
		print("		SCORE:",points," 	time:",self.time)
                                   ^ (bad-whitespace)
W:124, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:124, 0: Exactly one space required after comparison
		if enemyCount ==  0:
                ^^ (bad-whitespace)
W:125, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:127, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:131, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:132, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:134, 0: Trailing whitespace (trailing-whitespace)
W:134, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:135, 0: Trailing whitespace (trailing-whitespace)
W:135, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:136, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:137, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:138, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:139, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:140, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:140, 0: Unnecessary parens after 'while' keyword (superfluous-parens)
C:143, 0: Trailing whitespace (trailing-whitespace)
W:143, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:144, 0: Trailing whitespace (trailing-whitespace)
W:145, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:145, 0: Unnecessary parens after 'if' keyword (superfluous-parens)
W:146, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:147, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:148, 0: Trailing whitespace (trailing-whitespace)
W:150, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:151, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:152, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:153, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:154, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:155, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:156, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:157, 0: Trailing whitespace (trailing-whitespace)
W:157, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:158, 0: Trailing whitespace (trailing-whitespace)
W:158, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:159, 0: Trailing whitespace (trailing-whitespace)
C:161, 0: Final newline missing (missing-final-newline)
W:161, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:  1, 0: Missing module docstring (missing-docstring)
E:  1, 0: Unable to import 'Board' (import-error)
E:  2, 0: Unable to import 'Bomb' (import-error)
E:  3, 0: Unable to import 'asciiDrawings' (import-error)
C:  5, 0: Multiple imports on one line (random, sys, os, time, copy, signal) (multiple-imports)
C:  8, 1: Multiple imports on one line (tty, termios) (multiple-imports)
C: 15, 2: Invalid constant name "getch" (invalid-name)
C: 17, 1: Missing function docstring (missing-docstring)
C: 18, 2: Invalid variable name "fd" (invalid-name)
C: 22, 3: Invalid variable name "ch" (invalid-name)
C: 27, 0: Invalid function name "alarmHandler" (invalid-name)
C: 27, 0: Missing function docstring (missing-docstring)
W: 27,17: Unused argument 'signum' (unused-argument)
W: 27,25: Unused argument 'frame' (unused-argument)
C: 30, 0: Missing class docstring (missing-docstring)
C: 36, 2: Invalid attribute name "y" (invalid-name)
C: 35, 2: Invalid attribute name "x" (invalid-name)
C: 40, 2: Invalid attribute name "enemiesKilled" (invalid-name)
C: 42, 2: Invalid attribute name "GAMEOVER" (invalid-name)
C: 33, 0: Missing class docstring (missing-docstring)
R: 33, 0: Too many instance attributes (8/7) (too-many-instance-attributes)
C: 45, 1: Missing method docstring (missing-docstring)
C: 61, 3: Invalid variable name "x" (invalid-name)
C: 62, 3: Invalid variable name "y" (invalid-name)
C: 76, 7: Comparison to None should be 'expr is None' (singleton-comparison)
W: 91, 2: Redefining name 'points' from outer scope (line 134) (redefined-outer-name)
C: 89, 1: Missing method docstring (missing-docstring)
C: 96, 1: Invalid method name "gameOver" (invalid-name)
C: 96, 1: Missing method docstring (missing-docstring)
W:104, 2: No exception type(s) specified (bare-except)
C:107, 1: Invalid method name "gameWon" (invalid-name)
C:107, 1: Missing method docstring (missing-docstring)
R:107, 1: Method could be a function (no-self-use)
C:113, 1: Missing method docstring (missing-docstring)
C:118, 2: Invalid variable name "enemyCount" (invalid-name)
C:121, 4: Invalid variable name "enemyCount" (invalid-name)
C:134, 1: Invalid constant name "points" (invalid-name)
C:135, 1: Invalid constant name "lives" (invalid-name)
C:136, 1: Invalid constant name "levels" (invalid-name)
C:139, 2: Invalid constant name "game" (invalid-name)
C:146, 4: Invalid constant name "levels" (invalid-name)
C:151,31: Comparison to True should be just 'expr' or 'expr is True' (singleton-comparison)
W:155, 3: No exception type(s) specified (bare-except)
C:154, 4: Invalid constant name "points" (invalid-name)
C:157, 5: Comparison to True should be just 'expr' or 'expr is True' (singleton-comparison)
C:158, 3: Invalid constant name "lives" (invalid-name)
W:  5, 0: Unused import copy (unused-import)
W:  5, 0: Unused import random (unused-import)
C:  5, 0: standard import "import random, sys, os, time, copy, signal" comes before "from Board import Board" (wrong-import-order)
C:  5, 0: standard import "import random, sys, os, time, copy, signal" comes before "from Board import Board" (wrong-import-order)
C:  5, 0: standard import "import random, sys, os, time, copy, signal" comes before "from Board import Board" (wrong-import-order)
C:  5, 0: standard import "import random, sys, os, time, copy, signal" comes before "from Board import Board" (wrong-import-order)
C:  5, 0: standard import "import random, sys, os, time, copy, signal" comes before "from Board import Board" (wrong-import-order)
C:  5, 0: standard import "import random, sys, os, time, copy, signal" comes before "from Board import Board" (wrong-import-order)
```

## Module Assignment3.old.Person
```
W:  6, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:  6, 0: Exactly one space required after comma
	def __init__(self,man,upperPart,lowerPart,x,y):
                  ^ (bad-whitespace)
C:  6, 0: Exactly one space required after comma
	def __init__(self,man,upperPart,lowerPart,x,y):
                      ^ (bad-whitespace)
C:  6, 0: Exactly one space required after comma
	def __init__(self,man,upperPart,lowerPart,x,y):
                                ^ (bad-whitespace)
C:  6, 0: Exactly one space required after comma
	def __init__(self,man,upperPart,lowerPart,x,y):
                                          ^ (bad-whitespace)
C:  6, 0: Exactly one space required after comma
	def __init__(self,man,upperPart,lowerPart,x,y):
                                            ^ (bad-whitespace)
W:  7, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:  7, 0: Exactly one space required around assignment
		self.man=man
          ^ (bad-whitespace)
W:  8, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:  9, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 10, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 11, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 14, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 15, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 15, 0: Exactly one space required after comma
			Person.__init__(self,'b',"[^^]"," ][ ",1,1)
                       ^ (bad-whitespace)
C: 15, 0: Exactly one space required after comma
			Person.__init__(self,'b',"[^^]"," ][ ",1,1)
                           ^ (bad-whitespace)
C: 15, 0: Exactly one space required after comma
			Person.__init__(self,'b',"[^^]"," ][ ",1,1)
                                  ^ (bad-whitespace)
C: 15, 0: Exactly one space required after comma
			Person.__init__(self,'b',"[^^]"," ][ ",1,1)
                                         ^ (bad-whitespace)
C: 15, 0: Exactly one space required after comma
			Person.__init__(self,'b',"[^^]"," ][ ",1,1)
                                           ^ (bad-whitespace)
W: 18, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 18, 0: Exactly one space required after comma
	def __init__(self,x,y):
                  ^ (bad-whitespace)
C: 18, 0: Exactly one space required after comma
	def __init__(self,x,y):
                    ^ (bad-whitespace)
W: 19, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 19, 0: Exactly one space required after comma
		Person.__init__(self,'e'," ** ","||||",x,y)
                      ^ (bad-whitespace)
C: 19, 0: Exactly one space required after comma
		Person.__init__(self,'e'," ** ","||||",x,y)
                          ^ (bad-whitespace)
C: 19, 0: Exactly one space required after comma
		Person.__init__(self,'e'," ** ","||||",x,y)
                                 ^ (bad-whitespace)
C: 19, 0: Exactly one space required after comma
		Person.__init__(self,'e'," ** ","||||",x,y)
                                        ^ (bad-whitespace)
C: 19, 0: Exactly one space required after comma
		Person.__init__(self,'e'," ** ","||||",x,y)
                                          ^ (bad-whitespace)
W: 20, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 23, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 23, 0: Exactly one space required after comma
	def __init__(self,x,y):
                  ^ (bad-whitespace)
C: 23, 0: Exactly one space required after comma
	def __init__(self,x,y):
                    ^ (bad-whitespace)
W: 24, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 24, 0: Exactly one space required after comma
		Person.__init__(self,'E'," [] ","/||\\",x,y)
                      ^ (bad-whitespace)
C: 24, 0: Exactly one space required after comma
		Person.__init__(self,'E'," [] ","/||\\",x,y)
                          ^ (bad-whitespace)
C: 24, 0: Exactly one space required after comma
		Person.__init__(self,'E'," [] ","/||\\",x,y)
                                 ^ (bad-whitespace)
C: 24, 0: Exactly one space required after comma
		Person.__init__(self,'E'," [] ","/||\\",x,y)
                                         ^ (bad-whitespace)
C: 24, 0: Exactly one space required after comma
		Person.__init__(self,'E'," [] ","/||\\",x,y)
                                           ^ (bad-whitespace)
W: 25, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 26, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 27, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 28, 0: Trailing whitespace (trailing-whitespace)
W: 28, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 28, 0: No space allowed before :
		else : 
       ^ (bad-whitespace)
W: 29, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 30, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 32, 0: Exactly one space required after comma
def EnemyArray(board,level,x,y):
                    ^ (bad-whitespace)
C: 32, 0: Exactly one space required after comma
def EnemyArray(board,level,x,y):
                          ^ (bad-whitespace)
C: 32, 0: Exactly one space required after comma
def EnemyArray(board,level,x,y):
                            ^ (bad-whitespace)
W: 33, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 35, 0: Trailing whitespace (trailing-whitespace)
W: 35, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 35, 0: No space allowed before bracket
	for _ in range (2*level):		
                ^ (bad-whitespace)
C: 36, 0: Trailing whitespace (trailing-whitespace)
W: 36, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 37, 0: Trailing whitespace (trailing-whitespace)
W: 37, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 38, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 38, 0: Unnecessary parens after 'while' keyword (superfluous-parens)
W: 39, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 39, 0: Exactly one space required after comma
			a = randint(1,x-2)
                ^ (bad-whitespace)
W: 40, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 40, 0: Exactly one space required after comma
			b = randint(1,y-2)
                ^ (bad-whitespace)
W: 42, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 42, 0: Exactly one space required after comma
		if _ < max(level -2,1) :
                     ^ (bad-whitespace)
C: 42, 0: No space allowed before :
		if _ < max(level -2,1) :
                         ^ (bad-whitespace)
W: 43, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 43, 0: Exactly one space required after comma
			enemy.append(Enemy1(a,b))
                        ^ (bad-whitespace)
W: 44, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 45, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 46, 0: Trailing whitespace (trailing-whitespace)
W: 46, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 46, 0: Exactly one space required after comma
			enemy.append(Enemy2(a,b))	
                        ^ (bad-whitespace)
W: 47, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 48, 0: Trailing whitespace (trailing-whitespace)
W: 49, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:  1, 0: Missing module docstring (missing-docstring)
C: 11, 2: Invalid attribute name "y" (invalid-name)
C: 10, 2: Invalid attribute name "x" (invalid-name)
C:  8, 2: Invalid attribute name "upperPart" (invalid-name)
C:  9, 2: Invalid attribute name "lowerPart" (invalid-name)
C:  5, 0: Missing class docstring (missing-docstring)
C:  5, 0: Old-style class defined. (old-style-class)
C:  6, 1: Invalid argument name "upperPart" (invalid-name)
C:  6, 1: Invalid argument name "lowerPart" (invalid-name)
C:  6, 1: Invalid argument name "x" (invalid-name)
C:  6, 1: Invalid argument name "y" (invalid-name)
R:  6, 1: Too many arguments (6/5) (too-many-arguments)
R:  5, 0: Too few public methods (0/2) (too-few-public-methods)
C: 50, 3: Invalid attribute name "y" (invalid-name)
C: 49, 3: Invalid attribute name "x" (invalid-name)
C: 13, 0: Missing class docstring (missing-docstring)
C: 13, 0: Old-style class defined. (old-style-class)
W: 15, 3: __init__ method from a non direct base class 'Person' is called (non-parent-init-called)
R: 13, 0: Too few public methods (0/2) (too-few-public-methods)
C: 17, 0: Missing class docstring (missing-docstring)
C: 17, 0: Old-style class defined. (old-style-class)
C: 18, 1: Invalid argument name "x" (invalid-name)
C: 18, 1: Invalid argument name "y" (invalid-name)
W: 19, 2: __init__ method from a non direct base class 'Person' is called (non-parent-init-called)
R: 17, 0: Too few public methods (0/2) (too-few-public-methods)
C: 22, 0: Missing class docstring (missing-docstring)
C: 22, 0: Old-style class defined. (old-style-class)
C: 23, 1: Invalid argument name "x" (invalid-name)
C: 23, 1: Invalid argument name "y" (invalid-name)
W: 24, 2: __init__ method from a non direct base class 'Person' is called (non-parent-init-called)
R: 22, 0: Too few public methods (0/2) (too-few-public-methods)
C: 32, 0: Invalid function name "EnemyArray" (invalid-name)
C: 32, 0: Invalid argument name "x" (invalid-name)
C: 32, 0: Invalid argument name "y" (invalid-name)
C: 32, 0: Missing function docstring (missing-docstring)
C: 36, 2: Invalid variable name "a" (invalid-name)
C: 37, 2: Invalid variable name "b" (invalid-name)
C: 39, 3: Invalid variable name "a" (invalid-name)
C: 40, 3: Invalid variable name "b" (invalid-name)
************* Module Assignment3.old.tests.test_Person
W: 13, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 13, 0: Exactly one space required after comma
	test_bomber = Person('b',"[^^]"," ][ ",1,1)
                         ^ (bad-whitespace)
C: 13, 0: Exactly one space required after comma
	test_bomber = Person('b',"[^^]"," ][ ",1,1)
                                ^ (bad-whitespace)
C: 13, 0: Exactly one space required after comma
	test_bomber = Person('b',"[^^]"," ][ ",1,1)
                                       ^ (bad-whitespace)
C: 13, 0: Exactly one space required after comma
	test_bomber = Person('b',"[^^]"," ][ ",1,1)
                                         ^ (bad-whitespace)
W: 14, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 18, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 18, 0: Exactly one space required after comma
	x = randint(1,100)
              ^ (bad-whitespace)
W: 19, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 19, 0: Exactly one space required after comma
	y = randint(1,100)
              ^ (bad-whitespace)
W: 20, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 20, 0: Exactly one space required after comma
	test_bomber = Enemy1(x,y)
                       ^ (bad-whitespace)
W: 21, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W: 24, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 24, 0: Exactly one space required after comma
	test_bomber = Person('b',"[^^]"," ][ ",1,1)
                         ^ (bad-whitespace)
C: 24, 0: Exactly one space required after comma
	test_bomber = Person('b',"[^^]"," ][ ",1,1)
                                ^ (bad-whitespace)
C: 24, 0: Exactly one space required after comma
	test_bomber = Person('b',"[^^]"," ][ ",1,1)
                                       ^ (bad-whitespace)
C: 24, 0: Exactly one space required after comma
	test_bomber = Person('b',"[^^]"," ][ ",1,1)
                                         ^ (bad-whitespace)
C: 25, 0: Final newline missing (missing-final-newline)
W: 25, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:  1, 0: Invalid module name "test_Person" (invalid-name)
C:  1, 0: Missing module docstring (missing-docstring)
C:  5, 0: Import "from random import randint" should be placed at the top of the module (wrong-import-position)
E:  6, 0: Unable to import 'Person' (import-error)
C:  6, 0: Import "from Person import Person" should be placed at the top of the module (wrong-import-position)
E:  7, 0: Unable to import 'Person' (import-error)
C:  7, 0: Import "from Person import Bomber" should be placed at the top of the module (wrong-import-position)
E:  8, 0: Unable to import 'Person' (import-error)
C:  8, 0: Import "from Person import Enemy1" should be placed at the top of the module (wrong-import-position)
E:  9, 0: Unable to import 'Person' (import-error)
C:  9, 0: Import "from Person import EnemyArray" should be placed at the top of the module (wrong-import-position)
C: 12, 0: Invalid function name "test_Bomber" (invalid-name)
C: 12, 0: Missing function docstring (missing-docstring)
E: 17, 0: function already defined line 12 (function-redefined)
C: 17, 0: Invalid function name "test_Bomber" (invalid-name)
C: 17, 0: Missing function docstring (missing-docstring)
C: 18, 1: Invalid variable name "x" (invalid-name)
C: 19, 1: Invalid variable name "y" (invalid-name)
E: 23, 0: function already defined line 12 (function-redefined)
C: 23, 0: Invalid function name "test_Bomber" (invalid-name)
C: 23, 0: Missing function docstring (missing-docstring)
W:  7, 0: Unused Bomber imported from Person (unused-import)
W:  9, 0: Unused EnemyArray imported from Person (unused-import)
```

# Report
351 statements analysed.

## Statistics by type
```
+---------+-------+-----------+-----------+------------+---------+
|type     |number |old number |difference |%documented |%badname |
+=========+=======+===========+===========+============+=========+
|module   |8      |8          |=          |25.00       |25.00    |
+---------+-------+-----------+-----------+------------+---------+
|class    |7      |7          |=          |0.00        |0.00     |
+---------+-------+-----------+-----------+------------+---------+
|method   |14     |14         |=          |50.00       |35.71    |
+---------+-------+-----------+-----------+------------+---------+
|function |7      |7          |=          |0.00        |57.14    |
+---------+-------+-----------+-----------+------------+---------+


```
## External dependencies

    Assignment3 
      \-old 
        \-Block (Assignment3.old.Board,Assignment3.old.Bomb)
        \-Person (Assignment3.old.Board)
    termcolor (Assignment3.old.Board,Assignment3.old.asciiDrawings)



##Raw metrics
```
+----------+-------+------+---------+-----------+
|type      |number |%     |previous |difference |
+==========+=======+======+=========+===========+
|code      |375    |73.96 |375      |=          |
+----------+-------+------+---------+-----------+
|docstring |0      |0.00  |0        |=          |
+----------+-------+------+---------+-----------+
|comment   |10     |1.97  |10       |=          |
+----------+-------+------+---------+-----------+
|empty     |122    |24.06 |122      |=          |
+----------+-------+------+---------+-----------+
```


## Duplication

```
+-------------------------+------+---------+-----------+
|                         |now   |previous |difference |
+=========================+======+=========+===========+
|nb duplicated lines      |0     |0        |=          |
+-------------------------+------+---------+-----------+
|percent duplicated lines |0.000 |0.000    |=          |
+-------------------------+------+---------+-----------+
```


## Messages by category

```
+-----------+-------+---------+-----------+
|type       |number |previous |difference |
+===========+=======+=========+===========+
|convention |434    |434      |=          |
+-----------+-------+---------+-----------+
|refactor   |19     |19       |=          |
+-----------+-------+---------+-----------+
|warning    |375    |375      |=          |
+-----------+-------+---------+-----------+
|error      |8      |8        |=          |
+-----------+-------+---------+-----------+
```


## % errors / warnings by module

```
+----------------------------------+------+--------+---------+-----------+
|module                            |error |warning |refactor |convention |
+==================================+======+========+=========+===========+
|Assignment3.old.tests.test_Person |75.00 |2.67    |0.00     |6.22       |
+----------------------------------+------+--------+---------+-----------+
|Assignment3.old.Board             |12.50 |51.47   |47.37    |31.80      |
+----------------------------------+------+--------+---------+-----------+
|Assignment3.old.game              |12.50 |0.00    |0.00     |0.00       |
+----------------------------------+------+--------+---------+-----------+
|Assignment3.old.asciiDrawings     |0.00  |19.47   |0.00     |33.18      |
+----------------------------------+------+--------+---------+-----------+
|Assignment3.old.Block             |0.00  |14.67   |21.05    |8.99       |
+----------------------------------+------+--------+---------+-----------+
|Assignment3.old.Person            |0.00  |9.60    |26.32    |17.05      |
+----------------------------------+------+--------+---------+-----------+
|Assignment3.old.Bomb              |0.00  |2.13    |5.26     |2.76       |
+----------------------------------+------+--------+---------+-----------+
```


# Messages

```
+-----------------------------------+------------+
|message id                         |occurrences |
+===================================+============+
|mixed-indentation                  |329         |
+-----------------------------------+------------+
|bad-whitespace                     |197         |
+-----------------------------------+------------+
|trailing-whitespace                |112         |
+-----------------------------------+------------+
|invalid-name                       |55          |
+-----------------------------------+------------+
|missing-docstring                  |27          |
+-----------------------------------+------------+
|anomalous-unicode-escape-in-string |16          |
+-----------------------------------+------------+
|line-too-long                      |14          |
+-----------------------------------+------------+
|unused-import                      |10          |
+-----------------------------------+------------+
|bad-indentation                    |10          |
+-----------------------------------+------------+
|superfluous-parens                 |8           |
+-----------------------------------+------------+
|old-style-class                    |7           |
+-----------------------------------+------------+
|wrong-import-position              |5           |
+-----------------------------------+------------+
|too-many-nested-blocks             |5           |
+-----------------------------------+------------+
|too-few-public-methods             |5           |
+-----------------------------------+------------+
|import-error                       |4           |
+-----------------------------------+------------+
|relative-import                    |3           |
+-----------------------------------+------------+
|non-parent-init-called             |3           |
+-----------------------------------+------------+
|missing-final-newline              |3           |
+-----------------------------------+------------+
|too-many-statements                |2           |
+-----------------------------------+------------+
|too-many-return-statements         |2           |
+-----------------------------------+------------+
|too-many-branches                  |2           |
+-----------------------------------+------------+
|function-redefined                 |2           |
+-----------------------------------+------------+
|consider-using-enumerate           |2           |
+-----------------------------------+------------+
|anomalous-backslash-in-string      |2           |
+-----------------------------------+------------+
|wrong-import-order                 |1           |
+-----------------------------------+------------+
|ungrouped-imports                  |1           |
+-----------------------------------+------------+
|trailing-newlines                  |1           |
+-----------------------------------+------------+
|too-many-instance-attributes       |1           |
+-----------------------------------+------------+
|too-many-arguments                 |1           |
+-----------------------------------+------------+
|syntax-error                       |1           |
+-----------------------------------+------------+
|pointless-statement                |1           |
+-----------------------------------+------------+
|no-self-use                        |1           |
+-----------------------------------+------------+
|no-member                          |1           |
+-----------------------------------+------------+
|multiple-imports                   |1           |
+-----------------------------------+------------+
|bare-except                        |1           |
+-----------------------------------+------------+
```


# Global evaluation
-----------------
Your code has been rated at -14.73/10 (previous run: -14.73/10, +0.00)

