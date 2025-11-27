% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/ukNbG7muKho?si=tUK4PGayitH09ijE
% [TR]https://youtu.be/Mf1qeE0uK0I?si=fYKUUq4wY3_vJkLT
f = @(t, y) y - t^2 + 1;
a = 0;
b = 2;
h = 0.2;
N = (b - a)/h;
t = a:h:b;
y = zeros(1, N+1);
y(1) = 0.5;
for i = 1:N
    y(i+1) = y(i) + h * f(t(i), y(i));
end
plot(t, y, 'o-')
xlabel('t')
ylabel('y')
title('Euler Method')
