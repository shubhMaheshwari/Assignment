% We will first implement a simple Fourier transform.
% Sampling Frequency 
fs = 50;
% Frequency
N = 50;
n = 0:N*fs -1/fs;

t = 2*pi*[0:1/fs:N-1/fs];
y = sin(t) + cos(5*t);

% Hence the formula of Fourier transform is
ft_mat = exp(-1i*2*pi*n'*n/(N*fs));
y_ft = y*ft_mat;

figure;
subplot(4,1,1);
plot(y);
title('Original Signal');

subplot(4,1,2);
plot(abs(y_ft));
title('Fourier Domain');

% Using FFT 
y_fft = NEWFFT(y,n,N*fs);
subplot(4,1,3);
plot(abs(y_fft));
title('Fast Fourier Transform');

% Using Matlabs fft
y_mat = fft(y);
subplot(4,1,4);
plot(abs(y_mat));
title('Fast Fourier Transform(Matlab)');

figure;
% Next we implement fourier transform for 2d images
img = imread('./cameraman.png');
subplot(3,1,1);
imshow(img);
title('Original Image');
% Conver to double for arithmatic issues
img = double(img);

% My implementation
new_image = NEW_FFT2(img);

% Matlab Solution
new_image_matlab = fft2(img);

% Plot them

subplot(3,1,2);
plot(new_image);
title('My Method');
subplot(3,1,3);
plot(new_image_matlab);
title('Matlab');


figure;
% Next example
img = imread('./War_on_drugs.png');
subplot(3,1,1);
imshow(img);
title('Original Image');
% Conver to double for arithmatic issues
img = double(img);

% My implementation
new_image = NEW_FFT2(img);

% Matlab Solution
new_image_matlab = fft2(img);

% Plot them

subplot(3,1,2);
plot(new_image);
title('My Method');
subplot(3,1,3);
plot(new_image_matlab);
title('Matlab');