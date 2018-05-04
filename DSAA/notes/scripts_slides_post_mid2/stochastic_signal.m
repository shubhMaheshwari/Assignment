N = 32;

x = rand([1 N])-0.5;

x(find(x>=0)) =1;
x(find(x<0)) =-1;


y = fft(x);

figure, subplot(2,1,1); stem([1:N],x)
axis([0,N+1,-1.5,1.5])
subplot(2,1,2); stem([1:N],abs(y))



