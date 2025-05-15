% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/nvkX1Bd90Gk?si=mItsqfu7TN2sts4g
% [TR]https://youtube.com/playlist?list=PLcNWqzWzYG2uUufOfZOJ-MIN7pUSYcIf2&si=n3qv8Ca-EZX8ZWLz
x = [1 2 3 4];
y = [1 4 9 16];
xp = 2.5;
n = length(x);
yp = 0;
for i = 1:n
    p = 1;
    for j = 1:n
        if j ~= i
            p = p * (xp - x(j)) / (x(i) - x(j));
        end
    end
    yp = yp + p * y(i);
end
