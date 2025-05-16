% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/f_JZRjt8AZ4?si=gimNblZsGKGm2oO2
L = 1;
T = 0.5;
alpha = 0.01;
Nx = 10;
Nt = 100;
dx = L/Nx;
dt = T/Nt;
x = linspace(0,L,Nx+1);
u = zeros(Nx+1,Nt+1);
u(:,1) = sin(pi*x);
r = alpha*dt/(dx^2);
A = diag((1 + r)*ones(Nx-1,1)) + diag(-0.5*r*ones(Nx-2,1),1) + diag(-0.5*r*ones(Nx-2,1),-1);
B = diag((1 - r)*ones(Nx-1,1)) + diag(0.5*r*ones(Nx-2,1),1) + diag(0.5*r*ones(Nx-2,1),-1);
for n = 1:Nt
    u(2:Nx,n+1) = A \ (B * u(2:Nx,n));
end
