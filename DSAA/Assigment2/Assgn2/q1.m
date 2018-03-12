f = imread('cameraman.tif');

[M, N, ~] = size(f);
[ mX, mY ] = meshgrid( 0 : M - 1, 0 : M - 1 );
wM1 = exp( -2 * pi * 1i / M .* mX .* mY );
[ nX, nY ] = meshgrid( 0 : N - 1, 0 : N - 1 );
wN1 = exp( -2 * pi * 1i / N .* nX .* nY );
F = wM1 * double(f) * wN1;
fl = log(1 + abs(F));
fm = max(fl(:));
figure;imshow(im2uint8(fl / fm))

x=(fft2((imread('cameraman.tif'))));
fl1 = log(1 + abs(x));
fm1 = max(fl1(:));
figure;imshow(im2uint8(fl1 / fm1))