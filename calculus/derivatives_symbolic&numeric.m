syms x
f = x^3 + 2*x^2 - x + 1;
df = diff(f, x);


f = @(x) x.^3 + 2*x.^2 - x + 1;
df_num = @(x) (f(x+1e-5) - f(x-1e-5)) / (2e-5);
x_val = 2;
val = df_num(x_val);
