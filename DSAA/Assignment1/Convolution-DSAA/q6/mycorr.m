function new_img = mycorr( a,b )

new_img = zeros(size(b));

img = double(b);
FILTER = double(a);
size_FILTER = size(FILTER);
size_img = size(img);

for j = 1:size_img(2)-size_FILTER(2)
    for i = 1:size_img(1)-size_FILTER(1)
       new_img(i,j) = sum(sum(FILTER.*img(i:i+size_FILTER(1)-1,j:j+size_FILTER(2)-1)));
    end
end
% We have to normalize the answer 
new_img(1:10)
new_img = new_img./sqrt(sum(sum(img.^2))*sum(sum(FILTER.^2)));
        
new_img = cast(new_img,'like',b);
        
end