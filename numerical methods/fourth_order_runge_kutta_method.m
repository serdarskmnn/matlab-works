% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/fll1HdYy6vk?si=7SnWnKIl_3hnqdeB
x0 = 0; y0 = 1; h = 0.1;
fxy = @(x, y) (x * y^3);
fg = @(x) ((1 ./ (1 + x^2)).^(1/2));

for i = 1:6
    n(i) = i;     x(i) = x0;     y(i) = y0;
    f(i) = fg(x0);
    
    k1(i) = fxy(x0, y0);
    k2(i) = fxy(x0 + h/2, y0 + (h/2) * k1(i));
    k3(i) = fxy(x0 + h/2, y0 + (h/2) * k2(i));
    k4(i) = fxy(x0 + h, y0 + h * k3(i));
    
    y0 = y0 + (h/6)*(k1(i) + 2*k2(i) + 2*k3(i) + k4(i));
    x0 = x0 + h;
end;

d = ['n' ' x' ' y' ' f' ' k1' ' k2' ' k3' ' k4'];
fprintf('  n\t x\t  y\t   f\t  k1\t  k2\t  k3\t  k4\n');
disp(d);
plot(x, y, 'o-', x, f, 'k');
et2 = legend('RK-4', 'Func'); set(et2, 'FontSize', 8);
