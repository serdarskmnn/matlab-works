% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://www.youtube.com/playlist?list=PL9C549A03F84233ED
x0 = 0; y0 = 1; h = 0.1;
fxy = @(x, y) (x * y^3);
fg = @(x) ((1 ./ (1 + x^2)).^(1/2));

for i = 1:6
    n(i) = i;     x(i) = x0;     y(i) = y0;
    f(i) = fg(x0);
    
    k1(i) = fxy(x0, y0);
    x0 = x0 + h;
    y0 = y0 + h * k1(i);
    k2(i) = fxy(x0, y0);
    y0 = y(i) + (h / 2) * (k1(i) + k2(i));
end;

d = ['n' ' x' ' y' ' f' ' k1' ' k2'];
fprintf('  n\t x\t  y\t   f\t  k1\t  k2\n');
disp(d);
plot(x, y, 'o-', x, f, 'k');
et2 = legend('RK-2', 'Func'); set(et2, 'FontSize', 8);
