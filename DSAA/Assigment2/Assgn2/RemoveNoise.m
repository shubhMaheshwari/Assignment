%Filter
function [result] = RemoveNoise(fileName)
noise_image = (imread(fileName));
% to see noisy image
% subplot(221);
% imshow(noise_image);
noise_red = noise_image(:,:,1);
%noise_green = noise_image(:,:,2);
%noise_blue = noise_image(:,:,3);
fft_red = fftshift(fft2(noise_red));
%fft_green = fftshift(fft2(noise_green));
%fft_blue = fftshift(fft2(noise_blue));
% to see fft of the noisy image
% f = mat2gray(log(abs(fft_red)+1));
%subplot(222);
%imshow(f);
row = size(noise_image, 1);
col = size(noise_image, 2);
a = uint8(zeros(row,col));
filter = double(ones(row,col)); 
len = 100;     % length of noise bands

b = 2;
filter(ceil(row/2)-b:ceil(row/2)+b, 1:len) = 0.0;
filter(ceil(row/2)-b:ceil(row/2)+b, col-len:col) = 0.0;

b = 1;      % breadth/2 of noise bands
filter(1:len, ceil(col/2)-b+1:ceil(col/2)+b+1) = 0.0;
filter(row-len:row, ceil(col/2)-b+1:ceil(col/2)+b+1) = 0.0;

% to see the filter
%subplot(223);
%imshow(filter);
filtered_red = fft_red.*filter;
%filtered_green = fft_green.*filter;
%filtered_blue = fft_blue.*filter;

red = (abs(ifft2(ifftshift(filtered_red))));
%green = (abs(ifft2(ifftshift(filtered_green))));
%blue = (abs(ifft2(ifftshift(filtered_blue))));

result = cat(1, uint8(red));%, uint8(green), uint8(blue));
% subplot(224);
imshow(result, []);

end
