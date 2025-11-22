%% PROJE: Sanal Hedef Takip Simulasyonu (Kamera Gerektirmez)
%  YAZAR: Serdar Sokmen
%  ACIKLAMA:
%  Bu script, sanal bir kamera goruntusu uzerinde hareket eden kirmizi bir
%  hedefi simule eder. Donanim (Webcam) olmadan algoritma test etmek icin idealdir.

clc; clear; close all;

%% 1. SANAL KAMERA AYARLARI
resim_boyutu = 500;
t = 0; % Animasyon icin zaman degiskeni

figure('Name', 'Sanal Hedef Takibi', 'Color', 'w');

% Cizim icin izgara (grid) olustur
[X, Y] = meshgrid(1:resim_boyutu, 1:resim_boyutu);

fprintf('Simulasyon Basladi. Durdurmak icin Ctrl+C yapin.\n');

%% 2. ANA SIMULASYON DONGUSU
while true
    % --- A. SENTETIK GORUNTU OLUSTURMA (Sanal Dunya) ---
    % Bos bir arkaplan olustur (Koyu Yesil - Gece cimeni gibi)
    img = zeros(resim_boyutu, resim_boyutu, 3, 'uint8');
    img(:,:,2) = 50; 
    
    % Hareketli Hedefin Konumunu Hesapla (Dairesel Rota)
    % Merkez(250,250) etrafinda 150px yaricapla doner
    t = t + 0.05; % Hareket hizi
    hedef_x = 250 + 150 * cos(t);
    hedef_y = 250 + 150 * sin(t);
    
    % Kirmizi Hedefi Ciz
    yaricap = 30;
    mesafe = sqrt((X - hedef_x).^2 + (Y - hedef_y).^2);
    maske = mesafe <= yaricap;
    
    % RGB Degerlerini Ata (Kirmizi=255, Yesil=0, Mavi=0)
    r_kanal = img(:,:,1); r_kanal(maske) = 255; img(:,:,1) = r_kanal;
    g_kanal = img(:,:,2); g_kanal(maske) = 0;   img(:,:,2) = g_kanal;
    
    % Gurultu Ekle (Kamera karincalanmasi simulasyonu)
    gurultu_noktalari = randi([1, numel(img)], 1, 1000);
    img(gurultu_noktalari) = 255;
    
    % --- B. GORUNTU ISLEME ALGORITMASI BURADA BASLAR ---
    
    % 1. Renk Esikleme (Thresholding - Kirmiziyi Bul)
    % Mantik: Kirmizi > 150 VE Yesil < 100 VE Mavi < 100
    binaryMask = (img(:,:,1) > 150) & (img(:,:,2) < 100) & (img(:,:,3) < 100);
    
    % 2. Temizlik (Kucuk gürültü noktalarini sil)
    binaryMask = bwareaopen(binaryMask, 50);
    
    % 3. Nesne Analizi (Blob Analysis - Ozellik Cikarma)
    istatistikler = regionprops(binaryMask, 'BoundingBox', 'Centroid', 'Area');
    
    % --- C. GORSELLESTIRME VE GUDUM ---
    imshow(img); hold on;
    
    bulundu = false;
    
    % En buyuk nesneyi bul (Asil Hedef)
    maxAlan = 0;
    idx = 0;
    for k = 1:length(istatistikler)
        if istatistikler(k).Area > maxAlan
            maxAlan = istatistikler(k).Area;
            idx = k;
        end
    end
    
    if idx > 0
        bulundu = true;
        merkez = istatistikler(idx).Centroid;
        kutu = istatistikler(idx).BoundingBox;
        
        % Hedefin etrafina Yesil Kutu ciz
        rectangle('Position', kutu, 'EdgeColor', 'g', 'LineWidth', 3);
        
        % Tam merkeze Arti (+) koy
        plot(merkez(1), merkez(2), 'g+', 'MarkerSize', 15, 'LineWidth', 3);
        
        % Hata Hesabi (Goruntu Merkezinden Sapma)
        % Resmin merkezi (250, 250)
        hata_x = (resim_boyutu/2) - merkez(1);
        hata_y = (resim_boyutu/2) - merkez(2);
        
        % Bilgiyi Ekrana Yaz
        title(sprintf('HEDEF KILITLENDI\nHata X: %.0f | Hata Y: %.0f', hata_x, hata_y), ...
              'FontSize', 14, 'Color', 'g');
          
        % Gudum Cizgisi (Merkezden Hedefe Sari Cizgi)
        plot([resim_boyutu/2, merkez(1)], [resim_boyutu/2, merkez(2)], 'y--');
        
    else
        title('HEDEF ARANIYOR...', 'FontSize', 14, 'Color', 'r');
    end
    
    drawnow; % Ekrani guncelle
end