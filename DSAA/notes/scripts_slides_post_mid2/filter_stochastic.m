clear all;
N = 32;
M = 5000;

for i=1:M
    
    r = rand([1 N])-0.5;
    r(find(r>=0)) =1;
    r(find(r<0)) =-1;
   r = filter([0.5,0.5],1,r);
    
    x(i,:) = r;
    y(i,:) = (abs(fft(r))).^2/(N);
    
end

Y = sum(y,1);

figure, stem([1:N],Y/M)
axis([0,N+1,0,2])
