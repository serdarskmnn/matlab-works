% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/hcsBjizQ9X8?si=PKemTK5IPV5tQNqw
% [TR]https://youtube.com/playlist?list=PLcNWqzWzYG2sVGxtIyAQqaHsJAYAgtnmn&si=X7P2TkTocw9DjJCs
x = [5 6 9 11];
y = [12 13 14 16];
n = length(x);
F = zeros(n,n);
F(:,1) = y';
for j = 2:n
    for i = 1:n-j+1
        F(i,j) = (F(i+1,j-1) - F(i,j-1)) / (x(i+j-1) - x(i));
    end
end
xp = 7;
yp = F(1,1);
prod = 1;
for i = 1:n-1
    prod = prod * (xp - x(i));
    yp = yp + F(1,i+1)*prod;
end
