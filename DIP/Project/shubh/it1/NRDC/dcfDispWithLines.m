function [ output_args ] = dispDCFwithLines( Src, Ref, DCF, Confidence )
%dispDCFwithLines Display the source and the reference images side by side
%with some random correspondences as lines.

    patch_w = 8;
    [DCF_, Corr_Confidence] = moveToCenter(DCF, patch_w, Confidence);
    rng(1234567);
    [sh, sw] = size(Src(:,:,1));
    
    figure
    image([Src Ref]); hold on;
    for k=1:20
       xx = floor(rand*(sw-1))+1;
       yy = floor(rand*(sh-1))+1;
       while(Corr_Confidence(yy,xx)<0.85)
           xx = floor(rand*(sw-1))+1;
           yy = floor(rand*(sh-1))+1;
       end
       
       xx_target = DCF_(yy,xx,1);
       yy_target = DCF_(yy,xx,2);
       plot([xx (xx_target+size(Src,2))],[yy yy_target ],'color',rand(1,3));
    end
end


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