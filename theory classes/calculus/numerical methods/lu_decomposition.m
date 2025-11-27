% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/nMyPJylrv_w?si=WOJzTlBqb31GVw2-
A = [4, -2, 1; 20, -7, 12; -8, 13, 17];
n = size(A,1);
L = eye(n);
U = zeros(n);
for i = 1:n
    for j = i:n
        U(i,j) = A(i,j) - L(i,1:i-1)*U(1:i-1,j);
    end
    for j = i+1:n
        L(j,i) = (A(j,i) - L(j,1:i-1)*U(1:i-1,i)) / U(i,i);
    end
end
