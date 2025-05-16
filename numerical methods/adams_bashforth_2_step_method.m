% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/fp6n7x55tkQ?si=DtZQuUp19yP9gK6y
f = @(t,y) t + y;f = @(x) 1./(1 + x.^2);
a = 0;
b = 1;
n = 4;
R = zeros(n,n);
for i = 1:n
    h = (b - a) / 2^(i-1);
    x = a:h:b;
    R(i,1) = h/2 * (f(a) + 2*sum(f(x(2:end-1))) + f(b));
end
for j = 2:n
    for i = j:n
        R(i,j) = (4^(j-1)*R(i,j-1) - R(i-1,j-1)) / (4^(j-1) - 1);
    end
end
I = R(n,n);

h = 0.1;
t = 0:h:1;
y = zeros(1,length(t));
y(1) = 1;
y(2) = y(1) + h * f(t(1), y(1));
for i = 2:length(t)-1
    y(i+1) = y(i) + h/2 * (3*f(t(i), y(i)) - f(t(i-1), y(i-1)));
end
