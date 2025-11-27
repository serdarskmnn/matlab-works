% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/_PDyi5BVY-E?si=pdoFI2Z2lCiHevMW
A = [2, 1; 1, 3];
x = [1; 1];
tol = 1e-6;
lambda_old = 0;
for k = 1:100
    y = A*x;
    lambda = max(abs(y));
    x = y / lambda;
    if abs(lambda - lambda_old) < tol
        break
    end
    lambda_old = lambda;
end
