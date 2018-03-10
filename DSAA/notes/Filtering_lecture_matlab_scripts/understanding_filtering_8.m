% Using a gaussian filter instead (observe that the ripples are gone)

t = linspace(1,10,1024);
x = -(t-5).^2  + 2; 
y = awgn(x,0.5); % adding noise
Y = fft(y);
Y = fftshift(Y);

gauss = exp(-([1:1024]-512).^2/50);
Y1 = Y.*gauss;
y_rect = ifft(ifftshift(Y1));   % gaussian low-pass filtered signal

hold on;
plot(t,y,'g--'); plot(t,x,'k','LineWidth',2); plot(t,y_rect,'r','LineWidth',2);
legend('noisy signal','true signal','+ve low-pass','full low-pass','Location','southwest')