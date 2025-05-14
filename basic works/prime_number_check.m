n = input('enter a number:');
prime = true;
if n < 2
    prime = false;
else
    for i = 2:sqrt(n)
        if mod(n, i) == 0
            prime = false;
            break;
        end
    end
end
if prime
    fprintf('%d is a prime number.\n',n);
else
    fprintf('%d is not a prime number.\n',n);
end
