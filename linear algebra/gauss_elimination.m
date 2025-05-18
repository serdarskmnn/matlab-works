A = [2 -1 1; 3 3 9; 3 3 5];
b = [2; -1; 4];
n = length(b);
for k = 1:n-1
    for i = k+1:n
        m = A(i,k)/A(k,k);
        A(i,k:n) = A(i,k:n) - m*A(k,k:n);
        b(i) = b(i) - m*b(k);
    end
end
x = zeros(n,1);
x(n) = b(n)/A(n,n);
for i = n-1:-1:1
    x(i) = (b(i) - A(i,i+1:n)*x(i+1:n)) / A(i,i);
end
