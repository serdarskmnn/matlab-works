%% ========================================================================
%  PROJECT: 1D Drone Altitude Control (PID Control Simulation)
%  AUTHOR: Serdar Sokmen
%  PLATFORM: MATLAB
%
%  DESCRIPTION:
%  This script simulates the physical dynamics and control loop of a
%  Quadcopter moving in the vertical axis (Z-axis).
%  
%  PHYSICAL MODEL (Newton's 2nd Law):
%  F_net = F_thrust - F_gravity - F_drag
%  acceleration = F_net / mass
%
%  CONTROL ALGORITHM (PID):
%  Error = Target_Altitude - Current_Altitude
%  Motor_Command = (Kp * Error) + (Ki * Integral) + (Kd * Derivative)
% =========================================================================

clc; clear; close all;

%% 1. DRONE PHYSICAL PARAMETERS
% -------------------------------------------------------------------------
m = 1.2;            % Mass of the drone (kg)
g = 9.81;           % Gravitational acceleration (m/s^2)
hover_thrust = m*g; % Theoretical force required to hover (Newton)
max_thrust = 2.5 * m * g; % Maximum motor thrust (Thrust-to-Weight Ratio = 2.5)

%% 2. PID GAIN TUNING
% -------------------------------------------------------------------------
% MODIFY THESE VALUES TO OBSERVE FLIGHT CHARACTERISTICS
% -------------------------------------------------------------------------
Kp = 3.0;   % P (Proportional): "Spring" effect. High P = Fast but shaky.
Ki = 1.5;   % I (Integral): Eliminates steady-state error (Gravity compensation).
Kd = 2.5;   % D (Derivative): "Damper". Resists change, reduces overshoot.

%% 3. SIMULATION SETTINGS
% -------------------------------------------------------------------------
duration = 15;          % Simulation duration (seconds)
dt = 0.01;              % Loop time step (100 Hz)
t = 0:dt:duration;      % Time vector

% Setpoint (Target Altitude)
target_altitude = zeros(size(t));
target_altitude(t > 1) = 10; % Command drone to fly to 10m after 1 second

%% 4. VARIABLE INITIALIZATION
% -------------------------------------------------------------------------
z = zeros(size(t));     % Position (Altitude)
v = zeros(size(t));     % Velocity (Vertical Speed)
thrust_log = zeros(size(t)); % To log motor commands

error_sum = 0;          % For Integral calculation
prev_error = 0;         % For Derivative calculation

%% 5. SIMULATION LOOP (CONTROL LOOP)
% -------------------------------------------------------------------------
fprintf('Simulation Started... Target: 10 Meters\n');

for n = 1:length(t)-1
    
    % --- A. SENSOR READING (Feedback) ---
    current_pos = z(n);
    current_vel = v(n);
    
    % --- B. PID CALCULATION (The Brain) ---
    error = target_altitude(n) - current_pos;
    
    % 1. Proportional Term
    P_term = Kp * error;
    
    % 2. Integral Term
    error_sum = error_sum + (error * dt);
    I_term = Ki * error_sum;
    
    % 3. Derivative Term (Resistance to velocity change)
    derivative = (error - prev_error) / dt;
    D_term = Kd * derivative;
    
    % PID Output (Desired Force in Newtons)
    desired_thrust = P_term + I_term + D_term;
    
    % Motor Saturation Limits
    % Motors cannot produce negative thrust or exceed max power
    actual_thrust = max(0, min(max_thrust, desired_thrust));
    thrust_log(n) = actual_thrust;
    
    % Store error for the next loop
    prev_error = error;
    
    % --- C. PHYSICS ENGINE (Newton's Laws) ---
    % F = m*a  ->  a = F_net / m
    gravity_force = m * g;
    net_force = actual_thrust - gravity_force;
    
    acceleration = net_force / m;
    
    % Euler Integration (Update Position and Velocity)
    v(n+1) = v(n) + (acceleration * dt); % Update Velocity
    z(n+1) = z(n) + (v(n) * dt);         % Update Position
    
    % Ground Collision Check
    if z(n+1) < 0
        z(n+1) = 0;
        v(n+1) = 0;
    end
end

%% 6. VISUALIZATION & ANALYSIS
% -------------------------------------------------------------------------
figure('Name', 'PID Altitude Control Analysis', 'Color', 'w');

% Plot 1: Altitude Response
subplot(2,1,1);
    plot(t, target_altitude, 'g--', 'LineWidth', 1.5); hold on;
    plot(t, z, 'b', 'LineWidth', 2);
    yline(10, 'k:', 'Target');
    
    title('PID Altitude Response', 'FontSize', 12);
    ylabel('Altitude (meters)');
    legend('Setpoint (Target)', 'Response (Drone)', 'Location', 'SouthEast');
    grid on;

% Plot 2: Motor Thrust Command
subplot(2,1,2);
    plot(t, thrust_log, 'r', 'LineWidth', 1.5);
    yline(hover_thrust, 'k--', 'Hover Thrust (mg)');
    
    title('Motor Thrust Command', 'FontSize', 12);
    xlabel('Time (seconds)');
    ylabel('Force (Newton)');
    grid on;

% Performance Report
fprintf('Max Altitude Reached: %.2f m\n', max(z));
fprintf('Check the plot for Overshoot and Settling Time.\n');