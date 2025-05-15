% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://www.youtube.com/watch?v=IGC_tEOsdQ8
f = @(x) x.^2 + 3*x + 2;
a = 0;
b = 4;
n = 4;
h = (b - a) / n;
x = a:h:b;
y = f(x);
I = h/3 * (y(1) + 4*sum(y(2:2:end-1)) + 2*sum(y(3:2:end-2)) + y(end));
