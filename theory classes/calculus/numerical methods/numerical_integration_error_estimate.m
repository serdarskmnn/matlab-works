% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/EDQzPk9CKCo?si=0f5bxLeJ0dDMg1qP
f = @(x) log(x);
a = 1;
b = 2;
n = 10;
h = (b - a)/n;
x = a:h:b;
y = f(x);
I = h*(0.5*y(1) + sum(y(2:end-1)) + 0.5*y(end));
syms s
f2 = matlabFunction(diff(f(s),2));
M2 = max(f2(x));
E = -((b - a)^3 / (12*n^2)) * M2;
