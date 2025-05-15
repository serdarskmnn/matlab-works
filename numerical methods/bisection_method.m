% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://www.youtube.com/watch?v=qEecNyRa5o4
% [TR]https://www.youtube.com/watch?v=6IMOAUfV1es

f = @(x)(x^2 - 2*x - 15);
xa = input('enter the lower bound for root search xa = ');
xu = input('enter the upper bound for root search xu = ');
acc = input('enter the error tolerance acc = ');
itr = 0;

while (f(xa)*f(xu) > 0)
    disp('no root in the entered range, enter new value')
    xa = input('enter the lower bound for root search xa = ');
    xu = input('enter the upper bound for root search xu = ');
end

while (abs(xu - xa) > acc)
    itr = itr + 1;
    xr = (xa + xu)/2;
    if f(xa)*f(xr) < 0
        xu = xr;
    else
        xa = xr;
    end
end

fprintf('the approximate root of the equation using the bisection Method is xr = %f\n', xr);
disp(itr);
