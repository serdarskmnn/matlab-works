%% REAL-TIME TARGET TRACKING (OPTIMIZED & ROBUST)
%  Author: Serdar Sokmen
%  Feature: Uses 'Morphological Closing' to fix fragmented detection issues.
%  Optimization: Image resizing for higher FPS.

clc; clear; close all;

%% 1. INITIALIZE CAMERA
cam = webcam(); 
cam.Resolution = '1280x720'; 

figure('Name', 'UAV Vision System (Smart Filling)', 'Color', 'w');

% --- MORPHOLOGICAL KERNEL ---
% Create a disk-shaped structuring element with radius 5 pixels.
% This acts as a "digital glue" to connect separated red pixels.
se = strel('disk', 5); 

fprintf('Tracking Started. Press Ctrl+C to stop.\n');

%% 2. MAIN LOOP
while true
    % A. Capture & Resize
    img_raw = snapshot(cam); 
    % Downsample to 25% size (320x180) for speed
    img = imresize(img_raw, 0.25); 
    
    % B. Color Thresholding (Red Detection)
    % Threshold lowered to 100 to detect red objects in lower light.
    redMask = (img(:,:,1) > 100) & ... 
              (img(:,:,2) < 100) & ... 
              (img(:,:,3) < 100);      
    
    % --- C. MORPHOLOGICAL OPERATIONS (REPAIR) ---
    % 1. "imclose": Closes small holes and connects nearby blobs.
    redMask = imclose(redMask, se);
    
    % 2. "imfill": Fills black holes inside the object.
    redMask = imfill(redMask, 'holes');
    
    % 3. Cleaning: Remove small noise artifacts
    redMask = bwareaopen(redMask, 30);
    
    % D. Blob Analysis
    stats = regionprops(redMask, 'BoundingBox', 'Centroid', 'Area');
    
    % E. Visualization
    imshow(img); hold on;
    
    maxArea = 0;
    targetIndex = 0;
    
    % Find the largest object
    for k = 1:length(stats)
        if stats(k).Area > maxArea
            maxArea = stats(k).Area;
            targetIndex = k;
        end
    end
    
    if targetIndex > 0
        centroid = stats(targetIndex).Centroid;
        box = stats(targetIndex).BoundingBox;
        
        % Draw Green Bounding Box
        rectangle('Position', box, 'EdgeColor', 'g', 'LineWidth', 2);
        
        % Mark Center (+)
        plot(centroid(1), centroid(2), 'g+', 'MarkerSize', 10, 'LineWidth', 2);
        
        % Calculate Error (Deviation from center)
        [rows, cols, ~] = size(img);
        imageCenter = [cols/2, rows/2];
        
        errorX = imageCenter(1) - centroid(1);
        errorY = imageCenter(2) - centroid(2);
        
        title(sprintf('LOCKED\nX Error: %.0f | Y Error: %.0f', errorX, errorY), ...
              'FontSize', 12, 'Color', 'g', 'FontWeight', 'bold');
          
        % Guidance Line
        plot([imageCenter(1), centroid(1)], [imageCenter(2), centroid(2)], 'y--');
        
    else
        title('SEARCHING...', 'FontSize', 12, 'Color', 'r');
    end
    
    drawnow; 
end