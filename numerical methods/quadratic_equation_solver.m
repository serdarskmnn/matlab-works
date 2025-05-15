a = input('Enter the value of a: ');
b = input('Enter the value of b: ');
c = input('Enter the value of c: ');
delta = b^2 - 4*a*c;
if delta > 0
    x1 = (-b + sqrt(delta)) / (2*a);
    x2 = (-b - sqrt(delta)) / (2*a);
    fprintf('two real roots: x1=%.2f, x2=%.2f\n', x1, x2);
elseif delta == 0
    x = -b / (2*a);
    fprintf('double root: x=%.2f\n', x); %roots are equal
else
    realPart = -b / (2*a);
    imagPart = sqrt(-delta) / (2*a);
    fprintf('complex roots: x1=%.2f+%.2fi, x2=%.2f-%.2fi\n', realPart, imagPart, realPart, imagPart);
end
