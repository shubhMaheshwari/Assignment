clc;
close all;
clear all;

taj1 = imread('taj1.jpg');
taj2 = imread('taj2.jpg');
taj3 = imread('taj3.jpg');
india1 = imresize(imread('india1.jpg'),[225 225]);
india2 = imresize(imread('india2.jpg'),[225 225]);
india3 = imread('india3.jpg');

im_set{1} = taj1;
im_set{2} = taj2;
im_set{3} = taj3;
im_set{4} = india1;
im_set{5} = india2;
im_set{6} = india3;
W = zeros(6,6);

adj_mat = zeros(6,6);
for i=1:1:6
    for j=1:1:6
        [M,w,TT] = Affinity(im_set{i},im_set{j});
        W(i,j)=sum(sum(w));
    end
end

ref = 1;
qu = zeros(1,36);
i = 1;
j = 1;
vis = zeros(1,6);

qu(i) = ref;
vis(1) = 1;
j=j+1;
while j>i
    refi = i;
    i=i+1;
    for k=1:1:6
        if W(1,k)==0
            im_res{k}=im_set{k};
        else
            if vis(k)==0
                im_res{k}=CalAns(im_set{k},im_set{refi});
                qu(i) = k;
                j=j+1;
                vis(k) = 1;
            end
        end
    end
end

% src1 = CalAns(taj2,taj1);
% src2 = CalAns(taj3,taj1);
% src3 = CalAns(india1,taj1);
% src4 = CalAns(india2,taj1);
% src5 = CalAns(india3,taj1);
