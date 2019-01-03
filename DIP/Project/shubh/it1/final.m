clc;
close all;
clear all;

dirname = 'family\';
files = dir(strcat(dirname,'*.??g'));
ct = 0;
for file = files'
    ct = ct+1;
    im_set{ct} = imread(strcat(dirname,file.name));
end

for i=1:ct
    im_set{i} = imresize(im_set{i}, [300 NaN]);
end

o = im_set{1};
for i=2:ct
    o = [o, im_set{i}];
end

imwrite(o,strcat(dirname, 'output\input.jpg'));

W = zeros(ct,ct);

adj_mat = zeros(ct,ct);
for i=2:ct
    for j=1:i-1
        [M,w,TT] = Affinity(im_set{i},im_set{j});
        W(i,j)=sum(sum(w));
        W(j,i)=sum(sum(w));
    end
end

disp(W);
calc = zeros(ct);
im_res = im_set;
for i = 1:ct
    for j=2:ct
        if W(i,j)==0 || calc(j) ~= 0
            continue;
        else
            disp("");
            disp("i = " + i + " j = " + j);
            calc(j) = 1;
            im_res{j} = uint8(CalAns(im_set{j},im_res{i}));
        end
    end
end

for i=1:ct
   imwrite(im_res{i},strcat(dirname, sprintf('output/%02d.jpg',i)));
end

o = im_res{1};
for i=2:ct
    o = [o, im_res{i}];
end

imwrite(o,strcat(dirname, sprintf('output/output.jpg')));