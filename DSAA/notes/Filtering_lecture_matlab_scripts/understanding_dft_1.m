fs = 400;
t = 0:1/fs:2-1/fs;

f1 = 30;
f2 = 40;
f3 = 70;

x = 4+ 5*cos(2*pi*f1*t+0.2) + 1*cos(2*pi*f2*t -0.3) + 2*cos(2*pi*f3*t + 2.4);

X = fft(x);

X_mag = abs(X);

X_phase = angle(X);

%%%%% padding with zeros

fs = 1000;
t = 0:1/fs:1-1/fs;

f1 = 20;
f2 = 30;
f3 = 40;

x = 3*cos(2*pi*f1*t+0.2) + 1*cos(2*pi*f2*t -0.3) + 2*cos(2*pi*f3*t + 2.4);

xp = padarray(x,[0 1000], 'both');

Xp = fft(xp);

Xp_mag = abs(Xp);

Xp_phase = angle(Xp);



