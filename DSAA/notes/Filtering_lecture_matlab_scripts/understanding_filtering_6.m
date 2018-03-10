% make our noisy function
t = linspace(1,10,1024);
x = -(t-5).^2  + 2;
y = awgn(x,0.5); 
Y = fft(y);

r = 50; % range of frequencies we want to preserve

rectangle = zeros(size(Y));
rectangle(1:r+1) = 1;               % only first half is considered here
y_half = ifft(Y.*rectangle);   % low-pass filtered signal (conjugate not considered)
rectangle(end-r+1:end) = 1;         % preserve low -ve frequencies (considering conjugate here)
y_rect = ifft(Y.*rectangle);   % low-pass filtered signal

hold on;
plot(t,y,'g--'); plot(t,x,'k','LineWidth',2); plot(t,y_half,'b','LineWidth',2); plot(t,y_rect,'r','LineWidth',2);
legend('noisy signal','true signal','+ve low-pass','full low-pass','Location','southwest')