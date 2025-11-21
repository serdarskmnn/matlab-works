%% ========================================================================
%  PROJECT: UAV Wind Triangle Navigation Solver (Vector Analysis)
%  AUTHOR: Serdar Sokmen
%  PLATFORM: MATLAB
%
%  DESCRIPTION:
%  In autonomous flight, a UAV cannot simply point its nose at the target
%  waypoint because wind will push it off course (Drift).
%  
%  This script calculates the required "Wind Correction Angle" (WCA) and
%  the resulting "Ground Speed" (GS) using Vector Mechanics.
%
%  THE WIND TRIANGLE CONCEPT:
%  1. Air Vector (Heading & True Airspeed - TAS)
%  2. Wind Vector (Wind Direction & Speed - WS)
%  3. Ground Vector (Course & Ground Speed - GS)
%
%  Ground_Vector = Air_Vector + Wind_Vector
%
%  INPUTS:
%  - Desired Course (Where we want to go)
%  - Wind Speed & Direction (Meteorological Data)
%  - Drone Cruise Speed (TAS)
% =========================================================================

clc; clear; close all;

%% 1. FLIGHT PARAMETERS (User Inputs)
% -------------------------------------------------------------------------
% Drone Performance
TAS = 15;           % True Airspeed (m/s) - Speed relative to air mass

% Mission Plan
desired_course = 0; % Degrees (0 = North, 90 = East). Target path.

% Weather Conditions
wind_speed = 5;     % Wind speed in m/s
wind_dir = 90;      % Wind coming FROM this direction (Degrees)
                    % 90 deg means wind is blowing FROM East TO West.

%% 2. VECTOR CALCULATIONS (The Math Engine)
% -------------------------------------------------------------------------
% Step A: Convert everything to Radians for MATLAB trigonometry
% Note: In aviation, wind is reported "FROM", but mathematically we need
% the vector "TO". So we flip the wind direction by 180 degrees.
wind_to_rad = deg2rad(wind_dir + 180); 
course_rad = deg2rad(desired_course);

% Step B: Decompose Wind Vector (X, Y components)
% X is East-West, Y is North-South
Wx = wind_speed * sin(wind_to_rad);
Wy = wind_speed * cos(wind_to_rad);

% Step C: Calculate Wind Correction Angle (WCA) using Sine Rule
% Angle difference between Wind and Course
angle_diff = deg2rad(wind_dir - desired_course);

% WCA Formula: sin(WCA) = (Wind_Speed * sin(Wind_Angle - Course)) / TAS
% This tells us how much we need to "crab" into the wind.
wca_rad = asin((wind_speed * sin(angle_diff)) / TAS);
wca_deg = rad2deg(wca_rad);

% Step D: Calculate Heading (Where the nose points)
% Heading = Course + WCA
heading_deg = desired_course + wca_deg;

% Step E: Calculate Ground Speed (GS) using Cosine Rule
% GS = TAS * cos(WCA) + Wind * cos(Wind_Angle - Course)
GS = TAS * cos(wca_rad) + wind_speed * cos(angle_diff);

%% 3. SAFETY CHECKS (Avionics Logic)
% -------------------------------------------------------------------------
flight_safety = true;
warning_msg = 'FLIGHT OK';

% Check 1: Is Wind stronger than Drone?
if wind_speed >= TAS
    flight_safety = false;
    warning_msg = 'CRITICAL WARNING: Wind speed exceeds Airspeed! Return Home.';
    GS = 0; % Drone effectively moves backwards
end

% Check 2: Ground Speed Check
if GS <= 0
    flight_safety = false;
    warning_msg = 'WARNING: Ground Speed is zero or negative.';
end

%% 4. VISUALIZATION (Navigation Display)
% -------------------------------------------------------------------------
figure('Name', 'Navigation Vector Analysis', 'Color', 'w');
hold on; axis equal; grid on;

% Origin point (Current Drone Position)
origin = [0, 0];

% A. Draw Wind Vector (Red)
% Plotting wind relative to the drone
quiver(0, 0, Wx, Wy, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.5);

% B. Draw Air Vector (Blue) - Where the nose is pointing
heading_rad = deg2rad(heading_deg);
Ax = TAS * sin(heading_rad);
Ay = TAS * cos(heading_rad);
quiver(0, 0, Ax, Ay, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.5);

% C. Draw Ground Vector (Green) - The actual path (Resultant)
Gx = Ax + Wx;
Gy = Ay + Wy;
quiver(0, 0, Gx, Gy, 'g', 'LineWidth', 3, 'MaxHeadSize', 0.5);

% Formatting the Plot (Compass Style)
xlabel('East / West (m/s)');
ylabel('North / South (m/s)');
title(sprintf('Wind Triangle Analysis\nWind: %.1f m/s @ %d deg', wind_speed, wind_dir));
legend('Wind Vector', 'Air Vector (Heading)', 'Ground Vector (Resultant)', 'Location', 'bestoutside');
xlim([-20 20]); ylim([-20 20]);

% Draw a Compass Circle for reference
theta = linspace(0, 2*pi, 100);
plot(TAS*cos(theta), TAS*sin(theta), 'k:', 'LineWidth', 0.5); % Airspeed limit circle

%% 5. MISSION REPORT (Console Output)
% -------------------------------------------------------------------------
fprintf('--------------------------------------------------\n');
fprintf('     AUTONOMOUS NAVIGATION SOLUTION \n');
fprintf('--------------------------------------------------\n');
fprintf('Target Course    : %6.1f deg (Plan)\n', desired_course);
fprintf('Wind Condition   : %6.1f m/s from %d deg\n', wind_speed, wind_dir);
fprintf('--------------------------------------------------\n');
if flight_safety
    fprintf('CALCULATED HEADING : %6.1f deg (Crab Angle: %.1f)\n', heading_deg, wca_deg);
    fprintf('TRUE AIRSPEED (TAS): %6.1f m/s\n', TAS);
    fprintf('GROUND SPEED (GS)  : %6.1f m/s\n', GS);
    fprintf('Effective Efficiency: %.1f%%\n', (GS/TAS)*100);
else
    fprintf('STATUS: %s\n', warning_msg);
end
fprintf('--------------------------------------------------\n');