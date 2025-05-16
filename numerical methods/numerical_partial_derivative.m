% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/xnhz1Ngr4w8?si=h0TIzWUd2-lhuG76
% [TR]https://youtube.com/playlist?list=PLcNWqzWzYG2uXBCeHgbjspc8_uSt4SE13&si=phc-GKUQBD0xFhqO
f = @(x, y) x.^2 .* y + sin(y);
x0 = 1;
y0 = 2;
h = 1e-5;
df_dx = (f(x0 + h, y0) - f(x0 - h, y0)) / (2*h);
df_dy = (f(x0, y0 + h) - f(x0, y0 - h)) / (2*h);
