load('./q2.mat')
audio_x = audioplayer(X,41400);
% play(audio_x);
subplot(4,1,1);
plot(X);

% Compute the fourier transform and plot it.
f_x = fft(X);
subplot(4,1,2);
% f_x = fftshift(f_x);
plot(abs(f_x));

[val,f] = sort(abs(f_x));
% We notice 4 signal with high frequency amplitude 
val(end-3:end);
% Hence their are frequency:
f(end-3:end) 

% Frequency
% Multiply with a rect function for bandwidth 700-1400 , 11000-end

rect = zeros(size(f_x));
rect(700:1400) = 1;
rect(end-12000:end) = 1;
subplot(4,1,3);
plot(abs(f_x.*rect));


% and do inverse fourier transform to remove noise
y = ifft(f_x.*rect);
subplot(4,1,4);
plot(real(y));

% Convert to audio 
audio_r = audioplayer(real(y),Fs);
audiowrite('result.wav',real(y),Fs);
% Uncomment to play the new and old sound
% play(audio_x);
play(audio_r);
