function [f] = fourier_transform(img)
    f = fft2(img);
    f = fftshift(f);
    f = abs(f);
    f = log(f+1);
    f = mat2gray(f);
    imshowpair(img,f,'montage');
    
end