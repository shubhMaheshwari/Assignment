% 1. Run as it is and observe what is happening
% 2. Try changing the coefficient of the higher frequency part and observe what
% happens (try making it 4 instead of 0.25)

t = [0:1/320:3-1/320];  % sampling in time
x = 5+ 2*cos(2*pi*t-pi/2) + 0.25*cos(100*pi*t); % generation of discrete signal

Y = fft(x); % computing fft
Y = fftshift(Y);  % rearranging the transformed output (center as DC term)

r = 20; % range of frequencies we want to preserve
rectangle = zeros(1,size(x,2));
rectangle(size(Y,2)/2-r/2:size(Y,2)/2+r/2) = 1; % preserve low frequencies (rect function)

Y1 = Y.*rectangle; % Multiplying with rect in transformed domain
y_rect = ifft(ifftshift(Y1));   % Low-pass filtered signal ()

hold on;
plot(t,x,'b--'); plot(t,y_rect,'r','LineWidth',2);
legend('noisy signal','low-pass filtered','Location','southwest')


%%%%% High pass filtering


r = 20; % range of frequencies we want to preserve
rectangle = ones(1,size(x,2));
rectangle(size(Y,2)/2-r/2:size(Y,2)/2+r/2) = 0; % preserve low frequencies (rect function)

Y1 = Y.*rectangle; % Multiplying with rect in transformed domain
y_rect = ifft(ifftshift(Y1));   % Low-pass filtered signal ()

figure,
hold on;
plot(t,x,'b--'); plot(t,y_rect,'r','LineWidth',2);
legend('noisy signal','low-pass filtered','Location','southwest')