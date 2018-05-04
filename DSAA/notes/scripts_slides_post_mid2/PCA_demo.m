x = [2.5 0.5 2.2 1.9 3.1 2.3 2 1 1.5 1.1]';
x= x-mean(x);
y = [2.4 0.7 2.9 2.2 3.0 2.7 1.6 1.1 1.6 0.9]';
y= y-mean(y);
D = [x y];

scatter(x,y)
axis([-2,2,-2,2])

% covariance matrix
C = cov(D);

% Eigen decomposition
[E,V] = eig(C);

% Transformed data
D_new = D*E;
figure,
scatter(D_new(:,2),D_new(:,1))
axis([-2,2,-2,2])


% Tranform back to get original data
D1 = D_new*E';
figure,
scatter(D1(:,2),D1(:,1))
axis([-2,2,-2,2])

% Transform back only single eigen value

D_new(:,1)=0;
D2 = D_new*E;
figure,
scatter(D2(:,2),D2(:,1))
axis([-2,2,-2,2])
