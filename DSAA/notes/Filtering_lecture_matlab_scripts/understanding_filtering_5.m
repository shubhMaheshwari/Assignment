% Moving average example 

% 1. Run the code and observe the shift in filtered signal
% 2. Uncomment the lower part of the code, compare the results (no shift)
% 3. Change parameters like moving average window length and play around with the code 

t = [0:1/320:3-1/320];
x = 5+ 2*cos(2*pi*t-pi/2); % original discrete signal
xn = 5+ 2*cos(2*pi*t-pi/2) + 0.25*cos(100*pi*t); % original discrete signal
%n = 1-2*rand(1,size(x,2)); % noise
%xn = x+n;  % noisy signal

% figure, subplot(2,1,1), plot(x)
% subplot(2,1,2), plot(xn)

% Moving average
s = 80;
h = 1/s*ones([1 s]);
y1 = filter(h, 1, xn);

figure, subplot(3,1,1), plot(x)
axis tight
subplot(3,1,2), plot(xn)
axis tight
subplot(3,1,3), plot(y1)
axis tight

