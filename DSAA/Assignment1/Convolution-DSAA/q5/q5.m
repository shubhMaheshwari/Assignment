
M = [1,2,1;0,0,0;-1,-2,-1]

img = imread('./sample_inp.png');
new_img = myconv(M,img);

imshow(new_img);

blur = imread('./blur.jpg');
ver_blur = myconv(M,blur);
imshow(ver_blur*5)

hor_blur = myconv(M',blur);
imshow(hor_blur*5)

fin_blur = ver_blur + hor_blur;
imshow(fin_blur.*5)

img = imread('./Faces.jpg');
ver_img = myconv(M,img);
hor_img = myconv(M',img);
fin_img = ver_img + hor_img;
imshow(fin_img.*5)

img = imread('./War_on_drugs.png');
ver_img = myconv(M,img);
hor_img = myconv(M',img);
fin_img = ver_img + hor_img;
imshow(fin_img.*5)

fin_img = conv2([1,1,1;1,1,1;1,1,1]./9,fin_img);
imshow(fin_img)
