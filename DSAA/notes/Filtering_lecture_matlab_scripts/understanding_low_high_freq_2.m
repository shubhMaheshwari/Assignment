t = [0:1/320:3-1/320];  % sampling in time

x = 5 + 2*cos(2*pi*t - pi/2);

x1 =  5 + 2*cos(2*pi*t - pi/2) + 3*cos(100*pi*t -pi/2);
x2 = 3*cos(100*pi*t -pi/2);