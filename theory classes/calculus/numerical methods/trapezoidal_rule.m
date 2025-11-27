% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/Rn9Gr52zhrY?si=DGWZso2lrTnPMiDR
% [TR]https://youtu.be/YUgAWPFMYrM?si=jzleJvTiB75uOlTL
f = @(x) exp(-x.^2);
a = 0;
b = 2;
n = 100;
h = (b - a) / n;
x = a:h:b;
y = f(x);
I = h * (0.5*y(1) + sum(y(2:end-1)) + 0.5*y(end));
