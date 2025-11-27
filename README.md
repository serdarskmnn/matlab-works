# ✈️ Avionics & UAV Control Systems Library

![MATLAB](https://img.shields.io/badge/MATLAB-R2024b-orange) ![Simulink](https://img.shields.io/badge/Simulink-Control_Systems-blue) ![Status](https://img.shields.io/badge/Status-Active-green)

## 📖 Overview
This repository serves as a comprehensive R&D portfolio for **Unmanned Aerial Vehicles (UAVs)**, bridging the gap between theoretical engineering calculations and practical flight simulations. It includes both advanced avionics projects and fundamental algorithm implementations using **MATLAB & Simulink**.

Developed by **Serdar Sökmen**, Electrical-Electronics Engineering Student @ Bursa Technical University.

---

## 🚀 Part 1: Advanced Avionics & UAV Projects
*(Located in: `/for vtol and uavs (demo)`)*

### 1. 🚁 6-DOF Flight Controller Simulation
* **Description:** A full-scale physics simulation of a Quadcopter frame in Simulink.
* **Core:** Implements a **Cascaded PID** loop structure (Position -> Velocity -> Attitude -> Rate).
* **Physics:** Custom MATLAB Function blocks calculating rigid body dynamics using **Euler Equations**.
* **Features:** Motor Mixing Algorithm (Quad-X), Aerodynamic Drag, and 3D Visualization.

### 2. 👁️ Computer Vision & Autonomous Tracking
* **Description:** Real-time object detection algorithm designed for autonomous precision landing.
* **Algorithm:** Color Thresholding (HSV/RGB) + Morphological Operations (`imclose`) + Blob Analysis.
* **Output:** Calculates pixel deviation errors $(E_x, E_y)$ to feed into the guidance loop.

### 3. 🧭 Autonomous Navigation (Wind Triangle)
* **Description:** A vector analysis tool for mission planning under wind conditions.
* **Math:** Solves the "Wind Triangle" problem to calculate **Crab Angle (WCA)** and **Ground Speed (GS)**.

### 4. 🔋 Power Systems: Li-Po Battery Model
* **Description:** Simulation of Li-Po battery discharge characteristics.
* **Key Feature:** Models **Voltage Sag** due to internal resistance and estimates flight endurance based on load profiles.

### 5. 📉 Signal Processing: Sensor Fusion
* **Description:** Discrete Low-Pass Filter implementation to clean raw IMU data corrupted by motor vibrations.

---

## 📚 Part 2: Academic & Theoretical Modules
*(Located in: `/numerical methods`, `/control systems`, `/calculus`, etc.)*

This section contains fundamental algorithms and coursework implementations that form the mathematical backbone of the advanced projects above.

### 1. 🧮 Numerical Analysis
**Path:** `/numerical methods`
Implementation of core algorithms for solving complex mathematical problems computationally:
* **Root Finding:** Bisection Method, Newton-Raphson, Secant Method.
* **Integration:** Trapezoidal Rule, Simpson's 1/3 Rule.
* **Differential Equations:** Runge-Kutta Methods (RK4) for solving ODEs.
* **Interpolation:** Lagrange and Spline interpolation techniques.

### 2. 🕹️ Control Theory Fundamentals
**Path:** `/control systems`
Basic simulations and analysis tools for classical control theory:
* **System Analysis:** Step Response, Impulse Response, and Bode Plots.
* **Stability:** Root Locus analysis for SISO systems.
* **PID Design:** Tuning basics and feedback loop implementation.

### 3. 📐 Applied Mathematics
**Path:** `/calculus` & `/linear algebra` & `/differential_equations`
* **Symbolic Math:** Derivative and Integral calculations using MATLAB Symbolic Toolbox.
* **Matrix Operations:** Linear transformations, Eigenvalue/Eigenvector problems.
* **ODE/PDE:** Exact solutions for first and second-order differential equations.

---

## ⚡ Part 3: Electronics & Circuit Design
*(Located in: `/electronics_circuit_designs`)*

Simulation and analysis of analog/digital circuits using Simscape Electrical.

### 1. Common Emitter Amplifier Design
**Path:** `/electronics_circuit_designs/common_emitter_amplifier`
* **Description:** A complete analog signal chain simulation including a Linear Power Supply (Transformer + Rectifier + Zener) and a BJT Amplifier.
* **Analysis:** Verifies Voltage Gain ($A_v$), Ripple Factor, and Q-point biasing stability.
* **Visuals:** Includes scope outputs for transient analysis.

---

## 💻 Tech Stack
* **Languages:** MATLAB (`.m`), Simulink (`.slx`), MAVLink Protocol.
* **Toolboxes:** UAV Toolbox, Aerospace Blockset, Image Processing Toolbox, Symbolic Math Toolbox.
* **Simulation:** ArduPilot SITL, Gazebo (Co-Simulation capable).

## 🚀 Installation & Usage
1.  Clone the repository:
    ```bash
    git clone [https://github.com/serdarskmnn/matlab-works.git](https://github.com/serdarskmnn/matlab-works.git)
    ```
2.  **For UAV Projects:** Navigate to the `for vtol and uavs (demo)` folder.
3.  **For Academic Scripts:** Navigate to the respective folder (e.g., `numerical methods`).
4.  Run the `.m` scripts directly or open `.slx` files in Simulink.

---

## 👨‍💻 Author & Contact
**Serdar Sökmen**
* **Focus:** Avionics, Embedded Systems, VTOL UAV Design.
* **License:** UAV Pilot
* **Contact:** [LinkedIn Profile](https://www.linkedin.com/in/mserdarsokmen/)

---
*If you find these engineering resources useful, please consider starring the repository! ⭐*
