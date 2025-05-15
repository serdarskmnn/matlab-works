xl = input('enter the lower bound. xl= ');
xu = input('enter the upper bound. xu= ');
tol = input('Enter the tolerance. tol = ');
f = @(x) (x^10 - 1);
while (f(xl) * f(xu) > 0)
    disp('no root in the given interval, enter new values.');
    xl = input('Enter the lower bound. xl= ');
    xu = input('Enter the upper bound. xu= ');
end
er = 10;
it = 0;
while (abs(xu - xl) > tol)
    xr = xu - (f(xu) * (xl - xu)) / (f(xl) - f(xu));
    it = it + 1;
    if f(xl) * f(xr) < 0
        xu = xr;
    else
        xl = xr;
    end
end
if f(xl) * f(xr) == 0
    disp('an exact root was found.');
end
fprintf('approximate root after %d iterations: xr = %f\n', it, xr);
