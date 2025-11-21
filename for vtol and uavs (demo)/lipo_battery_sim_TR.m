%% ========================================================================
%  PROJE: Li-Po Batarya Desarj ve Menzil Simulasyonu
%  YAZAR: Serdar Sokmen
%  PLATFORM: MATLAB
%
%  ACIKLAMA:
%  IHA ucus guvenligi icin en kritik parametre ucus suresi tahminidir.
%  Sadece kronometre tutmak tehlikelidir cunku ruzgarli havalarda veya
%  agresif ucuslarda motorlar daha fazla akim ceker.
%
%  Bu kod, asagidaki faktorleri iceren gercekci bir Li-Po modelidir:
%  1. Sarj Durumu (SoC) ve Acik Devre Gerilimi (OCV) iliskisi.
%  2. Ic Direnc kaynakli "Gerilim Cokmesi" (Voltage Sag).
%  3. Degisken Gorev Yuku (Kalkis, Duz Ucus, Inis).
% =========================================================================

clc; clear; close all;

%% 1. BATARYA OZELLIKLERI (6S Li-Po Kurulumu)
% -------------------------------------------------------------------------
hucre_sayisi = 6;           % 6S Batarya
kapasite_mah = 5000;        % Miliamper-saat cinsinden kapasite
R_ic_direnc = 0.015;        % Hucre basi Ic Direnc (Ohm) - yaklasik
baslangic_voltaji = 4.20; 

% Basitlestirilmis Li-Po Desarj Egrisi (Referans Tablosu)
% Bu veriler tipik bir Li-Po pilin kimyasal karakteristigidir.
% SoC (%) : 100, 90,  80,  70,  60,  50,  40,  30,  20,  10,  0
% Volt    : 4.2, 4.1, 4.0, 3.9, 3.85, 3.8, 3.75, 3.7, 3.6, 3.4, 3.0
soc_tablosu = [100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 0];
ocv_tablosu = [4.20, 4.13, 4.06, 3.98, 3.92, 3.85, 3.78, 3.71, 3.63, 3.35, 3.00];

%% 2. GOREV PROFILI (Zamanla Degisen Akim Cekimi)
% -------------------------------------------------------------------------
% Bir IHA gorev senaryosu olusturuyoruz: Kalkis -> Seyir -> Inis
sure = 1200;    % 20 dakika maksimum simulasyon suresi (saniye)
dt = 1;         % 1 saniyelik adimlar
t = 0:dt:sure;

akim_cekimi = zeros(size(t));

% Ucus Fazlarini Tanimla (Amper)
for i = 1:length(t)
    if t(i) < 60
        akim_cekimi(i) = 45; % KALKIS (Yuksek Guc - VTOL Modu)
    elseif t(i) < 900
        akim_cekimi(i) = 15; % SEYIR (Verimli - Ucak Modu)
    elseif t(i) < 1000
        akim_cekimi(i) = 40; % INIS (Hover - VTOL Modu)
    else
        akim_cekimi(i) = 0;  % Gorev Bitti / Motorlar Kapali
    end
end

%% 3. SIMULASYON DONGUSU (Enerji Integrasyonu)
% -------------------------------------------------------------------------
tuketilen_mah = 0;
voltaj_kaydi = zeros(size(t));
soc_kaydi = zeros(size(t));
eve_donus_tetiklendi = false;
tetiklenme_zamani = 0;

fprintf('Simulasyon Basladi: 6S %d mAh Batarya\n', kapasite_mah);

for n = 1:length(t)
    
    % A. Tuketilen Enerjiyi Hesapla (Coulomb Sayimi)
    % Amper * Saniye formulu ile toplam tuketimi buluyoruz.
    anlik_akim = akim_cekimi(n);
    tuketilen_mah = tuketilen_mah + (anlik_akim * dt * 1000 / 3600);
    
    % B. Kalan Sarj Durumunu (SoC) Hesapla
    kalan_mah = kapasite_mah - tuketilen_mah;
    anlik_soc = (kalan_mah / kapasite_mah) * 100;
    
    if anlik_soc < 0; anlik_soc = 0; end
    soc_kaydi(n) = anlik_soc;
    
    % C. Desarj Egrisinden Voltaj Okuma (Interpolasyon)
    % Elimizdeki SoC yuzdesine karsilik gelen voltaji tablodan buluyoruz.
    hucre_voltaji = interp1(soc_tablosu, ocv_tablosu, anlik_soc, 'linear');
    
    % D. Gerilim Cokmesi (Voltage Sag) Hesabi
    % Ohm Yasasi: V_dususu = Akim * Ic_Direnc
    % Gaz verdiginizde voltajin neden aniden dustugunu bu satir aciklar.
    v_cokmesi = anlik_akim * R_ic_direnc;
    
    % Toplam Batarya Voltaji (Tum hucreler dahil)
    toplam_voltaj = (hucre_voltaji * hucre_sayisi) - (v_cokmesi * hucre_sayisi);
    voltaj_kaydi(n) = toplam_voltaj;
    
    % E. Eve Donus (RTL) Kontrolu
    % Genelde yuk altinda hucre basi 3.5V kritik seviyedir.
    dusuk_pil_siniri = 3.5 * hucre_sayisi;
    
    if toplam_voltaj < dusuk_pil_siniri && ~eve_donus_tetiklendi
        eve_donus_tetiklendi = true;
        tetiklenme_zamani = t(n);
    end
    
    % Pil tamamen bittiyse simulasyonu durdur
    if toplam_voltaj < (3.0 * hucre_sayisi)
        voltaj_kaydi(n:end) = toplam_voltaj;
        fprintf('BATARYA TUKENDI! t = %.1f saniye\n', t(n));
        break;
    end
end

%% 4. GORSELLESTIRME
% -------------------------------------------------------------------------
figure('Name', 'Batarya Desarj Analizi', 'Color', 'w');

% Grafik 1: Akim Cekimi (Gorev Profili)
subplot(2,1,1);
    area(t, akim_cekimi, 'FaceColor', [0.2, 0.6, 0.8], 'FaceAlpha', 0.3);
    ylabel('Akim (Amper)');
    title('Gorev Yuku Profili (Kalkis - Seyir - Inis)');
    grid on;
    legend('Motor Akimi');

% Grafik 2: Voltaj Dususu
subplot(2,1,2);
    plot(t, voltaj_kaydi, 'r', 'LineWidth', 2); hold on;
    yline(3.5 * hucre_sayisi, 'k--', 'RTL Uyari Siniri (3.5V/hucre)');
    
    title('Batarya Voltaj Tepkisi (Voltage Sag Dahil)');
    xlabel('Zaman (saniye)');
    ylabel('Voltaj (V)');
    grid on;
    
    if eve_donus_tetiklendi
        xline(tetiklenme_zamani, 'b-', 'RTL TETIKLENDI');
    end

%% 5. SONUC RAPORU
% -------------------------------------------------------------------------
fprintf('--------------------------------------\n');
fprintf('Tuketilen Kapasite : %.1f mAh\n', tuketilen_mah);
if eve_donus_tetiklendi
    fprintf('RTL Tetiklendi     : %.1f saniyede\n', tetiklenme_zamani);
else
    fprintf('Gorev, Dusuk Pil Uyarisi almadan tamamlandi.\n');
end
fprintf('--------------------------------------\n');