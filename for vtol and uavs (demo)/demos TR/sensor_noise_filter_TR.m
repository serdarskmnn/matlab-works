%% ========================================================================
%  PROJE: IHA Sensor Gurultu Filtreleme Simulasyonu (Alcak Geciren Filtre)
%  YAZAR: Serdar Sokmen
%  PLATFORM: MATLAB
%
%  ------------------------------------------------------------------------
%  ACIKLAMA VE AVIYONIK BAGLAMI:
%  ------------------------------------------------------------------------
%  Insansiz Hava Araclarinda (ozellikle Quadplane ve VTOL sistemlerde),
%  ivmeolcer ve jiroskop (IMU) verileri, fircasiz (BLDC) motorlarin ve
%  pervanelerin yarattigi mekanik titresimler nedeniyle "kirli" gelir.
%
%  Bu ham ve gurultulu veriyi dogrudan PID Ucus Kontrolcusune beslemek
%  sunlara yol acar:
%  1. Motorlarin asiri isinmasi (anlik titremelerden dolayi).
%  2. Ucus karararliliginin bozulmasi ve salinimlar (oscillations).
%  3. Hatali aci tahmini (AHRS sapmasi).
%
%  AMAC:
%  Bu kod, gurultulu bir yunuslama (pitch) acisi verisi uretir ve
%  "Birinci Dereceden Ayrik Alcak Geciren Filtre" (Low-Pass Filter)
%  kullanarak gercek ucus acisini gurultuden ayiklar.
%
%  MATEMATIKSEL MODEL (Fark Denklemi):
%  y[n] = alpha * x[n] + (1 - alpha) * y[n-1]
%
%  Degiskenler:
%  x[n]   : Su anki ham olcum (Gurultulu Giris)
%  y[n-1] : Bir onceki filtrelenmis tahmin (Hafiza)
%  alpha  : Yumusatma faktoru (0 < alpha < 1) -> Ayar Parametresi
%
%  Muhendislik Odunlesimi (Trade-off):
%  - Dusuk Alpha -> Cok puruzsuz sinyal ama YUKSEK GECIKME (Lag).
%  - Yuksek Alpha -> Dusuk gecikme ama GURULTULU sinyal.
% =========================================================================

clc; clear; close all;

%% 1. SIMULASYON AYARLARI
% -------------------------------------------------------------------------
sure = 10;              % Toplam simulasyon suresi (saniye)
ornekleme_hizi = 100;   % Hz (Pixhawk/Ardupilot standart dongu hizi)
dt = 1/ornekleme_hizi;  % Zaman adimi (0.01s)
t = 0:dt:sure;          % Zaman vektoru

%% 2. SINYAL OLUSTURMA (Sentetik Veri)
% -------------------------------------------------------------------------
% SENARYO:
% IHA havada yavasca burnunu yukari kaldirip indiriyor (Pitch hareketi).
% Frekans = 0.5 Hz (Bir tam hareket 2 saniye suruyor)
frekans = 0.5;
genlik = 10; % Derece (IHA 10 derece yukari/asagi oynuyor)

% Ideal (Gercek) Sinyal - Fizigin dikte ettigi gercek hareket
gercek_sinyal = genlik * sin(2 * pi * frekans * t);

% GURULTU EKLEME (Noise Generation):
% Dengesiz pervanelerin yarattigi yuksek frekansli titresimleri simule ediyoruz.
% 'randn' fonksiyonu Gauss (White) gurultusu uretir.
gurultu_siddeti = 4.0; % Yuksek titresim seviyesi (+/- 4 derece sapma)
gurultu = gurultu_siddeti * randn(size(t));

% HAM SENSOR VERISI:
% Ucus kartinin (MEMS sensorun) gercekte okudugu kirli veri budur.
sensor_okumasi = gercek_sinyal + gurultu;

