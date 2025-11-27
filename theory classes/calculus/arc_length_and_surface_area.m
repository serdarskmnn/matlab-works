% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/hM6Zq4f68yU?si=wyvsfPcwugPY7Yxb
% [TR]https://youtube.com/playlist?list=PLcNWqzWzYG2s3YZOBfaNg0b8LOviFQuMp&si=O3n5rLXnaH3PsfL-
% [TR]https://youtube.com/playlist?list=PLcNWqzWzYG2uzjWEyCKFs9_j3jvQwsFbG&si=garOSYqTpKVmpvYx

syms x
f = sin(x);
df = diff(f, x);
L = int(sqrt(1 + df^2), x, 0, pi);

f = sqrt(x);
A = int(2*pi*f*sqrt(1 + diff(f)^2), x, 1, 4);
