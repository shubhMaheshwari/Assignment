% Create a simple spectrogram 
% Input 
%	X - initial signal 
% 	W - window length 
%	s - stride 


function [result] = SPECTROGRAM(y,W,s)
    num_iter = int16((size(y,1) - W)/s) + 1;
    fin_img = zeros(num_iter,W+1);
    result = zeros(num_iter,int16(size(fin_img,2)/2));
    for i = [1:num_iter-2]
        f_y = fft(y(i*s:W + i*s));
        f_y = fftshift(f_y);
        fin_img(i,1:size(f_y)) = abs(f_y);
    end
    fin_img = log(fin_img +1);
%     fin_img = 255*fin_img/max(max(fin_img))
    fin_img = mat2gray(fin_img);
    result = fin_img(1:min(size(result,1),int16(W/2)) ,int16(end/2) + 1:end);
    imshow(result);
    axis on;
    ylabel('Samples');
    xlabel('Frequency');
    colorbar;
    title('New Spectrogram');
end
