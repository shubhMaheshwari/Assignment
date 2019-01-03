function [newSrc]=NewChannelAns(idx,nidx,src,ref,W)

srcr=src(:,:,1);
srcg=src(:,:,2);
srcb=src(:,:,3);

refr=ref(:,:,1);
refg=ref(:,:,2);
refb=ref(:,:,3);

br=double(refr(nidx))/double(255.0);
ar=double(srcr(idx))/double(255.0);

bg=double(refg(nidx))/double(255.0);
ag=double(srcg(idx))/double(255.0);

bb=double(refb(nidx))/double(255.0);
ab=double(srcb(idx))/double(255.0);

l1=50000;
l2=170;
l3=0.08;
t=0:0.2:1;
xx=[0.1,0.3,0.5,0.7,0.9];

cvx_begin
    variables Cr(3,5)
    variables Cg(3,5)
    variables Cb(3,5)
    
    ppr=mkpp(t,Cr);
    ppg=mkpp(t,Cg);
    ppb=mkpp(t,Cb);
    
    opt=sum(((ppval(ppr,ar)-br).^2).*W)+sum(((ppval(ppg,ag)-bg).^2).*W)+sum(((ppval(ppb,ab)-bb).^2).*W);
 
    ppr2=diff(ppr);
    ppr3=diff(ppr2);
    
    ppg2=diff(ppg);
    ppg3=diff(ppg2);
    
    ppb2=diff(ppb);
    ppb3=diff(ppb2);
    
    vr0=ppval(ppr,0);
    vr00=vr0.^2;
    vr10=(ppval(ppr,1)-1).^2;
    
    vg0=ppval(ppg,0);
    vg00=vg0.^2;
    vg10=(ppval(ppg,1)-1).^2;
    
    vb0=ppval(ppb,0);
    vb00=vb0.^2;
    vb10=(ppval(ppb,1)-1).^2;
    
    FXr=(ppval(ppr,xx)-xx).^2;
    FXg=(ppval(ppg,xx)-xx).^2;
    FXb=(ppval(ppb,xx)-xx).^2;
    
    FddXr=(ppval(ppr3,xx)).^2;
    FddXg=(ppval(ppg3,xx)).^2;
    FddXb=(ppval(ppb3,xx)).^2;
    
    FdXr=(ppval(ppr2,xx));
    FdXg=(ppval(ppg2,xx));
    FdXb=(ppval(ppb2,xx));
    
    csoft=l1*(vr00+vr10)+l2*(sum(FXr))+l3*(sum(FddXr)) + l1*(vg00+vg10)+l2*(sum(FXg))+l3*(sum(FddXg)) + l1*(vb00+vb10)+l2*(sum(FXb))+l3*(sum(FddXb));
    minimize(opt+csoft);
    subject to
        0.2 <= FdXr <= 5;
        vr0 <= 0;
        
        0.2 <= FdXg <= 5;
        vg0 <= 0;
        
        0.2 <= FdXb <= 5;
        vb0 <= 0;
cvx_end

PPr=mkpp(t,Cr);
PPg=mkpp(t,Cg);
PPb=mkpp(t,Cb);

Normsrcr=double(srcr)/double(255);
Normsrcg=double(srcg)/double(255);
Normsrcb=double(srcb)/double(255);

outr=ppval(PPr,Normsrcr);
outg=ppval(PPg,Normsrcg);
outb=ppval(PPb,Normsrcb);

newSrc=cat(3,outr,outg,outb);

newSrc=newSrc*255;
end

function pp2=diff(pp)
    [breaks,coefs,l,k,d] = unmkpp(pp);
    pp2 = mkpp(breaks,repmat(k-1:-1:1,d*l,1).*coefs(:,1:k-1),d);
end