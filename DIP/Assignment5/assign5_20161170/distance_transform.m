% VL_DEMO_IMDISTTF Demonstrates image distance transform

% load image
im = imread('./input_images/house1.jpg');
% im = im(100:200,100:200,:) ;
imSize = [size(im,1) size(im,2)] ;

% creates an edge map
edges = zeros(imSize) + inf;
edges(edge(rgb2gray(im), 'canny')) = 0 ;

% compute distance transform
[distanceTransform, neighbors] = vl_imdisttf(single(edges)) ;

% plot
[u,v] = meshgrid(1:imSize(2),1:imSize(1)) ;
[v_,u_] = ind2sub(imSize, neighbors) ;

% avoid cluttering the plot too much
u = u(1:3:end,1:3:end) ;
v = v(1:3:end,1:3:end) ;
u_ = u_(1:3:end,1:3:end) ;
v_ = v_(1:3:end,1:3:end) ;

figure(1) ; clf ; imagesc(im) ; axis off image ; title('imdisttf src');
figure(2) ; clf ; imagesc(edges) ; axis off image ; title('imdisttf edge');
figure(3) ; clf ; imagesc(edges) ; axis off image ; title('imdisttf neigh');
hold on ; h = quiver(u,v,u_-u,v_-v,0) ; colormap gray ;
figure(4) ; clf ; imagesc(sqrt(distanceTransform)) ; axis off image ; title('imdisttf dist') ;
