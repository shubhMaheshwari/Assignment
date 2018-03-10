% Moving average example 

t = [0:1/320:3-1/320];
x = 5+ 2*cos(2*pi*t-pi/2); % original discrete signal
xn = 5+ 2*cos(2*pi*t-pi/2) + 0.25*cos(100*pi*t); % original discrete signal


M = 80;
b = 1/M*ones([1 M]);
a = [1];
y1 = filter(b, a, xn);

figure
t = 1:length(x);
plot(t,xn,'--',t,y1,'-'),grid on
legend('Original Data','Smoothed Data','Location','NorthWest')
title('Plot of Original and Smoothed Data')

% figure, subplot(3,1,1), plot(x)
% axis tight
% subplot(3,1,2), plot(xn)
% axis tight
% subplot(3,1,3), plot(y1)
% axis tight

