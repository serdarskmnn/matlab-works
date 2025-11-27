% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/M2pObU0YRSw?si=I1dMDVJrs-X5N_QH
clear all; clc; close all;
dx = pi/10; x = 0:2*pi:dx:2*pi; l = length(x); f = sin(x);
plot(x, f, 'k', 'LineWidth', 1.2), hold on, grid on;
dfcos(x) = 2; plot(x, dfcos(x), 'r', 'LineWidth', 2.5);

for i = 1:l-1;
    x1(i) = x(i);
    dfdx1(i) = (f(i+1) - f(i)) / dx;
end;

for i = 2:l;
    x2(i) = x(i);
    dfdx2(i) = (f(i) - f(i-1)) / dx;
end;

for i = 2:l-1;
    x3(i) = x(i);
    dfdx3(i) = (f(i+1) - f(i-1)) / (2*dx);
end;

plot(x1(1:l-1), dfdx1(1:l-1), 'b', x2(2:l), dfdx2(2:l), 'g', x3(2:l-1), dfdx3(2:l-1), 'ko-')
l2 = legend('Func', 'ExactDer', 'Forward', 'Backward', 'Central'); set(l2, 'FontSize', 12);
