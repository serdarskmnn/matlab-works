//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// File: quad_to_mission_planner.h
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
#ifndef quad_to_mission_planner_h_
#define quad_to_mission_planner_h_
#include <cmath>
#include "rtwtypes.h"
#include "mavlinkcodegen_api.hpp"
#include "DAHostLib_Network.h"
#include "quad_to_mission_planner_types.h"

// Class declaration for model quad_to_mission_planner
class quad_to_mission_planner final
{
  // public data and function members
 public:
  // Block signals (default storage)
  struct B_quad_to_mission_planner_T {
    real_T Z;                          // '<Root>/Drone Dynamics'
    real_T Phi;                        // '<Root>/Drone Dynamics'
    real_T Theta;                      // '<Root>/Drone Dynamics'
    real_T Psi;                        // '<Root>/Drone Dynamics'
    uint8_T MAVLinkEncoderBlock_o1[21];// '<S8>/MAVLinkEncoderBlock'
    uint8_T MAVLinkEncoderBlock_o1_h[40];// '<S7>/MAVLinkEncoderBlock'
    uint8_T MAVLinkEncoderBlock_o1_p[32];// '<S6>/MAVLinkEncoderBlock'
  };

  // Block states (default storage) for system '<Root>'
  struct DW_quad_to_mission_planner_T {
    uav_sluav_internal_system_M_a_T obj;// '<S8>/MAVLinkEncoderBlock'
    uav_sluav_internal_system_M_a_T obj_e;// '<S7>/MAVLinkEncoderBlock'
    uav_sluav_internal_system_M_a_T obj_f;// '<S6>/MAVLinkEncoderBlock'
    real_T UnitDelay_DSTATE;           // '<Root>/Unit Delay'
    real_T UnitDelay2_DSTATE;          // '<Root>/Unit Delay2'
    real_T UnitDelay3_DSTATE;          // '<Root>/Unit Delay3'
    real_T UnitDelay1_DSTATE;          // '<Root>/Unit Delay1'
    real_T Integrator_DSTATE;          // '<S49>/Integrator'
    real_T Filter_DSTATE;              // '<S44>/Filter'
    real_T Integrator_DSTATE_h;        // '<S101>/Integrator'
    real_T Filter_DSTATE_a;            // '<S96>/Filter'
    real_T Integrator_DSTATE_c;        // '<S153>/Integrator'
    real_T Filter_DSTATE_g;            // '<S148>/Filter'
    real_T Integrator_DSTATE_f;        // '<S205>/Integrator'
    real_T Filter_DSTATE_k;            // '<S200>/Filter'
    real_T UDPSend_NetworkLib[137];    // '<Root>/UDP Send'
    real_T UDPSend1_NetworkLib[137];   // '<Root>/UDP Send1'
    real_T UDPSend2_NetworkLib[137];   // '<Root>/UDP Send2'
    real_T p_Z;                        // '<Root>/Drone Dynamics'
    real_T p_Phi;                      // '<Root>/Drone Dynamics'
    real_T p_Theta;                    // '<Root>/Drone Dynamics'
    real_T p_Psi;                      // '<Root>/Drone Dynamics'
    real_T v_Z;                        // '<Root>/Drone Dynamics'
    real_T v_Phi;                      // '<Root>/Drone Dynamics'
    real_T v_Theta;                    // '<Root>/Drone Dynamics'
    real_T v_Psi;                      // '<Root>/Drone Dynamics'
    uav_sluav_internal_system_MAV_T obj_n;// '<S5>/MsgModifier'
    uav_sluav_internal_system_MAV_T obj_fu;// '<S4>/MsgModifier'
    uav_sluav_internal_system_MAV_T obj_l;// '<S3>/MsgModifier'
  };

  // Invariant block signals (default storage)
  struct ConstB_quad_to_mission_planne_T {
    real_T Sum1;                       // '<S10>/Sum1'
    real_T Sum2;                       // '<S10>/Sum2'
    real_T Sum3;                       // '<S10>/Sum3'
  };

  // Real-time Model Data Structure
  struct RT_MODEL_quad_to_mission_plan_T {
    const char_T *errorStatus;
    RTWSolverInfo solverInfo;

