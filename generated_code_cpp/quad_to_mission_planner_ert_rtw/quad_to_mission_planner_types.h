//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// File: quad_to_mission_planner_types.h
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
#ifndef quad_to_mission_planner_types_h_
#define quad_to_mission_planner_types_h_
#include "rtwtypes.h"
#ifndef DEFINED_TYPEDEF_FOR_SL_Bus_MAVLink_VFR_HUD_Payload_
#define DEFINED_TYPEDEF_FOR_SL_Bus_MAVLink_VFR_HUD_Payload_

struct SL_Bus_MAVLink_VFR_HUD_Payload
{
  real32_T airspeed;
  real32_T groundspeed;
  real32_T alt;
  real32_T climb;
  int16_T heading;
  uint16_T throttle;
};

#endif

#ifndef DEFINED_TYPEDEF_FOR_SL_Bus_MAVLink_ATTITUDE_Payload_
#define DEFINED_TYPEDEF_FOR_SL_Bus_MAVLink_ATTITUDE_Payload_

struct SL_Bus_MAVLink_ATTITUDE_Payload
{
  uint32_T time_boot_ms;
  real32_T roll;
  real32_T pitch;
  real32_T yaw;
  real32_T rollspeed;
  real32_T pitchspeed;
  real32_T yawspeed;
};

#endif

#ifndef DEFINED_TYPEDEF_FOR_SL_Bus_MAVLink_HEARTBEAT_Payload_
#define DEFINED_TYPEDEF_FOR_SL_Bus_MAVLink_HEARTBEAT_Payload_

struct SL_Bus_MAVLink_HEARTBEAT_Payload
{
  uint32_T custom_mode;
  uint8_T type;
  uint8_T autopilot;
  uint8_T base_mode;
  uint8_T system_status;
  uint8_T mavlink_version;
};

#endif

#ifndef struct_uav_sluav_internal_system_MAV_T
#define struct_uav_sluav_internal_system_MAV_T

struct uav_sluav_internal_system_MAV_T
{
  int32_T isInitialized;
};

#endif                                // struct_uav_sluav_internal_system_MAV_T

#ifndef struct_e_uav_sluav_internal_mavlink__T
#define struct_e_uav_sluav_internal_mavlink__T

struct e_uav_sluav_internal_mavlink__T
{
  void *MAVLinkObjPointer;
};

#endif                                // struct_e_uav_sluav_internal_mavlink__T

#ifndef struct_uav_sluav_internal_system_M_a_T
#define struct_uav_sluav_internal_system_M_a_T

struct uav_sluav_internal_system_M_a_T
{
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  e_uav_sluav_internal_mavlink__T mavlinkObj;
};

#endif                                // struct_uav_sluav_internal_system_M_a_T

#ifndef struct_e_robotics_slcore_internal_bl_T
#define struct_e_robotics_slcore_internal_bl_T

struct e_robotics_slcore_internal_bl_T
{
  int32_T __dummy;
};

#endif                                // struct_e_robotics_slcore_internal_bl_T

#ifndef struct_uav_sluav_internal_system_UAV_T
#define struct_uav_sluav_internal_system_UAV_T

struct uav_sluav_internal_system_UAV_T
{
  int32_T isInitialized;
  e_robotics_slcore_internal_bl_T SampleTimeHandler;
};

#endif                                // struct_uav_sluav_internal_system_UAV_T
#endif                                 // quad_to_mission_planner_types_h_

//
// File trailer for generated code.
//
// [EOF]
//
