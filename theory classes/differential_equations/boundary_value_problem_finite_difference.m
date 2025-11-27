% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/0gsJ3qPtP3s?si=ADSOK59eqgu5nvRY
N = 100;
h = 1/N;
x = linspace(0,1,N+1);
A = diag(2*ones(N-1,1)) + diag(-1*ones(N-2,1),1) + diag(-1*ones(N-2,1),-1);
A = A / h^2;
f = pi^2 * sin(pi * x(2:end-1))';
y = A \ f;
y = [0; y; 0];
plot(x, y)
xlabel('x')
ylabel('y')
title('Finite Difference Method')
