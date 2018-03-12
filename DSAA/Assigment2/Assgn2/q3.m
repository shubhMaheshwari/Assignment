function [result] = q3(file,winLen,strideLen)
start = 1;
flag = 1;
maxLen = size(file,1);
gauss = gausswin(winLen);
totalRow = ceil(maxLen/(winLen-strideLen));
final = [totalRow,winLen];
i = 1;
while flag == 1
    endindex = start + winLen - 1;
    if endindex > maxLen
        flag = 0;
        endindex = maxLen;
        gauss = gausswin(endindex - start + 1);
    end
    a = file(start:endindex).*gauss;
    a = abs(fft(a));
    final(i,1:min(winLen, endindex - start + 1)) = a;
    start = start + winLen - strideLen;
    i = i + 1;
end
figure, imagesc(flipud(log(final(:, 1:winLen/2))));
colorbar;
result = final;
end