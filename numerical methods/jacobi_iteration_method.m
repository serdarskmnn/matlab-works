% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/rmoy7Mp67Ag?si=6olEyAOYvgUljdUp
% [TR]https://www.youtube.com/watch?v=De3hsj38SQg
y0 = [0 0 0 0 ]';
mits = 16;
T = [0 1/10 -2/10 0; 1/11 0 1/11 -3/11; -2/10 1/10 0 1/10; 0 -3/8 1/8 0];
c = [6/10; 25/11; -11/10; 15/8];
for i = 1:mits
    y1 = T * y0 + c;
    erx1(i) = abs((y1(1,1) - y0(1,1)) / y1(1,1));
    if erx1(i) < 0.001
        break;
    end
    y0 = y1;
end
disp(y1);
plot(k, erx1); hold on;
