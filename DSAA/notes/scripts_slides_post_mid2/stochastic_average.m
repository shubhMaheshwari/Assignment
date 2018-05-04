x = rand([1 500]);
a = [1 -0.8];
b =[0.2];
y = filter(b,a,x);

% lambda = 0.95;
% b = 1-lambda;
% a = [1 -lambda];
% 
% y = filter(b,a,xn);