% 1. Run as it is and observe what is happening
% 2. Try changing the coefficient of the higher frequency part and observe what
% happens (try making it 4 instead of 0.25)

t = [0:1/320:3-1/320];  % sampling in time
x = 5+ 2*cos(2*pi*t-pi/2) + 0.25*cos(100*pi*t); % generation of discrete signal
%x1 = awgn(x,0.5);

Y = fft(x); % computing fft

r = 20; % range of frequencies we want to preserve
rectangle = zeros(1,size(x,2));
rectangle(1:r) = 1; % preserve low frequencies (rect function)
rectangle(960-r:960) = 1;

Y1 = Y.*rectangle; % Multiplying with rect in transformed domain
y_rect = ifft(Y1);   % Low-pass filtered signal ()


hold on;
plot(t,x,'b--'); plot(t,y_rect,'r','LineWidth',2);
legend('noisy signal','low-pass filtered','Location','southwest')


%%%% High pass filtering

r = 20; % range of frequencies we want to preserve
rectangle = ones(1,size(x,2));
rectangle(1:r) = 0; % remove low frequencies (rect function)
rectangle(960-r:960)=0;

Y2 = Y.*rectangle; % Multiplying with rect in transformed domain
y_rect1 = ifft(Y2);   % Low-pass filtered signal ()


figure,
hold on;
plot(t,x,'b--'); plot(t,y_rect1,'r','LineWidth',2);
legend('noisy signal','high-pass filtered','Location','southwest')