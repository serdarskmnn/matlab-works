%% ========================================================================
%  PROJE: IHA Otonom Hedef Tespiti ve Hassas Inis (Image Processing)
%  YAZAR: Serdar Sokmen
%  PLATFORM: MATLAB
%
%  ACIKLAMA:
%  Bu script, IHA'nin alt kamerasindan alinan goruntuyu isleyerek
%  yerdeki kirmizi renkli inis alanini (Target) tespit eder.
%
%  ALGORITMA ADIMLARI:
%  1. Sentetik bir kamera goruntusu olustur (Cimen ve Kirmizi Pist).
%  2. RGB renk uzayindan kirmizi kanali ayikla (Color Thresholding).
%  3. Gorultuleri temizle (Morphological Operations).
%  4. Nesnenin merkez koordinatlarini (Centroid) bul.
%  5. Hedefe kilitlen (Vizualizasyon).
% =========================================================================

clc; clear; close all;

%% 1. SANAL KAMERA GORUNTUSU OLUSTURMA
% -------------------------------------------------------------------------
% Gercek resim dosyasina ihtiyac duymadan, matrislerle resim ciziyoruz.
image_size = 500;
img = zeros(image_size, image_size, 3, 'uint8'); % Bos siyah resim

% A. Arkaplan: Yesil Cimen (Rastgele dokulu)
img(:,:,1) = randi([0, 50], image_size, image_size);    % R (Az)
img(:,:,2) = randi([100, 200], image_size, image_size); % G (Cok - Yesil)
img(:,:,3) = randi([0, 50], image_size, image_size);    % B (Az)

% B. Hedef: Kirmizi Bir Daire (Inis Alani)
% Hedefi resmin rastgele bir yerine koyalim
center_x = randi([100, 400]);
center_y = randi([100, 400]);
radius = 40;

[X, Y] = meshgrid(1:image_size, 1:image_size);
dist = sqrt((X - center_x).^2 + (Y - center_y).^2);
mask_circle = dist <= radius;

% Cemberin icini Kirmizi yapalim
r_channel = img(:,:,1); r_channel(mask_circle) = 255; img(:,:,1) = r_channel;
g_channel = img(:,:,2); g_channel(mask_circle) = 0;   img(:,:,2) = g_channel;
b_channel = img(:,:,3); b_channel(mask_circle) = 0;   img(:,:,3) = b_channel;

% C. Gurultu Ekle (Gercekci olsun diye bazi beyaz noktalar)
noise_spots = randi([1, image_size*image_size], 1, 50);
img(noise_spots) = 255;

%% 2. GORUNTU ISLEME (TARGET DETECTION)
% -------------------------------------------------------------------------
% Adim A: Renk Filtreleme (Kirmizi Nesneyi Bul)
% Kirmizi kanali yuksek, Yesil ve Mavi kanali dusuk olan yerleri ariyoruz.
red_threshold = img(:,:,1) > 150 & img(:,:,2) < 100 & img(:,:,3) < 100;

% Adim B: Temizlik (Morfolojik Islemler)
% Kucuk beyaz gurultu noktalarini yok et (Open islemi)
binary_mask = bwareaopen(red_threshold, 50); 

% Adim C: Nesne Analizi (Blob Analysis)
% Beyaz bolgenin ozelliklerini cikar
stats = regionprops(binary_mask, 'Centroid', 'Area', 'BoundingBox');

%% 3. SONUC VE GORSELLESTIRME
% -------------------------------------------------------------------------
figure('Name', 'Otonom Inis Hedef Tespiti', 'Color', 'w');

% Orjinal Kamera Goruntusu
subplot(1, 2, 1);
imshow(img);
title('IHA Alt Kamera Goruntusu (Ham)');

% Islenmis Goruntu ve Hedef
subplot(1, 2, 2);
imshow(img); hold on;
title('Tespit Edilen Hedef');

found_target = false;

% Bulunan nesneleri isaretle
for k = 1:length(stats)
    % Sadece belli bir buyuklukteki nesneleri hedef kabul et
    if stats(k).Area > 1000 
        found_target = true;
        centroid = stats(k).Centroid;
        box = stats(k).BoundingBox;
        
        % 1. Kutucuk icine al (Bounding Box)
        rectangle('Position', box, 'EdgeColor', 'y', 'LineWidth', 2);
        
        % 2. Merkezine Arti (+) Koy
        plot(centroid(1), centroid(2), 'y+', 'MarkerSize', 15, 'LineWidth', 2);
        
        % 3. Koordinatlari Yaz
        text(centroid(1), centroid(2)-30, ...
            sprintf('HEDEF KILITLENDI\nX: %0.0f, Y: %0.0f', centroid(1), centroid(2)), ...
            'Color', 'white', 'FontSize', 10, 'FontWeight', 'bold');
        
        % Konsol Ciktisi
        fprintf('HEDEF BULUNDU! Merkez Koordinatlari: X=%0.0f, Y=%0.0f\n', centroid(1), centroid(2));
        
        % PID Kontrolcusune gidecek Hata Degeri (Piksel cinsinden sapma)
        error_x = (image_size/2) - centroid(1);
        error_y = (image_size/2) - centroid(2);
        fprintf('Merkezden Sapma (Hata): X_err=%.0f, Y_err=%.0f\n', error_x, error_y);
    end
end

if ~found_target
    text(20, 20, 'HEDEF BULUNAMADI', 'Color', 'red', 'FontSize', 14);
    fprintf('Hedef tespit edilemedi.\n');
end