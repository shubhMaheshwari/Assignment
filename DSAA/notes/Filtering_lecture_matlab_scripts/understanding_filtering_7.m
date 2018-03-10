% Same examples using fftshift 

t = linspace(1,10,1024);
x = -(t-5).^2  + 2; 
y = awgn(x,0.5); % adding noise
Y = fft(y);
Y = fftshift(Y);

r = 20; % range of frequencies we want to preserve

rectangle = zeros(size(Y));
rectangle(size(Y,2)/2-r/2:size(Y,2)/2+r/2) = 1;  % low pass filter design
Y1 = Y.*rectangle;

y_rect = ifft(ifftshift(Y1),1024);   % low-pass filtered signal

hold on;
plot(t,y,'g--'); plot(t,x,'k','LineWidth',2); plot(t,y_rect,'r','LineWidth',2);
legend('noisy signal','true signal','+ve low-pass','full low-pass','Location','southwest')