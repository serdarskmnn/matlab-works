% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/qIfxydBEdzg?si=qSxPH7OFWlJee6oj
f = @(x, y) [y(2); -pi^2*y(1)];
s = 10;
sol = @(s) ode45(f, [0 1], [0 s]);
res = @(s) deval(sol(s), 1, 1);
s_final = fzero(@(s) res(s), 1);
[t, y] = ode45(f, [0 1], [0 s_final]);
plot(t, y(:,1))
xlabel('x')
ylabel('y')
title('Shooting Method Solution')
