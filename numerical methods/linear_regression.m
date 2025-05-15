% if you do not have enough theoretical knowledge on this subject,
% you can watch these videos
% [ENG]https://www.youtube.com/watch?v=CtsRRUddV2s
% [TR]https://youtu.be/bKVdg7hBn1U?si=ahdjBT9f1S_NdiSD
xi=[0.5 1 2 4 5]; yi=[1 2 5 11 13];
txi=0; tyi=0; txi2=0; txyi=0; tyi2=0;
for i=1:5
    txi=txi+xi(i);
    tyi=tyi+yi(i);
    txi2=txi2+xi(i)^2;
    txyi=txyi+xi(i)*yi(i);
    tyi2=tyi2+yi(i)^2;
end
a1=(i*txyi-txi*tyi)/(i*txi2-txi^2);
a0=(tyi/i)-a1*(txi/i);
ym=a1*xi+a0;
fprintf('linear equation coefficients a1 and a0:');
disp(d); plot(xi,yi,'o',xi,ym);