%% 3. FILTRE ALGORITMASI (Uygulama)
% -------------------------------------------------------------------------
% AYAR PARAMETRESI: ALPHA KATSAYISI
% Aviyonik filtre tasarimindaki en kritik degerdir.
% Analog elektronikteki karsiligi: alpha = dt / (RC + dt)
%
% Bu degeri degistirerek sonuclari gozlemleyebilirsiniz:
% 0.05 -> Cok puruzsuz ama tepkisiz (Yaris dronlari icin kotu)
% 0.15 -> Dengeli (Sinema cekimi yapan dronlar icin iyi)
% 0.80 -> Cok atik ama gurultulu (Kucuk dronlar icin uygun)
alpha = 0.10;

% Hiz icin bellekten yer ayirma (MATLAB'da iyi kodlama pratigi)
filtrelenmis_sinyal = zeros(size(t));

% Baslangic Kosulu: IHA'nin ilk okunan degerde basladigini varsayiyoruz
filtrelenmis_sinyal(1) = sensor_okumasi(1);

% DONGU (Gercek Zamanli Islem Simulasyonu)
for n = 2:length(t)
    % ---------------------------------------------------------------------
    % ALGORITMA MANTIGI:
    % YENI gelen gurultulu verinin kucuk bir kismini (alpha),
    % ESKI temizlenmis verinin buyuk bir kismiyla (1-alpha) karistiriyoruz.
    % Bu "atalet", ani degisimlere (gurultuye) direnc gosterirken
    % yavas degisimlere (gercek harekete) izin verir.
    % ---------------------------------------------------------------------
    
    anlik_olcum = sensor_okumasi(n);
    onceki_tahmin = filtrelenmis_sinyal(n-1);
    
    % Alcak Geciren Filtre Formulu
    filtrelenmis_sinyal(n) = (alpha * anlik_olcum) + ...
                             ((1 - alpha) * onceki_tahmin);
end

%% 4. PERFORMANS ANALIZI VE GORSELLESTIRME
% -------------------------------------------------------------------------
figure('Name', 'Aviyonik Filtre Analizi', 'Color', 'w');

% Grafik 1: Zaman Bolgesi Karsilastirmasi
subplot(2,1,1);
    plot(t, sensor_okumasi, 'Color', [0.8, 0.8, 0.8], 'LineWidth', 0.5); hold on;
    plot(t, gercek_sinyal, 'g--', 'LineWidth', 2);
    plot(t, filtrelenmis_sinyal, 'r-', 'LineWidth', 2);
    
    title(sprintf('Alcak Geciren Filtre Performansi (Alpha = %.2f)', alpha), 'FontSize', 12);
    xlabel('Zaman (saniye)');
    ylabel('Yunuslama Acisi (derece)');
    legend('Ham Gurultulu Sensor', 'Gercek Hareket (Referans)', 'Filtrelenmis Cikti', 'Location', 'best');
    grid on;
    xlim([0 4]); % Net gormek icin ilk 4 saniyeye odaklan

% Grafik 2: Gecikme (Lag) Analizi
% Kontrol teorisinde "Faz Kaymasi" kritiktir. Gecikme cok yuksekse,
% PID kontrolcu cok gec tepki verir ve IHA'yi kararsizlastirir.
subplot(2,1,2);
    gecikme_hatasi = gercek_sinyal - filtrelenmis_sinyal;
    plot(t, gecikme_hatasi, 'b', 'LineWidth', 1.5);
    yline(0, 'k--');
    
    title('Filtre Gecikmesi (Gercek ve Filtrelenmis Arasindaki Fark)', 'FontSize', 12);
    xlabel('Zaman (saniye)');
    ylabel('Hata (derece)');
    legend('Takip Hatasi / Gecikme');
    grid on;
    xlim([0 4]);

% Komut Penceresi Ciktisi (Rapor)
fprintf('------------------------------------------------\n');
fprintf('SIMULASYON SONUCLARI:\n');
fprintf('------------------------------------------------\n');
fprintf('Ornekleme Hizi : %d Hz\n', ornekleme_hizi);
fprintf('Filtre Alpha   : %.2f\n', alpha);
fprintf('Maks Gurultu   : +/- %.1f derece\n', max(abs(gurultu)));
fprintf('Maks Gecikme   : %.2f derece (Ucus icin kabul edilebilir mi kontrol et)\n', max(abs(gecikme_hatasi)));
fprintf('------------------------------------------------\n');