    //
    //  Timing:
    //  The following substructure contains information regarding
    //  the timing information for the model.

    struct {
      uint32_T clockTick0;
      time_T stepSize0;
      uint32_T clockTick1;
      struct {
        uint8_T TID[3];
      } TaskCounters;

      SimTimeStep simTimeStep;
      boolean_T stopRequestedFlag;
      time_T *t;
      time_T tArray[3];
    } Timing;

    time_T** getTPtrPtr();
    time_T* getTPtr() const;
    void setTPtr(time_T* aTPtr);
    boolean_T* getStopRequestedPtr();
    boolean_T isMinorTimeStep() const;
    boolean_T isMajorTimeStep() const;
    const char_T** getErrorStatusPtr();
    boolean_T getStopRequested() const;
    void setStopRequested(boolean_T aStopRequested);
    const char_T* getErrorStatus() const;
    void setErrorStatus(const char_T* const aErrorStatus);
  };

  // Copy Constructor
  quad_to_mission_planner(quad_to_mission_planner const&) = delete;

  // Assignment Operator
  quad_to_mission_planner& operator= (quad_to_mission_planner const&) & = delete;

  // Move Constructor
  quad_to_mission_planner(quad_to_mission_planner &&) = delete;

  // Move Assignment Operator
  quad_to_mission_planner& operator= (quad_to_mission_planner &&) = delete;

  // Real-Time Model get method
  quad_to_mission_planner::RT_MODEL_quad_to_mission_plan_T * getRTM();

  // model initialize function
  void initialize();

  // model step function
  void step();

  // model terminate function
  void terminate();

  // Constructor
  quad_to_mission_planner();

  // Destructor
  ~quad_to_mission_planner();

  // private data and function members
 private:
  // Block signals
  B_quad_to_mission_planner_T quad_to_mission_planner_B;

  // Block states
  DW_quad_to_mission_planner_T quad_to_mission_planner_DW;

  // Real-Time Model
  RT_MODEL_quad_to_mission_plan_T quad_to_mission_planner_M;
};

extern const quad_to_mission_planner::ConstB_quad_to_mission_planne_T
  quad_to_mission_planner_ConstB;      // constant block i/o

//-
//  These blocks were eliminated from the model due to optimizations:
//
//  Block '<Root>/Scope' : Unused code path elimination
//  Block '<Root>/Scope1' : Unused code path elimination
//  Block '<Root>/Scope2' : Unused code path elimination
//  Block '<Root>/Scope3' : Unused code path elimination
//  Block '<Root>/Band-Limited White Noise' : Unused code path elimination
//  Block '<Root>/Band-Limited White Noise' : Unused code path elimination
//  Block '<Root>/Chirp Signal' : Unused code path elimination
//  Block '<Root>/Chirp Signal' : Unused code path elimination
//  Block '<Root>/Chirp Signal' : Unused code path elimination
//  Block '<Root>/Chirp Signal' : Unused code path elimination
//  Block '<Root>/Chirp Signal' : Unused code path elimination
//  Block '<Root>/Chirp Signal' : Unused code path elimination
//  Block '<Root>/Chirp Signal' : Unused code path elimination
//  Block '<Root>/Chirp Signal' : Unused code path elimination
//  Block '<Root>/Chirp Signal' : Unused code path elimination
//  Block '<Root>/Chirp Signal' : Unused code path elimination


