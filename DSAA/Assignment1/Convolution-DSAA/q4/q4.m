
audio_file = audiorecorder(44100,24,1,1)

disp('Start speaking.')
recordblocking(audio_file, 5);
disp('End of Recording.');

play(audio_file);

y = getaudiodata(audio_file);
size_y = size(y,1)
plot(y);

y24 = y((1:floor(44.1/24):size_y)');
P24 = audioplayer(y24,24000);
plot(y24)
play(P24)

y16 = y((1:floor(44.1/16):size_y)');
P16 = audioplayer(y24,16000);
plot(y16)
play(P16)

y8 = y((1:floor(44.1/8):size_y)');
P8 = audioplayer(y24,8000);
plot(y8)
play(P8)

y4 = y((1:floor(44.1/4):size_y)');
P4 = audioplayer(y24,4000);
plot(y4)
play(P4)

church_bullet = audioread('church_bullet.wav');
church = audioplayer(church_bullet,44100);
play(church);
plot(church_bullet);

church_y = conv(y,church_bullet(:,1));
church_conv_audio = audioplayer(church_y,44100);
plot(church_y)
play(church_conv_audio)

r1_bullet = audioread('./r1_omni.wav');
r1_y = conv(y,r1_bullet(:,1));
r1_conv_audio = audioplayer(r1_y,44100);
plot(r1_y)
play(r1_conv_audio)

tr_bullet = audioread('./terrys_typing_omni.wav');
tr_y = conv(y,tr_bullet(:,1));
tr_conv_audio = audioplayer(tr_y,44100);
plot(tr_y)
play(tr_conv_audio)


