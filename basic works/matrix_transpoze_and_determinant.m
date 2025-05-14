A = input('enter matrix (ex. [1 2; 3 4]): ');
disp('transpoze:');
disp(A');
if size(A,1) == size(A,2)
    fprintf('Determinant: %f\n', det(A));
else
    disp('determinant can only be calculated for square metrices');
end
