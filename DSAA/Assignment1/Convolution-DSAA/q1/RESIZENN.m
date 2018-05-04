
function new_img = q1_nn(img,X)

size_img = size(img);
size_img(1:2) = floor(X*size_img(1:2));

r = 1:size_img(1);
c = 1:size_img(2);
rf = 1+ floor((r-1)/X);
cf = 1+ floor((c-1)/X);

new_img(r,c,:) = img(rf,cf,:);

end
