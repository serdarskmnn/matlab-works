% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/3d6DsjIBzJ4?si=CboqR2ktdetnR3c7
% [TR]https://youtube.com/playlist?list=PLcNWqzWzYG2vbaFoHJMWqK3waYJnW_b5i&si=VBXC851Erqomjfq9

syms x
f = log(1 + x);
T = taylor(f, x, 'Order', 6);
