%% LQR ILE DRONE KONTROLU (ZEMIN KONTROLLU FINAL)
clc; clear; close all;

% --- 1. SISTEM MODELI ---
m = 1.2; 
A = [0  1; 
     0  0];
B = [0; 
     1/m];

% --- 2. LQR TASARIMI ---
Q = [100  0; 
     0    1];
R = 0.1;

% LQR Kazancini Hesapla
K = lqr(A, B, Q, R);
disp('K Katsayilari:'); disp(K);

% --- 3. OZEL SIMULASYON DONGUSU ---
% Hazir 'initial' komutu yerine kendi fizik motorumuzu yaziyoruz
% Boylece "Zemin" kavramini ekleyebiliriz.

dt = 0.01;       % Zaman adimi (10 ms)
T_final = 5;     % Toplam sure (saniye)
steps = T_final / dt; 

% Kayit icin diziler (Grafik cizmek icin)
time = 0:dt:T_final;
pos_log = zeros(1, length(time));
vel_log = zeros(1, length(time));
u_log   = zeros(1, length(time));

% Baslangic Durumu
x = [10; 0]; % 10 metreden basla, hizi 0.

for i = 1:length(time)
    
    % 1. Mevcut Durumu Kaydet
    pos_log(i) = x(1);
    vel_log(i) = x(2);
    
    % 2. LQR Kontrol Kurali (u = -K*x)
    % "Hata ne kadar buyukse o kadar ters kuvvet uygula"
    u = -K * x;
    
    % --- YERCEKIMI DENGELEMESI (Gravity Compensation) ---
    % LQR sadece hatayi sifirlar. Dronun havada asili kalmasi icin
    % yercekimi kadar ekstra guc (mg) vermemiz lazim.
    % Eger bunu eklemezsek drone yavasca yere duser.
    u_total = u + (m * 9.81); 
    
    % Motor Siniri (Saturation - Opsiyonel)
    % Motorlar max 30N uretebilir, eksi uretemez
    if u_total > 30; u_total = 30; end
    if u_total < 0; u_total = 0; end
    
    u_log(i) = u_total; % Kaydet
    
    % 3. Fizik Motoru (Euler Integrasyonu)
    % dx = Ax + Bu (Burada B*u yerine B*(u_total - gravity) yapiyoruz)
    % Cunku lineer modelde yercekimi yoktu, elle ekliyoruz.
    
    acceleration = (u_total / m) - 9.81; % Net Ivme = (Itki/Kutle) - g
    
    x(2) = x(2) + acceleration * dt;     % Hiz guncelle
    x(1) = x(1) + x(2) * dt;             % Konum guncelle
    
    % --- ZEMIN KONTROLU (GROUND CHECK) ---
    % Eger konum 0'in altina inerse, yere carpmis demektir.
    if x(1) <= 0
        x(1) = 0; % Konumu 0'a sabitle
        x(2) = 0; % Hizi sifirla (Carpip durdu)
        
        % Opsiyonel: Yerdeyken motorlari kapatabiliriz
        % u_total = 0; 
    end
end

% --- 4. GRAFIKLER ---
figure('Name', 'LQR Inis Simu', 'Color', 'w');

subplot(3,1,1);
plot(time, pos_log, 'LineWidth', 2);
yline(0, 'k--', 'Zemin');
ylabel('Yukseklik (m)'); grid on;
title('Konum');

subplot(3,1,2);
plot(time, vel_log, 'r', 'LineWidth', 2);
ylabel('Hiz (m/s)'); grid on;
title('Dikey Hiz');

subplot(3,1,3);
plot(time, u_log, 'g', 'LineWidth', 2);
ylabel('Motor Gucu (N)'); grid on;
xlabel('Zaman (s)');
title('Kontrolcu Ciktisi');