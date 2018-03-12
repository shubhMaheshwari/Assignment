function [result] = Eavesdrop(audio_file)
    
    info = audioinfo(audio_file);
    num =  info.Duration;
    
    
    X = audioread(audio_file);
    plot(X);
    title('Original Sound');
    step_length = info.SampleRate;

%     Get the audio files of each number
    
    s_num = zeros(10,step_length);
    for i = [1:10]
    s = strcat('./',num2str(mod(i,10) ,'%2d'),'.ogg');
    a = audioread(s);
    s_num(i,:) = a(1:step_length);
    end
    
    result = 0;
    for i = [1:num]
        x = X((i-1)*step_length +1 : i*step_length);
        [val,max_num] = max(s_num*x);
        result = 10*result + mod(max_num,10);
    end
end