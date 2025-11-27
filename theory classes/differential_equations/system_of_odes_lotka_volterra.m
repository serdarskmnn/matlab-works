% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/rQUSRK-Prm0?si=M1HfujVvX_mAe36h
alpha = 0.1;
beta = 0.02;
delta = 0.01;
gamma = 0.1;
f = @(t, z) [alpha*z(1) - beta*z(1)*z(2); delta*z(1)*z(2) - gamma*z(2)];
[t, z] = ode45(f, [0 200], [40; 9]);
plot(t, z(:,1), 'b', t, z(:,2), 'r')
xlabel('t')
ylabel('Population')
legend('Prey','Predator')
title('Lotka-Volterra Model')
