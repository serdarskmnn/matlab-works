n = input('enter a number:\n');
fprintf('%d! = %d\n', n, factorial(n));

function f = factorial(n)
    f = 1;
    for i = 2:n
        f = f * i;
    end
end
