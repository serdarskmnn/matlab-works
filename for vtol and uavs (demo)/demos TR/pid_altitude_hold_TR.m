%% ========================================================================
%  PROJE: 1D Drone Irtifa Kontrolu (PID Control Simulation)
%  YAZAR: Serdar Sokmen
%  PLATFORM: MATLAB
%
%  ACIKLAMA:
%  Bu script, dikey eksende (Z-ekseni) hareket eden bir Quadcopter'in
%  fiziksel modelini ve PID kontrol dongusunu simule eder.
%  
%  FIZIKSEL MODEL (Newton'un 2. Yasasi):
%  F_net = F_itki - F_yercekimi - F_surtnme
%  ivme = F_net / kutle
%
%  KONTROL ALGORITMASI:
%  Hata = Hedef_Yukseklik - Anlik_Yukseklik
%  Motor_Komutu = (Kp * Hata) + (Ki * Integral) + (Kd * Turev)
% =========================================================================

clc; clear; close all;

%% 1. DRONE FIZIKSEL PARAMETRELERI
% -------------------------------------------------------------------------
m = 1.2;            % Drone kutlesi (kg)
g = 9.81;           % Yercekimi ivmesi (m/s^2)
hover_thrust = m*g; % Havada asili kalmak icin gereken teorik guc (Newton)
max_thrust = 2.5 * m * g; % Motorlarin maksimum itki gucu (TWR = 2.5)

%% 2. PID KAZANC AYARLARI (TUNING)
% -------------------------------------------------------------------------
% BU DEGERLERLE OYNAYARAK UCUS KARAKTERISTIGINI DEGISTIREBILIRSIN
% -------------------------------------------------------------------------
Kp = 3.0;   % P: Yay etkisi. Yuksekse hedefe hizli gider ama titrer.
Ki = 1.5;   % I: Yercekimi hatasini kapatir. Dusukse drone yere duser.
Kd = 2.5;   % D: Amortisor. Yuksekse hareketi yumusatir ama geciktirir.

%% 3. SIMULASYON AYARLARI
% -------------------------------------------------------------------------
sure = 15;              % Simulasyon suresi (saniye)
dt = 0.01;              % Dongu hizi (100 Hz)
t = 0:dt:sure;          % Zaman vektoru

% Hedef Yukseklik (Setpoint)
hedef_irtifa = zeros(size(t));
hedef_irtifa(t > 1) = 10; % 1. saniyeden sonra 10 metreye cik

%% 4. DEGISKENLERIN HAZIRLANMASI
z = zeros(size(t));     % Konum (Yukseklik)
v = zeros(size(t));     % Hiz (Velocity)
thrust_log = zeros(size(t)); % Motor komutlarini kaydetmek icin

hata_toplami = 0;       % Integral hesabi icin
onceki_hata = 0;        % Turev hesabi icin

%% 5. SIMULASYON DONGUSU (CONTROL LOOP)
% -------------------------------------------------------------------------
fprintf('Simulasyon Basliyor... Hedef: 10 Metre\n');

for n = 1:length(t)-1
    
    % --- A. SENSOR OKUMA (Feedback) ---
    anlik_konum = z(n);
    anlik_hiz   = v(n);
    
    % --- B. PID HESAPLAMA (The Brain) ---
    hata = hedef_irtifa(n) - anlik_konum;
    
    % 1. Proportional (Oransal)
    P_term = Kp * hata;
    
    % 2. Integral (Toplam) - Anti-Windup limiti konulabilir ama basitte gerek yok
    hata_toplami = hata_toplami + (hata * dt);
    I_term = Ki * hata_toplami;
    
    % 3. Derivative (Turev) - Hiz degisimine karsi koyma
    turev = (hata - onceki_hata) / dt;
    D_term = Kd * turev;
    
    % PID Cikisi (Newton cinsinden istenen kuvvet)
    istenen_itki = P_term + I_term + D_term;
    
    % Motor Limitleri (Saturation)
    % Motor eksi guc uretemez (0) ve maksimum gucu gecemez (max_thrust)
    gercek_itki = max(0, min(max_thrust, istenen_itki));
    thrust_log(n) = gercek_itki;
    
    % Gelecek dongu icin hatayi sakla
    onceki_hata = hata;
    
    % --- C. FIZIK MOTORU (Newton Laws) ---
    % F = m*a  ->  a = F_net / m
    yercekimi_kuvveti = m * g;
    net_kuvvet = gercek_itki - yercekimi_kuvveti;
    
    ivme = net_kuvvet / m;
    
    % Euler Integrasyonu (Konum ve Hizi guncelle)
    v(n+1) = v(n) + (ivme * dt); % Hiz guncelleme
    z(n+1) = z(n) + (v(n) * dt); % Konum guncelleme
    
    % Zemin Kontrolu (Yerin altina giremez)
    if z(n+1) < 0
        z(n+1) = 0;
        v(n+1) = 0;
    end
end

%% 6. GORSELLESTIRME (ANALIZ)
% -------------------------------------------------------------------------
figure('Name', 'PID Irtifa Kontrolu', 'Color', 'w');

% Grafik 1: Irtifa (Yukseklik)
subplot(2,1,1);
    plot(t, hedef_irtifa, 'g--', 'LineWidth', 1.5); hold on;
    plot(t, z, 'b', 'LineWidth', 2);
    yline(10, 'k:', 'Hedef');
    
    title('PID Irtifa Kontrol Performansi', 'FontSize', 12);
    ylabel('Yukseklik (metre)');
    legend('Hedeflenen', 'Gerceklesen (Drone)', 'Location', 'SouthEast');
    grid on;

% Grafik 2: Motor Gucu (Thrust)
subplot(2,1,2);
    plot(t, thrust_log, 'r', 'LineWidth', 1.5);
    yline(hover_thrust, 'k--', 'Hover Gucu (mg)');
    
    title('Motor Itki Komutu (Thrust)', 'FontSize', 12);
    xlabel('Zaman (saniye)');
    ylabel('Kuvvet (Newton)');
    grid on;

% Performans Raporu
fprintf('Maksimum Yukseklik: %.2f m\n', max(z));
fprintf('Yerlesme Zamani: Grafigi inceleyiniz.\n');