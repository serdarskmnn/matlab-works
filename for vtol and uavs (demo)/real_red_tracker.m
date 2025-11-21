%% GERCEK ZAMANLI HEDEF TAKIBI (FIXED - MORPHOLOGY)
%  Yazar: Serdar Sokmen
%  Duzeltme: 'imclose' kullanilarak parcali algilama sorunu cozuldu.

clc; clear; close all;

%% 1. KAMERAYI BASLAT
cam = webcam(); 
cam.Resolution = '1280x720'; 

figure('Name', 'IHA Gorus (Smart Filling)', 'Color', 'w');

% --- DIJITAL YAPISTIRICI (YENI) ---
% 5 piksel yaricapinda bir "firca" olusturuyoruz.
% Bu firca, ayrik duran kirmizi noktalari birlestirecek.
se = strel('disk', 5); 

fprintf('Takip Basladi. Cikis icin Ctrl+C.\n');

%% 2. SONSUZ DONGU
while true
    % A. Goruntu Al ve Kucult
    img_raw = snapshot(cam); 
    img = imresize(img_raw, 0.25); % 320x180 piksel
    
    % B. Renk Esikleme (Biraz daha gevsek tolerans)
    % Kirmizi sinirini 130'dan 100'e cektim ki daha kolay gorsun.
    redMask = (img(:,:,1) > 100) & ... 
              (img(:,:,2) < 100) & ... 
              (img(:,:,3) < 100);      
    
    % --- C. MORFOLOJIK ISLEM (TAMIR ETIYORUZ) ---
    % 1. "imclose": Delikleri kapatir ve yakin parcalari birlestirir.
    redMask = imclose(redMask, se);
    
    % 2. "imfill": Eger cismin icinde siyah delik kaldiysa doldurur.
    redMask = imfill(redMask, 'holes');
    
    % 3. Kucuk copleri temizle
    redMask = bwareaopen(redMask, 30);
    
    % D. Nesne Analizi
    stats = regionprops(redMask, 'BoundingBox', 'Centroid', 'Area');
    
    % E. Gorsellestirme
    imshow(img); hold on;
    
    maxArea = 0;
    targetIndex = 0;
    
    for k = 1:length(stats)
        if stats(k).Area > maxArea
            maxArea = stats(k).Area;
            targetIndex = k;
        end
    end
    
    if targetIndex > 0
        centroid = stats(targetIndex).Centroid;
        box = stats(targetIndex).BoundingBox;
        
        % Yesil Kutu (Bounding Box)
        rectangle('Position', box, 'EdgeColor', 'g', 'LineWidth', 2);
        
        % Tam Merkez (+)
        plot(centroid(1), centroid(2), 'g+', 'MarkerSize', 10, 'LineWidth', 2);
        
        % Hata Hesabi
        [rows, cols, ~] = size(img);
        imageCenter = [cols/2, rows/2];
        
        errorX = imageCenter(1) - centroid(1);
        errorY = imageCenter(2) - centroid(2);
        
        title(sprintf('KILITLENDI\nX Hata: %.0f | Y Hata: %.0f', errorX, errorY), ...
              'FontSize', 12, 'Color', 'g', 'FontWeight', 'bold');
          
        plot([imageCenter(1), centroid(1)], [imageCenter(2), centroid(2)], 'y--');
        
    else
        title('ARANIYOR...', 'FontSize', 12, 'Color', 'r');
    end
    
    drawnow; 
end