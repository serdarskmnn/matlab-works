% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/PNSvSCkkLBo?si=hrTuTa6VLLdrp7J4
syms s t
Y = 1 / (s^2 + 2*s + 5);
y = ilaplace(Y, s, t);
fplot(y, [0 10])
xlabel('t')
ylabel('y(t)')
title('Inverse Laplace Transform')
