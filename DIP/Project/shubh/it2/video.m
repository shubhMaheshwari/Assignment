clc;
close all;
clear all;

a=VideoReader('10sec.mp4');
for img = 15:1:a.NumberOfFrames-30
    filename=sprintf('frames/%02d.jpg',img);
    b = read(a, img);
    b = imresize(b, [255 NaN]);
    imwrite(b,filename);
end

b = imread(sprintf('frames/%02d.jpg',15));
b = b*1.5;
imwrite(b,sprintf('frames/output/%02d.jpg',15));

clc;
close all;
clear all;

for i=16:219
    imr = imread(sprintf('frames/output/%02d.jpg',15));
    ims = imread(sprintf('frames/%02d.jpg',i));
    im = uint8(CalAns(ims,imr));
    imwrite(im, sprintf('frames/output/%02d.jpg',i));
end