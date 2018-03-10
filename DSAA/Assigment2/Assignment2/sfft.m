function [c, count]=sfft(x)

% Input: x, can be a vector (row or column) or matrix. When x is 
%        matrix, the Fourier transform is performed columnwise. 
%        The length of x is expected to be a power of 2. 
%        If not so, zeros will be padded to the end of x to increase its 
%        length to the next power of 2. Multidimensional array inputs are
%        not supported.
% 
% Output: c, the complex Fourier coefficients. Its preserves the 
%         dimensions of the x when zero-padding is not applied to x. 
%         If zero-padding is applied, c will be longer or taller 
%         than x.

% f = imread('cameraman.tif');
% 
% [M, N, ~] = size(f);
% [ mX, mY ] = meshgrid( 0 : M - 1, 0 : M - 1 );
% wM1 = exp( -2 * pi * 1i / M .* mX .* mY );
% [ nX, nY ] = meshgrid( 0 : N - 1, 0 : N - 1 );
% wN1 = exp( -2 * pi * 1i / N .* nX .* nY );
% F = wM1 * double(f) * wN1;
% fl = log(1 + abs(F));
% fm = max(fl(:));
% figure;imshow(im2uint8(fl / fm))
% 
% x=(fft2((imread('cameraman.tif'))));
% fl1 = log(1 + abs(x));
% fm1 = max(fl1(:));
% figure;imshow(im2uint8(fl1 / fm1))

global count    % for counting the number of multiplications.
% Prepare for the recursive call.
count=0; zeropad=false;
[siz1, siz2]=size(x);
if siz1==1  % x is a row vector 
    n=siz2;
    ell=log2(n);
    if mod(ell, 1)~=0
        ell=ceil(ell); n=2^ell; x(end+1:n)=0; zeropad=true; 
    end
    x=x(:);           % recur_sfft requires a column vector.
    c=recur_sfft(x);
    c=c.';
else % x is a column vector or matrix  
    n=siz1;
    ell=log2(n);
    if mod(ell, 1)~=0,ell=ceil(ell);n=2^ell;x(end+1:n,:)=0;zeropad=true;end
    c=recur_sfft(x);
end 

v=fft(x);
fl1 = log(1 + abs(v)); % log(F+1) and not log(F) - (Due to log(0) non-defined value)
fm1 = max(fl1(:));
figure;imshow(im2uint8(fl1 / fm1));

fl11 = log(1 + abs(c));
fm11 = max(fl11(:));
figure;imshow(im2uint8(fl11 / fm11));

if zeropad
    warning('The input has been zero-padded to increase its length to the next power of 2.')
end

function c=recur_sfft(x)
global count
% recursive fft
n=size(x,1);
if n>2
    c_even=recur_sfft(x(1:2:n,:)); % (0:2:n-1)+1 
    c_odd=recur_sfft(x(2:2:n,:));  % (1:2:n-1)+1
    % even means (0:2:n-1), and odd means 1:2:n-1 but they need to add 1
    % to meet Matlab's 1-based indices, so I have to add 1 to the 0-based.

    k=1:n/2;
    w=exp(-pi*2i/n);
    D=spdiags(w.^(k-1).', 0, k(end), k(end));
    c_odd=D*c_odd;
    count=count+k(end)*size(c_odd,2); 
    % counting number of multiplications  
    
    % fill in the second half of c first
    c(k+n/2,:)=c_even-c_odd;
    % which has also pre-allcoated RAM for the first half of c
    
    % now fill in first half of c.
    c(k,:)=c_even+c_odd; 
else                    
    % the bottom is reached, 2-point of x.
    c=[x(1,:)+x(2,:)
       x(1,:)-x(2,:)];
end