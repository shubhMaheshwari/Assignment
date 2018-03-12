% Show fourier transform the following images

figure;
subplot(2,1,1);
img = imread('./Img1a.png');
fourier_transform(img);

subplot(2,1,2);
img = imread('./Img1b.png');
fourier_transform(img);

figure;
subplot(2,1,1);
img = imread('./Img2a.png');
fourier_transform(img);

subplot(2,1,2);
img = imread('./Img2b.png');
fourier_transform(img);

figure;
img = imread('./Img3.png');
for i = 1:3
new_img(:,:,i) = medfilt2(img(:,:,i));
end
imgaussfilt(new_img,1.5);
imshowpair(img,new_img,'montage');
