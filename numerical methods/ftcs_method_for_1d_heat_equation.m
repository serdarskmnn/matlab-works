% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/zPDp_ewoyhM?si=oLYTA0AHCVdXxRUV
F = @(x) [x(1)^2 + x(2)^2 - 4; x(1)*x(2) - 1];
J = @(x) [2*x(1), 2*x(2); x(2), x(1)];
x = [1; 1];
tol = 1e-6;
for k = 1:20
    delta = -J(x)\F(x);
    x = x + delta;
    if norm(delta) < tol
        break
    end
end
