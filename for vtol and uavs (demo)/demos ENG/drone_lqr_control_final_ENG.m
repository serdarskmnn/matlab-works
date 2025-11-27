%% LQR DRONE ALTITUDE CONTROL (WITH GROUND CONSTRAINTS)
%  Author: Serdar Sokmen
%  Description: 
%  This script simulates a 1D vertical landing of a drone using an LQR controller.
%  Unlike basic linear simulations, this script includes:
%  1. Gravity Compensation (Feedforward term to counteract weight).
%  2. Physical Ground Constraint (Drone cannot go below z=0).
%  3. Motor Saturation (Thrust limits).

clc; clear; close all;

% --- 1. PHYSICAL SYSTEM MODEL (State-Space) ---
% State Vector x = [Position (z); Velocity (v)]
% Input u = [Thrust Force]

m = 1.2;   % Drone Mass (kg)
g = 9.81;  % Gravitational Acceleration (m/s^2)

% A Matrix: System Dynamics (dx = Ax + Bu)
% dz/dt = v
% dv/dt = 0 (Internal dynamics without drag)
A = [0  1; 
     0  0];

% B Matrix: Input Influence
% Force creates acceleration (a = F/m)
B = [0; 
     1/m];

% --- 2. LQR CONTROLLER DESIGN ---
% Q Matrix: Penalty on State Error (Accuracy)
% Q(1,1) = 100 -> High penalty on position error (Priority: Reach target).
% Q(2,2) = 1   -> Low penalty on velocity.
Q = [100  0; 
     0    1];

% R Matrix: Penalty on Control Effort (Energy Efficiency)
% R = 0.1 -> Low penalty, allows aggressive motor usage.
R = 0.1;

% Calculate Optimal Gain Matrix (K)
% u_optimal = -K * x
K = lqr(A, B, Q, R);
disp('Optimal LQR Gain (K):'); disp(K);

% --- 3. CUSTOM SIMULATION LOOP (Physics Engine) ---
% We use a custom loop instead of 'initial()' to implement ground collision logic.

dt = 0.01;       % Time Step (10 ms)
T_final = 5;     % Simulation Duration (seconds)
time = 0:dt:T_final;

% Pre-allocate arrays for logging data
pos_log = zeros(1, length(time));
vel_log = zeros(1, length(time));
u_log   = zeros(1, length(time));

% Initial Conditions
x = [10; 0]; % Start at 10 meters altitude, 0 velocity.
% Goal: Land at 0 meters (State [0;0]).

for i = 1:length(time)
    
    % 1. Log Current State
    pos_log(i) = x(1);
    vel_log(i) = x(2);
    
    % 2. LQR Control Law (Feedback)
    % u_lqr = -K * error (Assuming target state is [0;0])
    u_lqr = -K * x;
    
    % --- GRAVITY COMPENSATION (Feedforward) ---
    % LQR assumes a linear system around equilibrium. 
    % In reality, we need to constantly fight gravity (mg) to hover.
    % Without this term, the drone would sag below the target.
    u_total = u_lqr + (m * g); 
    
    % Motor Saturation (Physical Limits)
    % Motors cannot produce negative thrust or infinite power.
    if u_total > 30; u_total = 30; end % Max Thrust (N)
    if u_total < 0; u_total = 0;   end % Min Thrust (N)
    
    u_log(i) = u_total; % Log control input
    
    % 3. Physics Integration (Euler Method)
    % Net Acceleration = (Thrust / Mass) - Gravity
    acceleration = (u_total / m) - g; 
    
    x(2) = x(2) + acceleration * dt;     % Update Velocity
    x(1) = x(1) + x(2) * dt;             % Update Position
    
    % --- GROUND CONSTRAINT (Safety Check) ---
    % If position drops below 0, it means the drone hit the ground.
    if x(1) <= 0
        x(1) = 0; % Clamp position to ground level
        x(2) = 0; % Stop velocity (Crash/Land)
        
        % Optional: Cut motors on ground impact
        % u_total = 0; 
    end
end

% --- 4. VISUALIZATION ---
figure('Name', 'LQR Landing Simulation', 'Color', 'w');

% Plot 1: Altitude
subplot(3,1,1);
plot(time, pos_log, 'LineWidth', 2);
yline(0, 'k--', 'Ground Level');
ylabel('Altitude (m)'); grid on;
title('Drone Position Response');

% Plot 2: Velocity
subplot(3,1,2);
plot(time, vel_log, 'r', 'LineWidth', 2);
ylabel('Velocity (m/s)'); grid on;
title('Vertical Velocity');

% Plot 3: Motor Output
subplot(3,1,3);
plot(time, u_log, 'g', 'LineWidth', 2);
yline(m*g, 'b:', 'Hover Thrust (mg)');
ylabel('Thrust (N)'); grid on;
xlabel('Time (s)');
title('Control Input (Thrust)');