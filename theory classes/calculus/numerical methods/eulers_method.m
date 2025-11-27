% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/ukNbG7muKho?si=ZQLYHx0-4iVcvd0y
f = @(t, y) y - t^2 + 1;
t0 = 0;
y0 = 0.5;
h = 0.2;
n = 10;
t = t0:h:t0+n*h;
y = zeros(1, n+1);
y(1) = y0;
for i = 1:n
    y(i+1) = y(i) + h*f(t(i), y(i));
end
