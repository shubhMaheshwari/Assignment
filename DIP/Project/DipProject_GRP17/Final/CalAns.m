function [newSrc,newSrc1]=CalAns(src,ref)

[M,W,TT]=Affinity(src,ref);
My=M(:,:,1);
Mx=M(:,:,2);
patch_w = 8;
idx = find(W);
n=size(idx,1);
if n==0
    newSrc=src;
    newSrc1=src;
else
    N=floor(0.0005235510724071*n);
    if N==0
        N=1;
    end
    nidx=idx(1:N:n);

    Sz=size(ref(:,:,1));

    tx=floor(Mx(nidx));
    ty=floor(My(nidx));

    Newidx=sub2ind(Sz,tx,ty);
    NewW=W(nidx);

%     newSrc=channelAns(nidx,Newidx,src,ref,NewW);
    newSrc=NewChannelAns(nidx,Newidx,src,ref,NewW);
    
    Normsrc=double(src)/double(255);
    newSrc1=evalColorTransform(single(Normsrc), TT);
end

end