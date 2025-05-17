% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/7BcT7kurcIY?si=OcbzQH0WvGA-uMqx
% [TR]https://youtu.be/1bUtP9a7gH8?si=VUAi_SUV-uekPFtc
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
    k2 = f(t(i) + h, y(i) + h * k1);
    y(i+1) = y(i) + (h/2) * (k1 + k2);
end
plot(t, y, 'o-')
xlabel('t')
ylabel('y')
title('Heun Method')
