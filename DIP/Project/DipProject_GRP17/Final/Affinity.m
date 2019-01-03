function [DCF_, Corr_Confidence, T]=Affinity(Src_path,Ref_path)
%% Read files
Src = double(Src_path) / 255.0;
Ref = double(Ref_path) / 255.0;

%% Reduce size if source image is too big
OriginalSource = Src; % Keep the original source before changing its size.
rf = max(max(size(Src)))  / 640;
if (rf > 1)
    disp('source image is too big. resize automatically.')
    Src = imresize(Src, 1.0/rf);
    Ref = imresize(Ref, 1.0/rf);
end

%% Set an options struct
NRDC_Options = [];
NRDC_Options.isParallelized = true; 

%% Run NRDC (This version is optimized for best quality, not for speed).
    
tic
[DCF, Confidence, T, AlignedRef] = nrdc(Src, Ref, NRDC_Options);
toc % 8.36 seconds for the attached example (using the parallelized version on 2.3GHz Intel Core i7 (2820qm) MacBook Pro)
    
%%
patch_w = 8;
[DCF_, Corr_Confidence] = moveToCenter(DCF, patch_w, Confidence);

end
    
%% moveToCenter Function
function [Corr, Corr_Confidence] = moveToCenter(DCF, patch_w, DCF_Confidence)
    Corr=zeros([size(DCF,1)+patch_w-1, size(DCF,2)+patch_w-1, 2]);
    Corr(patch_w/2+1:end-patch_w/2+1, patch_w/2+1:end-patch_w/2+1, :) = DCF(:,:,1:2) + patch_w/2;
    
    Corr_Confidence = zeros(size(Corr(:,:,1)));
    if exist('DCF_Confidence', 'var') && ~isempty(DCF_Confidence)
        Corr_Confidence(patch_w/2+1:end-patch_w/2+1, patch_w/2+1:end-patch_w/2+1) = DCF_Confidence(:,:);
    else
        Corr_Confidence(patch_w/2+1:end-patch_w/2+1, patch_w/2+1:end-patch_w/2+1, :) = 1;
    end
end