load 'handel.mat';
% sound(y);

W = 256;
s = 256;

% Using inbuilt spectrogram 
figure;
subplot(2,1,1);
spectrogram(y,W,100);
title('Original Spectrogram');

% Using my spectrogram 
subplot(2,1,2);
fin_img = SPECTROGRAM(y,W,s);

