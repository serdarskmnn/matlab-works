% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/5zwxZ439nTA?si=NL3uV-R9FcZ2RBze
dt = 0.2; t = -2:dt:8; f = sin(2*t);
dfdx = 2*cos(2*t);
plot(t, dfdx, 'k--'), hold on, grid on; plot(t, dfdx, 'k', 'LineWidth', 1.2);
legend('Function', 'Exact Derivative'); set(gca, 'FontSize', 10);

dfdf = (sin(2*(t+dt)) - sin(2*t)) / dt;

dfdb = (sin(2*t) - sin(2*(t-dt))) / dt;

dfdc = (sin(2*(t+dt)) - sin(2*(t-dt))) / (2*dt);

plot(t, dfdf, 'b', 'LineWidth', 1.2);
plot(t, dfdb, 'g', 'LineWidth', 1.2);
plot(t, dfdc, 'r', 'LineWidth', 1.2);
l2 = legend('Func', 'ExactDer', 'Forward', 'Backward', 'Central'); set(l2, 'FontSize', 10);
