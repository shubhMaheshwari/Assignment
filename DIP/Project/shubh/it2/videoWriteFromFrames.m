% create the video writer with 1 fps
 writerObj = VideoWriter('frames/output/input');
 writerObj.FrameRate = 15;
 % open the video writer
 open(writerObj);
 % write the frames to the video
 for u=15:182
     % convert the image to a frame
     frame = im2frame(imread(sprintf('frames/%02d.jpg',u)));
     writeVideo(writerObj, frame);
 end
 % close the writer object
 close(writerObj);

% create the video writer with 1 fps
 writerObj = VideoWriter('frames/output/output');
 writerObj.FrameRate = 15;
 % open the video writer
 open(writerObj);
 % write the frames to the video
 for u=15:182
     % convert the image to a frame
     frame = im2frame(imread(sprintf('frames/output/%02d.jpg',u)));
     writeVideo(writerObj, frame);
 end
 % close the writer object
 close(writerObj);