//-
//  The generated code includes comments that allow you to trace directly
//  back to the appropriate location in the model.  The basic format
//  is <system>/block_name, where system is the system number (uniquely
//  assigned by Simulink) and block_name is the name of the block.
//
//  Use the MATLAB hilite_system command to trace the generated code back
//  to the model.  For example,
//
//  hilite_system('<S3>')    - opens system 3
//  hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
//
//  Here is the system hierarchy for this model
//
//  '<Root>' : 'quad_to_mission_planner'
//  '<S1>'   : 'quad_to_mission_planner/Drone Dynamics'
//  '<S2>'   : 'quad_to_mission_planner/Euler2Quat'
//  '<S3>'   : 'quad_to_mission_planner/MAVLink Blank Message'
//  '<S4>'   : 'quad_to_mission_planner/MAVLink Blank Message1'
//  '<S5>'   : 'quad_to_mission_planner/MAVLink Blank Message2'
//  '<S6>'   : 'quad_to_mission_planner/MAVLink Serializer'
//  '<S7>'   : 'quad_to_mission_planner/MAVLink Serializer1'
//  '<S8>'   : 'quad_to_mission_planner/MAVLink Serializer2'
//  '<S9>'   : 'quad_to_mission_planner/MotorMixer'
//  '<S10>'  : 'quad_to_mission_planner/Subsystem'
//  '<S11>'  : 'quad_to_mission_planner/Subsystem/PID Controller'
//  '<S12>'  : 'quad_to_mission_planner/Subsystem/PID Controller1'
//  '<S13>'  : 'quad_to_mission_planner/Subsystem/PID Controller2'
//  '<S14>'  : 'quad_to_mission_planner/Subsystem/PID Controller3'
//  '<S15>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Anti-windup'
//  '<S16>'  : 'quad_to_mission_planner/Subsystem/PID Controller/D Gain'
//  '<S17>'  : 'quad_to_mission_planner/Subsystem/PID Controller/External Derivative'
//  '<S18>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Filter'
//  '<S19>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Filter ICs'
//  '<S20>'  : 'quad_to_mission_planner/Subsystem/PID Controller/I Gain'
//  '<S21>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Ideal P Gain'
//  '<S22>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Ideal P Gain Fdbk'
//  '<S23>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Integrator'
//  '<S24>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Integrator ICs'
//  '<S25>'  : 'quad_to_mission_planner/Subsystem/PID Controller/N Copy'
//  '<S26>'  : 'quad_to_mission_planner/Subsystem/PID Controller/N Gain'
//  '<S27>'  : 'quad_to_mission_planner/Subsystem/PID Controller/P Copy'
//  '<S28>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Parallel P Gain'
//  '<S29>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Reset Signal'
//  '<S30>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Saturation'
//  '<S31>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Saturation Fdbk'
//  '<S32>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Sum'
//  '<S33>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Sum Fdbk'
//  '<S34>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Tracking Mode'
//  '<S35>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Tracking Mode Sum'
//  '<S36>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Tsamp - Integral'
//  '<S37>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Tsamp - Ngain'
//  '<S38>'  : 'quad_to_mission_planner/Subsystem/PID Controller/postSat Signal'
//  '<S39>'  : 'quad_to_mission_planner/Subsystem/PID Controller/preInt Signal'
//  '<S40>'  : 'quad_to_mission_planner/Subsystem/PID Controller/preSat Signal'
//  '<S41>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Anti-windup/Passthrough'
//  '<S42>'  : 'quad_to_mission_planner/Subsystem/PID Controller/D Gain/Internal Parameters'
//  '<S43>'  : 'quad_to_mission_planner/Subsystem/PID Controller/External Derivative/Error'
//  '<S44>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Filter/Disc. Forward Euler Filter'
//  '<S45>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Filter ICs/Internal IC - Filter'
//  '<S46>'  : 'quad_to_mission_planner/Subsystem/PID Controller/I Gain/Internal Parameters'
//  '<S47>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Ideal P Gain/Passthrough'
//  '<S48>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Ideal P Gain Fdbk/Disabled'
//  '<S49>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Integrator/Discrete'
//  '<S50>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Integrator ICs/Internal IC'
//  '<S51>'  : 'quad_to_mission_planner/Subsystem/PID Controller/N Copy/Disabled'
//  '<S52>'  : 'quad_to_mission_planner/Subsystem/PID Controller/N Gain/Internal Parameters'
//  '<S53>'  : 'quad_to_mission_planner/Subsystem/PID Controller/P Copy/Disabled'
//  '<S54>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Parallel P Gain/Internal Parameters'
//  '<S55>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Reset Signal/Disabled'
//  '<S56>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Saturation/Passthrough'
//  '<S57>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Saturation Fdbk/Disabled'
//  '<S58>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Sum/Sum_PID'
//  '<S59>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Sum Fdbk/Disabled'
//  '<S60>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Tracking Mode/Disabled'
//  '<S61>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Tracking Mode Sum/Passthrough'
//  '<S62>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Tsamp - Integral/TsSignalSpecification'
//  '<S63>'  : 'quad_to_mission_planner/Subsystem/PID Controller/Tsamp - Ngain/Passthrough'
//  '<S64>'  : 'quad_to_mission_planner/Subsystem/PID Controller/postSat Signal/Forward_Path'
//  '<S65>'  : 'quad_to_mission_planner/Subsystem/PID Controller/preInt Signal/Internal PreInt'
//  '<S66>'  : 'quad_to_mission_planner/Subsystem/PID Controller/preSat Signal/Forward_Path'
//  '<S67>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Anti-windup'
//  '<S68>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/D Gain'
//  '<S69>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/External Derivative'
//  '<S70>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Filter'
//  '<S71>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Filter ICs'
//  '<S72>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/I Gain'
//  '<S73>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Ideal P Gain'
//  '<S74>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Ideal P Gain Fdbk'
//  '<S75>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Integrator'
//  '<S76>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Integrator ICs'
//  '<S77>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/N Copy'
//  '<S78>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/N Gain'
//  '<S79>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/P Copy'
//  '<S80>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Parallel P Gain'
//  '<S81>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Reset Signal'
//  '<S82>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Saturation'
//  '<S83>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Saturation Fdbk'
//  '<S84>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Sum'
//  '<S85>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Sum Fdbk'
//  '<S86>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Tracking Mode'
//  '<S87>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Tracking Mode Sum'
//  '<S88>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Tsamp - Integral'
//  '<S89>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Tsamp - Ngain'
//  '<S90>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/postSat Signal'
//  '<S91>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/preInt Signal'
//  '<S92>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/preSat Signal'
//  '<S93>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Anti-windup/Passthrough'
//  '<S94>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/D Gain/Internal Parameters'
//  '<S95>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/External Derivative/Error'
//  '<S96>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Filter/Disc. Forward Euler Filter'
//  '<S97>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Filter ICs/Internal IC - Filter'
//  '<S98>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/I Gain/Internal Parameters'
//  '<S99>'  : 'quad_to_mission_planner/Subsystem/PID Controller1/Ideal P Gain/Passthrough'
//  '<S100>' : 'quad_to_mission_planner/Subsystem/PID Controller1/Ideal P Gain Fdbk/Disabled'
//  '<S101>' : 'quad_to_mission_planner/Subsystem/PID Controller1/Integrator/Discrete'
//  '<S102>' : 'quad_to_mission_planner/Subsystem/PID Controller1/Integrator ICs/Internal IC'
//  '<S103>' : 'quad_to_mission_planner/Subsystem/PID Controller1/N Copy/Disabled'
//  '<S104>' : 'quad_to_mission_planner/Subsystem/PID Controller1/N Gain/Internal Parameters'
//  '<S105>' : 'quad_to_mission_planner/Subsystem/PID Controller1/P Copy/Disabled'
//  '<S106>' : 'quad_to_mission_planner/Subsystem/PID Controller1/Parallel P Gain/Internal Parameters'
//  '<S107>' : 'quad_to_mission_planner/Subsystem/PID Controller1/Reset Signal/Disabled'
//  '<S108>' : 'quad_to_mission_planner/Subsystem/PID Controller1/Saturation/Passthrough'
//  '<S109>' : 'quad_to_mission_planner/Subsystem/PID Controller1/Saturation Fdbk/Disabled'
//  '<S110>' : 'quad_to_mission_planner/Subsystem/PID Controller1/Sum/Sum_PID'
//  '<S111>' : 'quad_to_mission_planner/Subsystem/PID Controller1/Sum Fdbk/Disabled'
//  '<S112>' : 'quad_to_mission_planner/Subsystem/PID Controller1/Tracking Mode/Disabled'
//  '<S113>' : 'quad_to_mission_planner/Subsystem/PID Controller1/Tracking Mode Sum/Passthrough'
//  '<S114>' : 'quad_to_mission_planner/Subsystem/PID Controller1/Tsamp - Integral/TsSignalSpecification'
//  '<S115>' : 'quad_to_mission_planner/Subsystem/PID Controller1/Tsamp - Ngain/Passthrough'
//  '<S116>' : 'quad_to_mission_planner/Subsystem/PID Controller1/postSat Signal/Forward_Path'
//  '<S117>' : 'quad_to_mission_planner/Subsystem/PID Controller1/preInt Signal/Internal PreInt'
//  '<S118>' : 'quad_to_mission_planner/Subsystem/PID Controller1/preSat Signal/Forward_Path'
//  '<S119>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Anti-windup'
//  '<S120>' : 'quad_to_mission_planner/Subsystem/PID Controller2/D Gain'
//  '<S121>' : 'quad_to_mission_planner/Subsystem/PID Controller2/External Derivative'
//  '<S122>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Filter'
//  '<S123>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Filter ICs'
//  '<S124>' : 'quad_to_mission_planner/Subsystem/PID Controller2/I Gain'
//  '<S125>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Ideal P Gain'
//  '<S126>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Ideal P Gain Fdbk'
//  '<S127>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Integrator'
//  '<S128>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Integrator ICs'
//  '<S129>' : 'quad_to_mission_planner/Subsystem/PID Controller2/N Copy'
//  '<S130>' : 'quad_to_mission_planner/Subsystem/PID Controller2/N Gain'
//  '<S131>' : 'quad_to_mission_planner/Subsystem/PID Controller2/P Copy'
//  '<S132>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Parallel P Gain'
//  '<S133>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Reset Signal'
//  '<S134>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Saturation'
//  '<S135>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Saturation Fdbk'
//  '<S136>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Sum'
//  '<S137>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Sum Fdbk'
//  '<S138>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Tracking Mode'
//  '<S139>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Tracking Mode Sum'
//  '<S140>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Tsamp - Integral'
//  '<S141>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Tsamp - Ngain'
//  '<S142>' : 'quad_to_mission_planner/Subsystem/PID Controller2/postSat Signal'
//  '<S143>' : 'quad_to_mission_planner/Subsystem/PID Controller2/preInt Signal'
//  '<S144>' : 'quad_to_mission_planner/Subsystem/PID Controller2/preSat Signal'
//  '<S145>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Anti-windup/Passthrough'
//  '<S146>' : 'quad_to_mission_planner/Subsystem/PID Controller2/D Gain/Internal Parameters'
//  '<S147>' : 'quad_to_mission_planner/Subsystem/PID Controller2/External Derivative/Error'
//  '<S148>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Filter/Disc. Forward Euler Filter'
//  '<S149>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Filter ICs/Internal IC - Filter'
//  '<S150>' : 'quad_to_mission_planner/Subsystem/PID Controller2/I Gain/Internal Parameters'
//  '<S151>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Ideal P Gain/Passthrough'
//  '<S152>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Ideal P Gain Fdbk/Disabled'
//  '<S153>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Integrator/Discrete'
//  '<S154>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Integrator ICs/Internal IC'
//  '<S155>' : 'quad_to_mission_planner/Subsystem/PID Controller2/N Copy/Disabled'
//  '<S156>' : 'quad_to_mission_planner/Subsystem/PID Controller2/N Gain/Internal Parameters'
//  '<S157>' : 'quad_to_mission_planner/Subsystem/PID Controller2/P Copy/Disabled'
//  '<S158>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Parallel P Gain/Internal Parameters'
//  '<S159>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Reset Signal/Disabled'
//  '<S160>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Saturation/Passthrough'
//  '<S161>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Saturation Fdbk/Disabled'
//  '<S162>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Sum/Sum_PID'
//  '<S163>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Sum Fdbk/Disabled'
//  '<S164>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Tracking Mode/Disabled'
//  '<S165>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Tracking Mode Sum/Passthrough'
//  '<S166>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Tsamp - Integral/TsSignalSpecification'
//  '<S167>' : 'quad_to_mission_planner/Subsystem/PID Controller2/Tsamp - Ngain/Passthrough'
//  '<S168>' : 'quad_to_mission_planner/Subsystem/PID Controller2/postSat Signal/Forward_Path'
//  '<S169>' : 'quad_to_mission_planner/Subsystem/PID Controller2/preInt Signal/Internal PreInt'
//  '<S170>' : 'quad_to_mission_planner/Subsystem/PID Controller2/preSat Signal/Forward_Path'
//  '<S171>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Anti-windup'
//  '<S172>' : 'quad_to_mission_planner/Subsystem/PID Controller3/D Gain'
//  '<S173>' : 'quad_to_mission_planner/Subsystem/PID Controller3/External Derivative'
//  '<S174>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Filter'
//  '<S175>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Filter ICs'
//  '<S176>' : 'quad_to_mission_planner/Subsystem/PID Controller3/I Gain'
//  '<S177>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Ideal P Gain'
//  '<S178>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Ideal P Gain Fdbk'
//  '<S179>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Integrator'
//  '<S180>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Integrator ICs'
//  '<S181>' : 'quad_to_mission_planner/Subsystem/PID Controller3/N Copy'
//  '<S182>' : 'quad_to_mission_planner/Subsystem/PID Controller3/N Gain'
//  '<S183>' : 'quad_to_mission_planner/Subsystem/PID Controller3/P Copy'
//  '<S184>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Parallel P Gain'
//  '<S185>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Reset Signal'
//  '<S186>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Saturation'
//  '<S187>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Saturation Fdbk'
//  '<S188>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Sum'
//  '<S189>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Sum Fdbk'
//  '<S190>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Tracking Mode'
//  '<S191>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Tracking Mode Sum'
//  '<S192>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Tsamp - Integral'
//  '<S193>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Tsamp - Ngain'
//  '<S194>' : 'quad_to_mission_planner/Subsystem/PID Controller3/postSat Signal'
//  '<S195>' : 'quad_to_mission_planner/Subsystem/PID Controller3/preInt Signal'
//  '<S196>' : 'quad_to_mission_planner/Subsystem/PID Controller3/preSat Signal'
//  '<S197>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Anti-windup/Passthrough'
//  '<S198>' : 'quad_to_mission_planner/Subsystem/PID Controller3/D Gain/Internal Parameters'
//  '<S199>' : 'quad_to_mission_planner/Subsystem/PID Controller3/External Derivative/Error'
//  '<S200>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Filter/Disc. Forward Euler Filter'
//  '<S201>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Filter ICs/Internal IC - Filter'
//  '<S202>' : 'quad_to_mission_planner/Subsystem/PID Controller3/I Gain/Internal Parameters'
//  '<S203>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Ideal P Gain/Passthrough'
//  '<S204>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Ideal P Gain Fdbk/Disabled'
//  '<S205>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Integrator/Discrete'
//  '<S206>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Integrator ICs/Internal IC'
//  '<S207>' : 'quad_to_mission_planner/Subsystem/PID Controller3/N Copy/Disabled'
//  '<S208>' : 'quad_to_mission_planner/Subsystem/PID Controller3/N Gain/Internal Parameters'
//  '<S209>' : 'quad_to_mission_planner/Subsystem/PID Controller3/P Copy/Disabled'
//  '<S210>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Parallel P Gain/Internal Parameters'
//  '<S211>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Reset Signal/Disabled'
//  '<S212>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Saturation/Passthrough'
//  '<S213>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Saturation Fdbk/Disabled'
//  '<S214>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Sum/Sum_PID'
//  '<S215>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Sum Fdbk/Disabled'
//  '<S216>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Tracking Mode/Disabled'
//  '<S217>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Tracking Mode Sum/Passthrough'
//  '<S218>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Tsamp - Integral/TsSignalSpecification'
//  '<S219>' : 'quad_to_mission_planner/Subsystem/PID Controller3/Tsamp - Ngain/Passthrough'
//  '<S220>' : 'quad_to_mission_planner/Subsystem/PID Controller3/postSat Signal/Forward_Path'
//  '<S221>' : 'quad_to_mission_planner/Subsystem/PID Controller3/preInt Signal/Internal PreInt'
//  '<S222>' : 'quad_to_mission_planner/Subsystem/PID Controller3/preSat Signal/Forward_Path'

#endif                                 // quad_to_mission_planner_h_

//
// File trailer for generated code.
//
// [EOF]
//
