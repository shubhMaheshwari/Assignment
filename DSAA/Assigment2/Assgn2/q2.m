load q2/q2.mat
x=X;
fs=Fs;
len=length(x);
% Apply simple averaging which help to reduce the intensity of the high frequency
% noise if contains
for i=1:1
for j=2:len-1
x(j,i) = (x(j-1,i) + x(j,i) + x(j+1,i))/3 ;
end
end
% Creating Gaussian window of size 20
g = gausswin(20);
% Apply convolution using Gaussian filter
g = g/sum(g);
y= conv(x(:,1), g, 'same');
% Apply signal smoothing using Savitzky-Golay smoothing filter.
result=sgolayfilt(y,1,17);
% resultant signal can be write to the new file
audiowrite('result.wav',result,fs);
% plot the resultant and original signal
plot(x);title('original');
figure; plot(result); title('resultant signal');
audiowrite('initial.wav',X,Fs);

ff=fft(X);
P2=abs(ff/len);
P1 = P2(1:len/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(len/2))/len;
plot(f,P1) 
xlabel('f (Hz)')
ylabel('|P1(f)|')

ff2 = fft(result);
P22 = abs(ff2/len);
P11 = P22(1:len/2+1);
P11(2:end-1) = 2*P11(2:end-1);
f2 = Fs*(0:(len/2))/len;
plot(f2,P11)
xlabel('f2 (Hz)')
ylabel('|P11(f)|')