% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/1YZnic1Ug9g?si=IwS_8Gm0kN3RAsK-
% [TR]https://youtu.be/fmeD7RA-DyA?si=E6eZ2CbUr5vT4d1P
f = @(t, y) y - t^2 + 1;
a = 0;
b = 2;
h = 0.2;
N = (b - a)/h;
t = a:h:b;
y = zeros(1, N+1);
y(1) = 0.5;
for i = 1:N
    k1 = f(t(i), y(i));
    k2 = f(t(i) + h/2, y(i) + h * k1 / 2);
    k3 = f(t(i) + h/2, y(i) + h * k2 / 2);
    k4 = f(t(i) + h, y(i) + h * k3);
    y(i+1) = y(i) + (h/6) * (k1 + 2*k2 + 2*k3 + k4);
end
plot(t, y, 'o-')
xlabel('t')
ylabel('y')
title('Runge-Kutta 4th Order')
