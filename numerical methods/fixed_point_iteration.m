% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://www.youtube.com/watch?v=OLqdJMjzib8
% [TR]https://www.youtube.com/playlist?list=PLcNWqzWzYG2tNLIQB6LjU95jskBMbO8w9
x0 = input('enter the initial guess x0:');
maxiter = input('enter the maximum number of iterations:');
tol= input('enter the tolerance value:');

for i = 1:maxiter
    x(i) = exp(-x0);
    if i > 1
        err(i) = abs((x(i) - x(i-1)) / x(i));
        if err(i) < tol
            break;
        end
    else
        err(i) = NaN; %no error for the first iteration
    end
    x0 = x(i);
end
k = (1:length(x))';
result = [k x' err'];
disp(result)
