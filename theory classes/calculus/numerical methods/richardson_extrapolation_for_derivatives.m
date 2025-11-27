% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/3S6CpBMcy_Y?si=rBuccCzar2KnJvlC
f = @(x) sin(x);
x0 = pi/4;
h = 0.1;
D1 = (f(x0 + h) - f(x0 - h)) / (2*h);
D2 = (f(x0 + h/2) - f(x0 - h/2)) / (h);
D = (4*D2 - D1) / 3;
