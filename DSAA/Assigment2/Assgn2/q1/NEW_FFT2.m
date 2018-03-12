function [out_image] = NEW_FFT2(in_image)
    N = size(in_image,1);
    M = size(in_image,2);
    out_image = zeros(N,M);
    for n=[1:N]
        out_image(n,:) = NEWFFT(in_image(n,:),[1:M],N);
    end

    out_image = abs(out_image);
	out_image = log(out_image + 1);
	out_image = mat2gray(out_image);
	imshow(out_image) 

end