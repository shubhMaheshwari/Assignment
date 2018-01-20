
img = imread('./cameraman.png');
imshow(img)
size(img);

M = [1 2 1; 0 0 0; -1 -2 -1];
M = double(M);

new_img = conv2(M,img);
new_img1 = mat2gray(new_img);

new_img = conv2(M',img);
new_img2 = mat2gray(new_img);
imshowpair(new_img1,new_img2,'montage')


