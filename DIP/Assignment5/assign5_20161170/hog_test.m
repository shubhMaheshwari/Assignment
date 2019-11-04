im = imread('./input_images/house.jpeg');
im = single(rgb2gray(im));
cellsize = 8;
hog = vl_hog(im, cellsize, 'verbose');
imhog = vl_hog('render', hog, 'verbose');
clf; imagesc(imhog); colormap gray;axis off image ; title('Standard HOG features with a cell size of 8 pixels.')

% Dalal-Triggs variant
cellSize = 20;
hogdt = vl_hog(im, cellSize, 'verbose', 'variant', 'dalaltriggs') ;
imhogdt = vl_hog('render', hogdt, 'verbose', 'variant', 'dalaltriggs') ;
figure, imagesc(imhogdt); colormap gray;axis off image ; title('Dalal-Triggs variant');

% Specify the number of orientations
figure
for i = [3:3:24]
    hog = vl_hog(im, cellSize, 'verbose', 'numOrientations', i) ;
    imhog = vl_hog('render', hog, 'verbose', 'numOrientations', i) ;
    subplot(3 ,3, i/3), imagesc(imhog); colormap gray;axis off image ; title(['numOrientation = ', num2str(i)]);
end

% Specify the number of orientations
hogbi = vl_hog(im,cellSize,'BilinearOrientations') ;
imhogbi = vl_hog('render', hogbi, 'BilinearOrientations') ;
figure, imagesc(imhogbi); colormap gray;axis off image ; title('Soft Orientation');