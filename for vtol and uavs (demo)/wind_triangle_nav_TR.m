%% ========================================================================
%  PROJE: IHA Ruzgar Ucgeni Navigasyon Cozucusu (Vektor Analizi)
%  YAZAR: Serdar Sokmen
%  PLATFORM: MATLAB
%
%  ACIKLAMA:
%  Otonom ucuslarda, IHA'nin burnunu sadece hedef noktaya (Waypoint) 
%  cevirmesi yetmez. Ruzgar IHA'yi rotadan saptirir (Suruklenme/Drift).
%  
%  Bu kod, Vektor Mekanigi kullanarak ruzgara karsi verilmesi gereken
%  "Duzeltme Acisini" (WCA) ve IHA'nin yere gore gercek hizini hesaplar.
%
%  TEMEL KAVRAMLAR (Ruzgar Ucgeni):
%  1. Hava Vektoru (Air Vector): IHA'nin burnunun baktigi yon ve hizi.
%  2. Ruzgar Vektoru (Wind Vector): Ruzgarin hizi ve yonu.
%  3. Yer Vektoru (Ground Vector): IHA'nin harita uzerindeki gercek izi.
%
%  Yer_Vektoru = Hava_Vektoru + Ruzgar_Vektoru (Vektorel Toplam)
% =========================================================================

clc; clear; close all;

%% 1. UCUS PARAMETRELERI (Girdiler)
% -------------------------------------------------------------------------
% IHA Performansi
TAS = 15;           % True Airspeed (Hava Hizi) - m/s
                    % IHA'nin havaya gore olan saf hizidir.

% Gorev Plani
istenen_rota = 0;   % Derece (0 = Kuzey, 90 = Dogu). Gitmek istedigimiz yol.

% Hava Durumu
ruzgar_hizi = 5;    % Ruzgar hizi (m/s)
ruzgar_yonu = 90;   % Ruzgarin GELDIGI yon (Derece)
                    % 90 derece, Dogudan Batiya esen ruzgar demektir.

%% 2. VEKTOR HESAPLAMALARI (Matematik Motoru)
% -------------------------------------------------------------------------
% Adim A: Radyan Donusumu (MATLAB trigonometrisi radyan calisir)
% Not: Havacilikta ruzgar "geldigi" yonle soylenir, ama vektor toplami icin
% ruzgarin "gittigi" yon lazimdir. O yuzden 180 derece ekliyoruz.
ruzgar_rad = deg2rad(ruzgar_yonu + 180); 
rota_rad = deg2rad(istenen_rota);

% Adim B: Ruzgar Vektorunu Bilesenlerine Ayir (X, Y)
% X ekseni Dogu-Bati, Y ekseni Kuzey-Guney
Wx = ruzgar_hizi * sin(ruzgar_rad);
Wy = ruzgar_hizi * cos(ruzgar_rad);

% Adim C: Ruzgar Duzeltme Acisini (WCA) Hesapla (Sinus Teoremi)
% Ruzgar acisi ile Rota acisi arasindaki fark
aci_farki = deg2rad(ruzgar_yonu - istenen_rota);

% WCA Formulu: IHA ruzgara karsi ne kadar "Yengecleme" yapmali?
% sin(WCA) = (Ruzgar_Hizi * sin(Aci_Farki)) / Hava_Hizi
wca_rad = asin((ruzgar_hizi * sin(aci_farki)) / TAS);
wca_derece = rad2deg(wca_rad);

% Adim D: Bas Acisini (Heading) Hesapla
% Bas Acisi = Istenen Rota + Duzeltme Acisi
% IHA burnunu bu aciya cevirmelidir.
bas_acisi = istenen_rota + wca_derece;

% Adim E: Yer Hizini (Ground Speed - GS) Hesapla (Kosinus Teoremi)
% Ruzgar arkadan eserse GS artar, onden eserse azalir.
GS = TAS * cos(wca_rad) + ruzgar_hizi * cos(aci_farki);

%% 3. GUVENLIK KONTROLLERI (Aviyonik Mantigi)
% -------------------------------------------------------------------------
ucus_guvenligi = true;
uyari_mesaji = 'UCUSA UYGUN';

% Kontrol 1: Ruzgar IHA'dan hizli mi?
if ruzgar_hizi >= TAS
    ucus_guvenligi = false;
    uyari_mesaji = 'KRITIK UYARI: Ruzgar hizi IHA hizini asiyor! IHA suruklenir.';
    GS = 0; % IHA aslinda geri geri gider
end

% Kontrol 2: Yer Hizi Sifir mi?
if GS <= 0
    ucus_guvenligi = false;
    uyari_mesaji = 'UYARI: Yer hizi yetersiz, hedefe varilamaz.';
end

%% 4. GORSELLESTIRME (Navigasyon Ekrani)
% -------------------------------------------------------------------------
figure('Name', 'Navigasyon Vektor Analizi', 'Color', 'w');
hold on; axis equal; grid on;

% Orijin (IHA'nin o anki konumu)
orijin = [0, 0];

% A. Ruzgar Vektorunu Ciz (Kirmizi)
quiver(0, 0, Wx, Wy, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.5);

% B. Hava Vektorunu Ciz (Mavi) - IHA'nin burnunun baktigi yer
bas_rad = deg2rad(bas_acisi);
Ax = TAS * sin(bas_rad);
Ay = TAS * cos(bas_rad);
quiver(0, 0, Ax, Ay, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.5);

% C. Yer Vektorunu Ciz (Yesil) - IHA'nin gercek izledigi yol (Resultant)
Gx = Ax + Wx;
Gy = Ay + Wy;
quiver(0, 0, Gx, Gy, 'g', 'LineWidth', 3, 'MaxHeadSize', 0.5);

% Grafik Duzeni (Pusula Gorunumu)
xlabel('Dogu / Bati (m/s)');
ylabel('Kuzey / Guney (m/s)');
title(sprintf('Ruzgar Ucgeni Analizi\nRuzgar: %.1f m/s, Yon: %d derece', ruzgar_hizi, ruzgar_yonu));
legend('Ruzgar Vektoru', 'Hava Vektoru (Heading)', 'Yer Vektoru (Gercek Rota)', 'Location', 'bestoutside');
xlim([-20 20]); ylim([-20 20]);

% Referans Cemberi
theta = linspace(0, 2*pi, 100);
plot(TAS*cos(theta), TAS*sin(theta), 'k:', 'LineWidth', 0.5); % Hava hizi limit cemberi

%% 5. GOREV RAPORU (Konsol Ciktisi)
% -------------------------------------------------------------------------
fprintf('--------------------------------------------------\n');
fprintf('     OTONOM NAVIGASYON COZUMU \n');
fprintf('--------------------------------------------------\n');
fprintf('Hedef Rota (Course) : %6.1f derece\n', istenen_rota);
fprintf('Ruzgar Verisi       : %6.1f m/s, %d dereceden\n', ruzgar_hizi, ruzgar_yonu);
fprintf('--------------------------------------------------\n');
if ucus_guvenligi
    fprintf('HESAPLANAN BAS ACISI: %6.1f derece (Yengecleme: %.1f)\n', bas_acisi, wca_derece);
    fprintf('HAVA HIZI (TAS)     : %6.1f m/s\n', TAS);
    fprintf('YER HIZI (GS)       : %6.1f m/s\n', GS);
    fprintf('Verimlilik          : %.1f%%\n', (GS/TAS)*100);
else
    fprintf('DURUM: %s\n', uyari_mesaji);
end
fprintf('--------------------------------------------------\n');