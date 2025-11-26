# 🗺️ Project Roadmap & Engineering Master Plan

This document tracks the development progress of my Avionics, Control Theory, and Embedded Systems studies.

## 🟢 Phase 1: Fundamentals & Simulation (MATLAB/Simulink)
*Focus: Building the theoretical backbone and virtual testing environment.*

### ✅ Completed
- [x] **Signal Processing:** Discrete Low-Pass Filter implementation for noisy IMU data (`sensor_noise_filter.m`).
- [x] **Control Theory:** 1D Altitude PID Controller design & tuning (`pid_altitude_hold.slx`).
- [x] **Flight Dynamics:** 4-Axis Quadcopter Physics Engine & Motor Mixer (`quad_full_control.slx`).
- [x] **Visualization:** 3D Drone Animation connected to physics model via Simulink.
- [x] **Navigation:** Wind Triangle Vector Analysis for autonomous drift correction (`wind_triangle_nav.m`).
- [x] **Computer Vision:** Real-time Red Object Tracking algorithm with morphological operations (`real_red_tracker.m`).
- [x] **Integration:** MAVLink Communication Bridge (UDP) between Simulink & ArduPilot SITL.

### 🚧 In Progress (Current Focus)
- [ ] **Visual Servoing:** Connecting the "Vision Error" output to the Flight Controller PID (Camera-based control).
- [ ] **Modern Control:** Designing an LQR (Linear Quadratic Regulator) controller for the drone model.
- [ ] **State-Space Modeling:** Converting the physics model into $Ax+Bu$ matrix form.

### 📅 Backlog (Planned)
- [ ] **Battery Management (BMS):** Simulating Voltage Sag and Couloumb Counting logic.
- [ ] **VTOL Logic:** Implementing "Transition State Machine" (Quad <-> Plane) using Stateflow.
- [ ] **CAD Integration:** Importing custom VTOL design via Simscape Multibody.

---

## 🟡 Phase 2: Embedded Software & Flight Controller (C++)
*Focus: Moving from simulation to real hardware (STM32).*

### 🛠️ Hardware Setup
- [ ] Purchase **STM32 NUCLEO-F767ZI** development board.
- [ ] Setup **HIL (Hardware-in-the-Loop)** test bench with potentiometers (simulating sensors).

### 💻 Software Development
- [ ] **Bare Metal C++:** Blinking LED with registers (No Arduino libraries).
- [ ] **Drivers:** Writing I2C driver for IMU (MPU6050) and UART driver for GPS.
- [ ] **RTOS:** Implementing a basic Real-Time Operating System scheduler.
- [ ] **Porting:** Transferring the MATLAB PID algorithm to C++ code.

---

## 🔴 Phase 3: Professional Skills & Career Prep (The "Baykar" Goal)
*Focus: Filling the gaps to become a Systems Engineer.*

### 📚 Theory & Learning
- [ ] **Study:** Kalman Filter mathematics (Predict/Update steps).
- [ ] **Study:** C++ Memory Management (Pointers, References).
- [ ] **Certification:** Complete basic PCB design tutorial (Altium or KiCad) for schematic reading.

### 🏆 Portfolio & Outreach
- [x] **GitHub:** Organized "Showcase" vs "Archive" structure.
- [x] **Profile:** Added professional Bio and strategic status message.
- [ ] **LinkedIn:** Share a video of the "Visual Servoing" project once completed.