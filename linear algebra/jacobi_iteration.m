A = [4 -1 0; -1 4 -1; 0 -1 3];
b = [15; 10; 10];
x = zeros(3,1);
for k = 1:25
    x_new = zeros(3,1);
    for i = 1:3
        x_new(i) = (b(i) - A(i,[1:i-1,i+1:end])*x([1:i-1,i+1:end])) / A(i,i);
    end
    x = x_new;
end
