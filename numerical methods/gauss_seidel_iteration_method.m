% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://youtu.be/F6J3ZmXkMj0?si=l94nBUB1NvFfIXb1
% [TR]https://youtu.be/TJQ5VApvprw?si=-EiqBL4oafmwGt_T
x10 = 0; x20 = 0; x30 = 0; x40 = 0;
for j = 1:mits
    x11 = 0.1 * x20 - 0.2 * x30 + 0.6;
    m(j) = j;
    er1(j) = abs((x11 - x10) / x11);

    x21 = (1 / 11) * x10 + (1 / 11) * x30 - (3 / 11) * x40 + 25 / 11;
    x20 = x21;

    x31 = -0.2 * x10 + 0.1 * x20 + 0.1 * x40 - 1.1;
    x30 = x31;

    x41 = (-3 / 8) * x20 + (1 / 8) * x30 + 15 / 8;
    x40 = x41;

    if er1(j) < 0.001
        break;
    end
end
dm = [x11 x21 x31 x41];
disp(dm);
plot(m, er1);
