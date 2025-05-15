g = 9.8;m = 70;cd = 12.5;        % cd=drag coefficient

% analytical solution of the parachutist's falling speed model
t = 0:2:20;       
vta = ((m*g)/cd) * (1 - exp(-(cd/m)*t));  

% uncomment the lines below to see the plot or values
% plot(t, vta);    %plot of analytical solution
% disp([t, vta]);  %display time and analytical velocity side by side

% numerical solution of the parachutist's falling speed model
vt0 = 0;          
dt = 2;      
for t = 1:1:10  
    vt(t) = vt0 + (g - (cd/m)*vt0)*dt;  
    vt0 = vt(t);                        
end
t = 0:2:20;       
vts = [0 vt];     
a = [t; vta; vts];
disp(a);          
plot(t, vta, '-o', t, vts, '-*');  
