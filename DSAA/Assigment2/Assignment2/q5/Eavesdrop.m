function [number] = Eavesdrop(audio_file)
    audinfo = audioinfo(samplefile);
    winLen = audinfo.TotalSamples/audinfo.SampleRate;
end