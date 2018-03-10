function [out_image] = NEW_FFT2(in_image)
    N = size(in_image,1);
    M = size(in_image,2);
    out_image = zeros(N,M);
    for n=N
        size(out_image(n,:))
        out_image(n,:) = NEWFFT(in_image(n,:),[1:M],N);
    end
end