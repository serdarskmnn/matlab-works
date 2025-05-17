% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/r1eWerqrcqo?si=3RnXVs8__QSvUo5I
f = @(t, u) [u(2); -5*u(1) - 2*u(2)];
[t, u] = ode45(f, [0 10], [1; 0]);
plot(t, u(:,1), 'b')
xlabel('t')
ylabel('x(t)')
title('Spring-Mass-Damper System')
