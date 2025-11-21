%% PROJECT: Virtual Target Tracking Simulation (No Webcam Required)
%  AUTHOR: Serdar Sokmen
%  DESCRIPTION:
%  This script simulates a moving red target on a virtual camera feed.
%  It allows testing Computer Vision algorithms without hardware.

clc; clear; close all;

%% 1. SETUP VIRTUAL CAMERA
image_size = 500;
t = 0; % Time variable for animation

figure('Name', 'Virtual Target Tracking', 'Color', 'w');

% Create a grid for drawing circles efficiently
[X, Y] = meshgrid(1:image_size, 1:image_size);

fprintf('Simulation Started. Press Ctrl+C to stop.\n');

%% 2. MAIN SIMULATION LOOP
while true
    % --- A. GENERATE SYNTHETIC IMAGE (The Virtual World) ---
    % Create a blank background (Dark Greenish - like grass at night)
    img = zeros(image_size, image_size, 3, 'uint8');
    img(:,:,2) = 50; 
    
    % Calculate Moving Target Position (Circular Path)
    % Moves in a circle: Center(250,250), Radius 150px
    t = t + 0.05; % Speed of movement
    target_x = 250 + 150 * cos(t);
    target_y = 250 + 150 * sin(t);
    
    % Draw the Red Target
    radius = 30;
    dist = sqrt((X - target_x).^2 + (Y - target_y).^2);
    mask = dist <= radius;
    
    % Set RGB values for the target (Red=255, G=0, B=0)
    r_ch = img(:,:,1); r_ch(mask) = 255; img(:,:,1) = r_ch;
    g_ch = img(:,:,2); g_ch(mask) = 0;   img(:,:,2) = g_ch;
    
    % Add some Noise (Simulate camera static)
    noise_spots = randi([1, numel(img)], 1, 1000);
    img(noise_spots) = 255;
    
    % --- B. YOUR COMPUTER VISION ALGORITHM STARTS HERE ---
    % (This part is exactly the same as Real Webcam code)
    
    % 1. Thresholding (Find Red Objects)
    % Logic: Red > 150 AND Green < 100 AND Blue < 100
    binaryMask = (img(:,:,1) > 150) & (img(:,:,2) < 100) & (img(:,:,3) < 100);
    
    % 2. Cleaning (Remove small noise dots)
    binaryMask = bwareaopen(binaryMask, 50);
    
    % 3. Blob Analysis (Find properties)
    stats = regionprops(binaryMask, 'BoundingBox', 'Centroid', 'Area');
    
    % --- C. VISUALIZATION & GUIDANCE ---
    imshow(img); hold on;
    
    found = false;
    
    % Find the largest object (The Target)
    maxArea = 0;
    idx = 0;
    for k = 1:length(stats)
        if stats(k).Area > maxArea
            maxArea = stats(k).Area;
            idx = k;
        end
    end
    
    if idx > 0
        found = true;
        centroid = stats(idx).Centroid;
        box = stats(idx).BoundingBox;
        
        % Draw Green Box around target
        rectangle('Position', box, 'EdgeColor', 'g', 'LineWidth', 3);
        
        % Draw Crosshair (+) at center
        plot(centroid(1), centroid(2), 'g+', 'MarkerSize', 15, 'LineWidth', 3);
        
        % Calculate Error (Distance from Image Center)
        % Center of image is (250, 250)
        err_x = (image_size/2) - centroid(1);
        err_y = (image_size/2) - centroid(2);
        
        % Display Info
        title(sprintf('TARGET LOCKED\nError X: %.0f | Error Y: %.0f', err_x, err_y), ...
              'FontSize', 14, 'Color', 'g');
          
        % Draw Guidance Line (Yellow dashed line)
        plot([image_size/2, centroid(1)], [image_size/2, centroid(2)], 'y--');
        
    else
        title('SEARCHING TARGET...', 'FontSize', 14, 'Color', 'r');
    end
    
    drawnow; % Force update screen
end