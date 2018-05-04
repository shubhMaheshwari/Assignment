
img = imread('./Faces.jpg');
image(img)
img = rgb2gray(img);



sub_img = imread('./F1.jpg');
image(sub_img)
sub_img = rgb2gray(sub_img);


new_img = normxcorr2(sub_img(:,:,1),img(:,:,1));

[val,p] = max(new_img(:));
x = floor(p/size(new_img,1))
y = p - x*size(new_img,1)



imshow(new_img);
hold on;
% Then, from the help:
rectangle('Position',[x - size(sub_img,1)/2,y - size(sub_img,2)/2,size(sub_img,1),size(sub_img,2)],...
          'Curvature',[0.8,0.4],...
         'LineWidth',2,'LineStyle','--','EdgeColor','r')

imshow(img);
hold on;
% Then, from the help:
rectangle('Position',[x - size(sub_img,1),y - size(sub_img,2),size(sub_img,1),size(sub_img,2)],...
          'Curvature',[0.8,0.4],...
         'LineWidth',2,'LineStyle','--','EdgeColor','r')


