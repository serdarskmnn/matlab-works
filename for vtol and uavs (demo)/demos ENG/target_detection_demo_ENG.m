%% ========================================================================
%  PROJECT: UAV Autonomous Target Detection & Precision Landing (Computer Vision)
%  AUTHOR: Serdar Sokmen
%  PLATFORM: MATLAB
%
%  DESCRIPTION:
%  This script processes imagery from a downward-facing UAV camera to
%  detect a specific landing target (Red Helipad).
%
%  ALGORITHM PIPELINE:
%  1. Generate Synthetic Camera Feed (Grass & Red Landing Pad).
%  2. Color Thresholding (Isolate Red Channel from RGB).
%  3. Noise Reduction (Morphological Operations).
%  4. Blob Analysis (Find Centroid & Bounding Box).
%  5. Guidance Logic (Calculate deviation from center).
% =========================================================================

clc; clear; close all;

%% 1. VIRTUAL CAMERA FEED GENERATION
% -------------------------------------------------------------------------
% Instead of loading a file, we create a synthetic environment matrix.
image_size = 500;
img = zeros(image_size, image_size, 3, 'uint8'); % Blank black image

% A. Background: Green Grass (Random texture)
img(:,:,1) = randi([0, 50], image_size, image_size);    % R (Low)
img(:,:,2) = randi([100, 200], image_size, image_size); % G (High - Green)
img(:,:,3) = randi([0, 50], image_size, image_size);    % B (Low)

% B. Target: Red Circular Helipad
% Randomly place the target within the frame
center_x = randi([100, 400]);
center_y = randi([100, 400]);
radius = 40;

[X, Y] = meshgrid(1:image_size, 1:image_size);
dist = sqrt((X - center_x).^2 + (Y - center_y).^2);
mask_circle = dist <= radius;

% Paint the circle Red
r_channel = img(:,:,1); r_channel(mask_circle) = 255; img(:,:,1) = r_channel;
g_channel = img(:,:,2); g_channel(mask_circle) = 0;   img(:,:,2) = g_channel;
b_channel = img(:,:,3); b_channel(mask_circle) = 0;   img(:,:,3) = b_channel;

% C. Add Noise (Simulate sensor static or white debris)
noise_spots = randi([1, image_size*image_size], 1, 50);
img(noise_spots) = 255;

%% 2. IMAGE PROCESSING PIPELINE
% -------------------------------------------------------------------------
% Step A: Color Thresholding (Find Red Objects)
% Logic: Red channel must be high, Green and Blue must be low.
red_threshold = img(:,:,1) > 150 & img(:,:,2) < 100 & img(:,:,3) < 100;

% Step B: Cleaning (Morphological Operations)
% Remove small white noise dots (Opening operation)
binary_mask = bwareaopen(red_threshold, 50); 

% Step C: Blob Analysis
% Extract properties of the white regions
stats = regionprops(binary_mask, 'Centroid', 'Area', 'BoundingBox');

%% 3. VISUALIZATION & GUIDANCE
% -------------------------------------------------------------------------
figure('Name', 'Autonomous Landing Target Detection', 'Color', 'w');

% Original Camera Feed
subplot(1, 2, 1);
imshow(img);
title('UAV Downward Camera (Raw)');

% Processed Feed with Overlay
subplot(1, 2, 2);
imshow(img); hold on;
title('Detected Target & Guidance');

found_target = false;

% Iterate through detected blobs
for k = 1:length(stats)
    % Filter by Area: Ignore objects smaller than 1000 pixels
    if stats(k).Area > 1000 
        found_target = true;
        centroid = stats(k).Centroid;
        box = stats(k).BoundingBox;
        
        % 1. Draw Bounding Box
        rectangle('Position', box, 'EdgeColor', 'y', 'LineWidth', 2);
        
        % 2. Mark the Center (+)
        plot(centroid(1), centroid(2), 'y+', 'MarkerSize', 15, 'LineWidth', 2);
        
        % 3. Display Coordinates
        text(centroid(1), centroid(2)-30, ...
            sprintf('TARGET LOCKED\nX: %0.0f, Y: %0.0f', centroid(1), centroid(2)), ...
            'Color', 'white', 'FontSize', 10, 'FontWeight', 'bold');
        
        % Console Report
        fprintf('TARGET FOUND! Centroid: X=%0.0f, Y=%0.0f\n', centroid(1), centroid(2));
        
        % Calculate Error for PID Controller (Deviation from Image Center)
        error_x = (image_size/2) - centroid(1);
        error_y = (image_size/2) - centroid(2);
        fprintf('Guidance Error: X_err=%.0f, Y_err=%.0f (Pixels)\n', error_x, error_y);
    end
end

if ~found_target
    text(20, 20, 'NO TARGET FOUND', 'Color', 'red', 'FontSize', 14);
    fprintf('Status: Searching for target...\n');
end