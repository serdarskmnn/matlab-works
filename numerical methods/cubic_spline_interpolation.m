% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/yOUst2672qo?si=3lVrr6aOC3zasN-h
% [TR]https://youtu.be/Bdw1F1x6GaM?si=kzwk3S7E-MuXtAIZ
x = [0 1 2 3];
y = [1 2 0 2];
spline_coeffs = spline(x, y);
xx = linspace(0, 3, 100);
yy = ppval(spline_coeffs, xx);
