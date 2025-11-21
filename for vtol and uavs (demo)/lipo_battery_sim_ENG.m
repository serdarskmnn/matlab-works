%% ========================================================================
%  PROJECT: Li-Po Battery Discharge & Endurance Simulator
%  AUTHOR: Serdar Sokmen
%  PLATFORM: MATLAB
%
%  DESCRIPTION:
%  Accurately estimating flight time is critical for UAV safety.
%  Simple timers are dangerous because wind or aggressive flying consumes
%  more energy.
%
%  This script models a Li-Po battery discharge curve, accounting for:
%  1. State of Charge (SoC) vs. Open Circuit Voltage (OCV) non-linearity.
%  2. Voltage Sag due to Internal Resistance (V_drop = I * R_internal).
%  3. Variable Load Profile (Takeoff vs Cruise current draw).
% =========================================================================

clc; clear; close all;

%% 1. BATTERY CHARACTERISTICS (6S Li-Po Setup)
% -------------------------------------------------------------------------
cell_count = 6;             % 6S Battery
capacity_mah = 5000;        % Capacity in milliamp-hours
R_internal = 0.015;         % Internal Resistance per cell (Ohms) - approx
initial_voltage_per_cell = 4.20; 

% Simplified Li-Po Discharge Curve (Lookup Table)
% SoC (%) : 100, 90,  80,  70,  60,  50,  40,  30,  20,  10,  0
% Volts   : 4.2, 4.1, 4.0, 3.9, 3.85, 3.8, 3.75, 3.7, 3.6, 3.4, 3.0
soc_lookup = [100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 0];
ocv_lookup = [4.20, 4.13, 4.06, 3.98, 3.92, 3.85, 3.78, 3.71, 3.63, 3.35, 3.00];

%% 2. MISSION PROFILE (Current Draw over Time)
% -------------------------------------------------------------------------
% We create a mission timeline: Takeoff -> Cruise -> Landing
duration = 1200; % 20 minutes max simulation (seconds)
dt = 1;          % 1 second steps
t = 0:dt:duration;

current_draw = zeros(size(t));

% Define Flight Phases (Amperes)
for i = 1:length(t)
    if t(i) < 60
        current_draw(i) = 45; % TAKEOFF (High power - VTOL Mode)
    elseif t(i) < 900
        current_draw(i) = 15; % CRUISE (Efficient - Plane Mode)
    elseif t(i) < 1000
        current_draw(i) = 40; % LANDING (Hover - VTOL Mode)
    else
        current_draw(i) = 0;  % Mission End
    end
end

%% 3. SIMULATION LOOP (Energy Integration)
% -------------------------------------------------------------------------
consumed_mah = 0;
voltage_log = zeros(size(t));
soc_log = zeros(size(t));
failsafe_triggered = false;
failsafe_time = 0;

fprintf('Simulation Started: 6S %d mAh Battery\n', capacity_mah);

for n = 1:length(t)
    
    % A. Calculate Consumed Energy (Coulomb Counting)
    % Amps * Seconds / 3600 = Amp-hours
    current_amps = current_draw(n);
    consumed_mah = consumed_mah + (current_amps * dt * 1000 / 3600);
    
    % B. Calculate Remaining State of Charge (SoC)
    remaining_mah = capacity_mah - consumed_mah;
    current_soc = (remaining_mah / capacity_mah) * 100;
    
    if current_soc < 0; current_soc = 0; end
    soc_log(n) = current_soc;
    
    % C. Look up Open Circuit Voltage (OCV) from Curve
    % Using linear interpolation to find voltage for current SoC
    cell_ocv = interp1(soc_lookup, ocv_lookup, current_soc, 'linear');
    
    % D. Calculate Voltage Sag (Ohm's Law)
    % V_terminal = V_ocv - (Current * Resistance)
    v_sag = current_amps * R_internal;
    
    % Total Voltage (All cells)
    total_voltage = (cell_ocv * cell_count) - (v_sag * cell_count);
    voltage_log(n) = total_voltage;
    
    % E. Failsafe Check (RTL Trigger)
    % Standard Low Battery Warning is around 3.5V per cell under load
    low_batt_threshold = 3.5 * cell_count;
    
    if total_voltage < low_batt_threshold && ~failsafe_triggered
        failsafe_triggered = true;
        failsafe_time = t(n);
    end
    
    % Stop simulation if battery is dead
    if total_voltage < (3.0 * cell_count)
        voltage_log(n:end) = total_voltage;
        fprintf('BATTERY DEPLETED at t = %.1f seconds!\n', t(n));
        break;
    end
end

%% 4. VISUALIZATION
% -------------------------------------------------------------------------
figure('Name', 'Battery Discharge Analysis', 'Color', 'w');

% Plot 1: Current Draw (The Mission)
subplot(2,1,1);
    area(t, current_draw, 'FaceColor', [0.2, 0.6, 0.8], 'FaceAlpha', 0.3);
    ylabel('Current (Amps)');
    title('Mission Profile (Current Consumption)');
    grid on;
    legend('Load Profile (Amps)');

% Plot 2: Voltage Sag & Depletion
subplot(2,1,2);
    plot(t, voltage_log, 'r', 'LineWidth', 2); hold on;
    yline(3.5 * cell_count, 'k--', 'RTL Warning (3.5V/cell)');
    
    title('Battery Voltage Response (with Voltage Sag)');
    xlabel('Time (seconds)');
    ylabel('Voltage (V)');
    grid on;
    
    if failsafe_triggered
        xline(failsafe_time, 'b-', 'FAILSAFE TRIGGERED');
    end

%% 5. REPORT
% -------------------------------------------------------------------------
fprintf('--------------------------------------\n');
fprintf('Consumed Capacity : %.1f mAh\n', consumed_mah);
if failsafe_triggered
    fprintf('RTL Triggered at  : %.1f seconds\n', failsafe_time);
else
    fprintf('Mission Completed without Low Battery Warning.\n');
end
fprintf('--------------------------------------\n');