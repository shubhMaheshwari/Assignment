function [ DCF_disp ] = dispDCF( DCF, refSize, Confidence)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    patch_w = 8;
    if ~exist('Confidence', 'var') || isempty(Confidence)
        Confidence = [];
    end
    
    [DCF, Corr_Confidence] = moveToCenter(DCF, patch_w, Confidence);
    
    DCF_disp = double(zeros(size(DCF,1),size(DCF,2),3));
    DCF_disp(:,:,1:2) = DCF(:,:,1:2);
    
    DCF_disp(:,:,1) = DCF_disp(:,:,1) / refSize(2);
    DCF_disp(:,:,2) = DCF_disp(:,:,2) / refSize(1);
    DCF_disp(:,:,3)=0;
        
    if exist('Corr_Confidence', 'var') && ~isempty(Corr_Confidence)
        Corr_Confidence(Corr_Confidence >= 0.5) = 1;
        Corr_Confidence(Corr_Confidence < 0.5) = 0;
        DCF_disp = DCF_disp .*  repmat(Corr_Confidence, [1,1,3]);
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
