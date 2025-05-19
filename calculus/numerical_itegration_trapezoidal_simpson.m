% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/RTX-ik_8i-k?si=hIGqYXczQcYvfUvc
% [ENG]https://youtu.be/aY6Y66cc4rE?si=kQRuJJkS-JN7BZqt

f = @(x) x.^2 .* sin(x);
a = 0;
b = pi;
n = 100;
x = linspace(a, b, n+1);
y = f(x);
I_trap = trapz(x, y);
