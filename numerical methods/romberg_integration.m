% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/_BgF_b1MFSU?si=tMDyDSd7f1yHVNln
f = @(x) 1./(1 + x.^2);
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
