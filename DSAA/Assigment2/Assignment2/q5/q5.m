function [ result ] = q5(input)
AudioData =     audioinfo(input);
numNum = AudioData.TotalSamples/AudioData.SampleRate;

read0 = audioread('q5/0.ogg');
read1 = audioread('q5/1.ogg');
read2 = audioread('q5/2.ogg');
read3 = audioread('q5/3.ogg');
read4 = audioread('q5/4.ogg');
read5 = audioread('q5/5.ogg');
read6 = audioread('q5/6.ogg');
read7 = audioread('q5/7.ogg');
read8 = audioread('q5/8.ogg');
read9 = audioread('q5/9.ogg');

array = [fft(read0), fft(read1), fft(read2), fft(read3), fft(read4), fft(read5), fft(read6), fft(read7), fft(read8), fft(read9)];
len = size(array,2);
result = uint64(0);

for i = 1:numNum
    [window,f] = audioread(input,[(i-1)*AudioData.SampleRate + 1,i*AudioData.SampleRate]);
    max = -100000;
    pos = -1;
    for j = 1:len
        temp = dot(array(:,j),fft(window));
        if temp > max
            pos = j;
            max = temp;
        end
    end
    result = result*10 + (pos - 1);
end

end