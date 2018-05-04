im = double((rgb2gray(imread('dither1.jpg'))));

im1 = im;
im1(find(im>128))=255;
im1(find(im<=128))=0;

n = 255*(rand([1055 820])-0.5);
im2 = im + n;
im3 = im2;
im3(find(im2>128))=255;
im3(find(im2<=128))=0;








