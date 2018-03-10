load laughter;
% sound(y);

W = 2000;
s = 20;

% Original sound 
figure;
plot(y);
title('Original Sound');


% Using inbuilt spectrogram 
figure;
spectrogram(y,W,10);


% Using my spectrogram 
SPECTROGRAM(y,w,s);
