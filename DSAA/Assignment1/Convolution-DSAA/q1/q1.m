  
function new_img = q1(img,X)
prompt = '1. Nearest Neighbour or 2. Biliener:';
x = input(prompt)
if x == 1
    new_img = RESIZENN(img,X);
elseif x == 2
    new_img = RESIZEBL(img,X);
else
    disp("Choose interpolation using 1 or 2");
    new_img = q1(img,X);
end
