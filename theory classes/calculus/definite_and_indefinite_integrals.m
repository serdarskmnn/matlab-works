% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/Gc3QvUB0PkI?si=DruAMkdjzC8jH1BH
% [ENG]https://youtu.be/JTFMeSCxgcA?si=ka3oIYhpbo1tdQN2

syms x
f = x^2 * sin(x);
F = int(f, x);

def_int = int(f, x, 0, pi);
