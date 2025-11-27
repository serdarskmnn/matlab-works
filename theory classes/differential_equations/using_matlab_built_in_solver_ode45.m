% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/VQZHRMs3VWo?si=85Qe3V1xkLeadOyB
f = @(t, y) y - t^2 + 1;
[t, y] = ode45(f, [0 2], 0.5);
plot(t, y, 'o-')
xlabel('t')
ylabel('y')
title('ode45 Solution')
