//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// File: ert_main.cpp
//
// Code generated for Simulink model 'quad_to_mission_planner'.
//
// Model version                  : 1.3
// Simulink Coder version         : 24.2 (R2024b) 21-Jun-2024
// C/C++ source code generated on : Thu Nov 27 11:07:27 2025
//
// Target selection: ert.tlc
// Embedded hardware selection: Intel->x86-64 (Windows64)
// Code generation objectives: Unspecified
// Validation result: Not run
//
#include <stdio.h>              // This example main program uses printf/fflush
#include "quad_to_mission_planner.h"   // Model header file

static quad_to_mission_planner quad_to_mission_planner_Obj;// Instance of model class 

//
// Associating rt_OneStep with a real-time clock or interrupt service routine
// is what makes the generated code "real-time".  The function rt_OneStep is
// always associated with the base rate of the model.  Subrates are managed
// by the base rate from inside the generated code.  Enabling/disabling
// interrupts and floating point context switches are target specific.  This
// example code indicates where these should take place relative to executing
// the generated code step function.  Overrun behavior should be tailored to
// your application needs.  This example simply sets an error status in the
// real-time model and returns from rt_OneStep.
//
void rt_OneStep(void);
void rt_OneStep(void)
{
  static boolean_T OverrunFlag{ false };

  // Disable interrupts here

  // Check for overrun
  if (OverrunFlag) {
    quad_to_mission_planner_Obj.getRTM()->setErrorStatus("Overrun");
    return;
  }

  OverrunFlag = true;

  // Save FPU context here (if necessary)
  // Re-enable timer or interrupt here
  // Set model inputs here

  // Step the model
  quad_to_mission_planner_Obj.step();

  // Get model outputs here

  // Indicate task complete
  OverrunFlag = false;

  // Disable interrupts here
  // Restore FPU context here (if necessary)
  // Enable interrupts here
}

//
// The example main function illustrates what is required by your
// application code to initialize, execute, and terminate the generated code.
// Attaching rt_OneStep to a real-time clock is target specific. This example
// illustrates how you do this relative to initializing the model.
//
int_T main(int_T argc, const char *argv[])
{
  // Unused arguments
  (void)(argc);
  (void)(argv);

  // Initialize model
  quad_to_mission_planner_Obj.initialize();

  // Simulating the model step behavior (in non real-time) to
  //   simulate model behavior at stop time.

  while (quad_to_mission_planner_Obj.getRTM()->getErrorStatus() == (nullptr)&&
         !quad_to_mission_planner_Obj.getRTM()->getStopRequested()) {
    rt_OneStep();
  }

  // Terminate model
  quad_to_mission_planner_Obj.terminate();
  return 0;
}

//
// File trailer for generated code.
//
// [EOF]
//
