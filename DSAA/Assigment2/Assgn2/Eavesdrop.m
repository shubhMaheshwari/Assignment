function [ result ] = Eavesdrop( samplefile )
audinfo = audioinfo(samplefile);
winLen = audinfo.TotalSamples/audinfo.SampleRate;

result = uint64(0);
s0 = fft(audioread('q5/0.ogg'));
s1 = fft(audioread('q5/1.ogg'));
s2 = fft(audioread('q5/2.ogg'));
s3 = fft(audioread('q5/3.ogg'));
s4 = fft(audioread('q5/4.ogg'));
s5 = fft(audioread('q5/5.ogg'));
s6 = fft(audioread('q5/6.ogg'));
s7 = fft(audioread('q5/7.ogg'));
s8 = fft(audioread('q5/8.ogg'));
s9 = fft(audioread('q5/9.ogg'));

array = [s0, s1, s2, s3, s4, s5, s6, s7, s8, s9];
s = size(array);
len = s(2);

for i = 0:winLen - 1
    [window,f] = audioread(samplefile,[i*audinfo.SampleRate + 1,(i+1)*audinfo.SampleRate]);
    temp = 0;
    max = 0;
    pos = -1;
    for j = 1:len
        temp = dot(fft(window),array(:,j));
        if temp > max
            max = temp;
            pos = j;
        end
    end
    result = result*10 + (pos - 1);
end
end