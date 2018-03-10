t = [0:1/320:3-1/320];
x = 5+ 2*cos(2*pi*t-pi/2); % original discrete signal
xn = 5+ 2*cos(2*pi*t-pi/2) + 0.25*cos(100*pi*t); % original discrete signal


lambda = 0.95;
b = 1-lambda;
a = [1 -lambda];

y = filter(b,a,xn);

figure
t = 1:length(x);
plot(t,xn,'--',t,y,'-'),grid on
legend('Original Data','Smoothed Data','Location','NorthWest')
title('Plot of Original and Smoothed Data')