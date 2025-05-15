% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://www.youtube.com/watch?v=-5e2cULI3H8
% [TR]https://www.youtube.com/watch?v=I7zpcF_kmew
x0 = 0;
g = @(x)(exp(-x) - x);
dg = @(x)(-exp(-x) - 1);
maxiter = input('enter maximum number of iterations: ');
tol = input('enter tolerance value: ');

for i = 1:maxiter
    x1 = x0 - g(x0)/dg(x0);
    err = abs((x1 - x0)/x1);
    fprintf('iteration: %d, x: %.10f, error: %.10f\n', i, x1, err);
    x0 = x1;
    if err < tol
        break
    end
end
fprintf('approximate root: %.10f, total iterations: %d\n', x1, i);
