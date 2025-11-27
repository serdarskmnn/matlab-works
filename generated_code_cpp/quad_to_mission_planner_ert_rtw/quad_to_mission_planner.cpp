//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// File: quad_to_mission_planner.cpp
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
#include "quad_to_mission_planner.h"
#include <cmath>
#include "quad_to_mission_planner_types.h"
#include "rtwtypes.h"
#include <stddef.h>

static void rate_scheduler(quad_to_mission_planner::
  RT_MODEL_quad_to_mission_plan_T *const quad_to_mission_planner_M);

//
//         This function updates active task flag for each subrate.
//         The function is called at model base rate, hence the
//         generated code self-manages all its subrates.
//
static void rate_scheduler(quad_to_mission_planner::
  RT_MODEL_quad_to_mission_plan_T *const quad_to_mission_planner_M)
{
  // Compute which subrates run during the next base time step.  Subrates
  //  are an integer multiple of the base rate counter.  Therefore, the subtask
  //  counter is reset when it reaches its limit (zero means run).

  (quad_to_mission_planner_M->Timing.TaskCounters.TID[2])++;
  if ((quad_to_mission_planner_M->Timing.TaskCounters.TID[2]) > 9) {// Sample time: [0.1s, 0.0s] 
    quad_to_mission_planner_M->Timing.TaskCounters.TID[2] = 0;
  }
}

// Model step function
void quad_to_mission_planner::step()
{
  // local block i/o variables
  real_T rtb_FilterCoefficient;
  real_T rtb_FilterCoefficient_j;
  real_T rtb_FilterCoefficient_k;
  real_T rtb_FilterCoefficient_h;
  real_T rtb_IntegralGain;
  real_T rtb_IntegralGain_l;
  real_T rtb_IntegralGain_h;
  real_T rtb_IntegralGain_g;

  {
    void *serializerObj;
    void *serializerObj_0;
    void *serializerObj_1;
    SL_Bus_MAVLink_ATTITUDE_Payload payloadStruct;
    SL_Bus_MAVLink_HEARTBEAT_Payload payloadStruct_1;
    SL_Bus_MAVLink_VFR_HUD_Payload payloadStruct_0;
    real_T rtb_M1;
    real_T rtb_M1_tmp;
    real_T rtb_Sum;
    real_T rtb_Sum_fh;
    real_T rtb_Sum_gy;
    real_T rtb_Sum_j;
    real_T rtb_Sum_p;
    uint16_T b_receivedLength;

    // MATLABSystem: '<S7>/MAVLinkEncoderBlock' incorporates:
    //   BusCreator: '<S4>/MAVLinkMsgBusCreator'
    //   Constant: '<S4>/ComponentIDConstant'
    //   Constant: '<S4>/MsgIDConstant'
    //   Constant: '<S4>/SystemIDConstant'
    //   DataTypeConversion: '<Root>/Data Type Conversion'
    //   DataTypeConversion: '<Root>/Data Type Conversion1'
    //   DataTypeConversion: '<Root>/Data Type Conversion2'
    //   MATLABSystem: '<S4>/MsgModifier'
    //   UnitDelay: '<Root>/Unit Delay'
    //   UnitDelay: '<Root>/Unit Delay2'
    //   UnitDelay: '<Root>/Unit Delay3'
    //
    MAVLinkCodegen_fetchSerializerObj
      (quad_to_mission_planner_DW.obj_e.mavlinkObj.MAVLinkObjPointer,
       &serializerObj, 1, 1);
    payloadStruct.time_boot_ms = 0U;
    payloadStruct.roll = static_cast<real32_T>
      (quad_to_mission_planner_DW.UnitDelay_DSTATE);
    payloadStruct.pitch = static_cast<real32_T>
      (quad_to_mission_planner_DW.UnitDelay2_DSTATE);
    payloadStruct.yaw = static_cast<real32_T>
      (quad_to_mission_planner_DW.UnitDelay3_DSTATE);
    payloadStruct.rollspeed = 0.0F;
    payloadStruct.pitchspeed = 0.0F;
    payloadStruct.yawspeed = 0.0F;
    MAVLinkCodegen_finalizeAndSerializeMsg(serializerObj, &payloadStruct, 1, 1,
      30U, 28.0, 28.0, 39.0,
      &quad_to_mission_planner_B.MAVLinkEncoderBlock_o1_h[0], &b_receivedLength);

    // Sum: '<S10>/Sum' incorporates:
    //   Constant: '<Root>/Cmd_Thrust'
    //   DataTypeConversion: '<Root>/Data Type Conversion3'
    //   UnitDelay: '<Root>/Unit Delay1'

    rtb_Sum_j = 6.6028708133971286 - static_cast<real32_T>
      (quad_to_mission_planner_DW.UnitDelay1_DSTATE);

    // Gain: '<S52>/Filter Coefficient' incorporates:
    //   DiscreteIntegrator: '<S44>/Filter'
    //   Gain: '<S42>/Derivative Gain'
    //   Sum: '<S44>/SumD'

    rtb_FilterCoefficient = (2.5 * rtb_Sum_j -
      quad_to_mission_planner_DW.Filter_DSTATE) * 100.0;

    // Sum: '<S58>/Sum' incorporates:
    //   DiscreteIntegrator: '<S49>/Integrator'
    //   Gain: '<S54>/Proportional Gain'

    rtb_Sum = (3.0 * rtb_Sum_j + quad_to_mission_planner_DW.Integrator_DSTATE) +
      rtb_FilterCoefficient;

    // Gain: '<S104>/Filter Coefficient' incorporates:
    //   DiscreteIntegrator: '<S96>/Filter'
    //   Gain: '<S94>/Derivative Gain'
    //   Sum: '<S96>/SumD'

    rtb_FilterCoefficient_j = (0.5 * quad_to_mission_planner_ConstB.Sum1 -
      quad_to_mission_planner_DW.Filter_DSTATE_a) * 100.0;

    // Sum: '<S110>/Sum' incorporates:
    //   DiscreteIntegrator: '<S101>/Integrator'
    //   Gain: '<S106>/Proportional Gain'

    rtb_Sum_p = (2.0 * quad_to_mission_planner_ConstB.Sum1 +
                 quad_to_mission_planner_DW.Integrator_DSTATE_h) +
      rtb_FilterCoefficient_j;

    // Gain: '<S156>/Filter Coefficient' incorporates:
    //   DiscreteIntegrator: '<S148>/Filter'
    //   Gain: '<S146>/Derivative Gain'
    //   Sum: '<S148>/SumD'

    rtb_FilterCoefficient_k = (0.5 * quad_to_mission_planner_ConstB.Sum2 -
      quad_to_mission_planner_DW.Filter_DSTATE_g) * 100.0;

    // Sum: '<S162>/Sum' incorporates:
    //   DiscreteIntegrator: '<S153>/Integrator'
    //   Gain: '<S158>/Proportional Gain'

    rtb_Sum_gy = (2.0 * quad_to_mission_planner_ConstB.Sum2 +
                  quad_to_mission_planner_DW.Integrator_DSTATE_c) +
      rtb_FilterCoefficient_k;

    // Gain: '<S208>/Filter Coefficient' incorporates:
    //   DiscreteIntegrator: '<S200>/Filter'
    //   Gain: '<S198>/Derivative Gain'
    //   Sum: '<S200>/SumD'

    rtb_FilterCoefficient_h = (0.0 * quad_to_mission_planner_ConstB.Sum3 -
      quad_to_mission_planner_DW.Filter_DSTATE_k) * 100.0;

    // Sum: '<S214>/Sum' incorporates:
    //   DiscreteIntegrator: '<S205>/Integrator'
    //   Gain: '<S210>/Proportional Gain'

    rtb_Sum_fh = (4.0 * quad_to_mission_planner_ConstB.Sum3 +
                  quad_to_mission_planner_DW.Integrator_DSTATE_f) +
      rtb_FilterCoefficient_h;

    // MATLAB Function: '<Root>/MotorMixer'
    rtb_M1_tmp = rtb_Sum - rtb_Sum_p;
    rtb_M1 = std::fmin(std::fmax((rtb_M1_tmp + rtb_Sum_gy) + rtb_Sum_fh, 0.0),
                       30.0);
    rtb_Sum_p += rtb_Sum;
    rtb_Sum = std::fmin(std::fmax((rtb_Sum_p - rtb_Sum_gy) + rtb_Sum_fh, 0.0),
                        30.0);
    rtb_Sum_p = std::fmin(std::fmax((rtb_Sum_p + rtb_Sum_gy) - rtb_Sum_fh, 0.0),
                          30.0);
    rtb_Sum_gy = std::fmin(std::fmax((rtb_M1_tmp - rtb_Sum_gy) - rtb_Sum_fh, 0.0),
      30.0);

    // MATLAB Function: '<Root>/Drone Dynamics'
    rtb_Sum_fh = rtb_M1 + rtb_Sum;
    quad_to_mission_planner_DW.v_Z += (((rtb_Sum_fh + rtb_Sum_p) + rtb_Sum_gy) /
      1.2 - 9.81) * 0.01;
    quad_to_mission_planner_DW.p_Z += quad_to_mission_planner_DW.v_Z * 0.01;
    if (quad_to_mission_planner_DW.p_Z < 0.0) {
      quad_to_mission_planner_DW.p_Z = 0.0;
      quad_to_mission_planner_DW.v_Z = 0.0;
    }

    quad_to_mission_planner_DW.v_Phi += (((rtb_Sum + rtb_Sum_p) - (rtb_M1 +
      rtb_Sum_gy)) - quad_to_mission_planner_DW.v_Phi * 0.5) / 0.01 * 0.01;
    quad_to_mission_planner_DW.p_Phi += quad_to_mission_planner_DW.v_Phi * 0.01;
    quad_to_mission_planner_DW.v_Theta += (((rtb_M1 + rtb_Sum_p) - (rtb_Sum +
      rtb_Sum_gy)) - quad_to_mission_planner_DW.v_Theta * 0.5) / 0.01 * 0.01;
    quad_to_mission_planner_DW.p_Theta += quad_to_mission_planner_DW.v_Theta *
      0.01;
    quad_to_mission_planner_DW.v_Psi += ((rtb_Sum_fh - (rtb_Sum_p + rtb_Sum_gy))
      - quad_to_mission_planner_DW.v_Psi * 0.5) / 0.02 * 0.01;
    quad_to_mission_planner_DW.p_Psi += quad_to_mission_planner_DW.v_Psi * 0.01;
    quad_to_mission_planner_B.Z = quad_to_mission_planner_DW.p_Z;
    quad_to_mission_planner_B.Phi = quad_to_mission_planner_DW.p_Phi;
    quad_to_mission_planner_B.Theta = quad_to_mission_planner_DW.p_Theta;
    quad_to_mission_planner_B.Psi = quad_to_mission_planner_DW.p_Psi;

    // End of MATLAB Function: '<Root>/Drone Dynamics'

    // MATLABSystem: '<S6>/MAVLinkEncoderBlock' incorporates:
    //   BusAssignment: '<Root>/Bus Assignment'
    //   BusCreator: '<S3>/MAVLinkMsgBusCreator'
    //   Constant: '<S3>/ComponentIDConstant'
    //   Constant: '<S3>/SystemIDConstant'
    //   DataTypeConversion: '<Root>/Data Type Conversion3'
    //   UnitDelay: '<Root>/Unit Delay1'

    MAVLinkCodegen_fetchSerializerObj
      (quad_to_mission_planner_DW.obj_f.mavlinkObj.MAVLinkObjPointer,
       &serializerObj_0, 1, 1);
    payloadStruct_0.airspeed = 0.0F;
    payloadStruct_0.groundspeed = 0.0F;
    payloadStruct_0.alt = static_cast<real32_T>
      (quad_to_mission_planner_DW.UnitDelay1_DSTATE);
    payloadStruct_0.climb = 0.0F;

    // DataTypeConversion: '<Root>/Data Type Conversion4'
    rtb_M1 = std::floor(quad_to_mission_planner_B.Psi);
    if (std::isnan(rtb_M1) || std::isinf(rtb_M1)) {
      rtb_M1 = 0.0;
    } else {
      rtb_M1 = std::fmod(rtb_M1, 65536.0);
    }

    if (rtb_M1 < 0.0) {
      // MATLABSystem: '<S6>/MAVLinkEncoderBlock'
      payloadStruct_0.heading = static_cast<int16_T>(-static_cast<int16_T>(
        static_cast<uint16_T>(-rtb_M1)));
    } else {
      // MATLABSystem: '<S6>/MAVLinkEncoderBlock'
      payloadStruct_0.heading = static_cast<int16_T>(static_cast<uint16_T>
        (rtb_M1));
    }

    // End of DataTypeConversion: '<Root>/Data Type Conversion4'

    // MATLABSystem: '<S6>/MAVLinkEncoderBlock' incorporates:
    //   BusAssignment: '<Root>/Bus Assignment'
    //   BusCreator: '<S3>/MAVLinkMsgBusCreator'
    //   Constant: '<S3>/ComponentIDConstant'
    //   Constant: '<S3>/MsgIDConstant'
    //   Constant: '<S3>/SystemIDConstant'

    payloadStruct_0.throttle = 0U;
    MAVLinkCodegen_finalizeAndSerializeMsg(serializerObj_0, &payloadStruct_0, 1,
      1, 74U, 20.0, 20.0, 20.0,
      &quad_to_mission_planner_B.MAVLinkEncoderBlock_o1_p[0], &b_receivedLength);

    // MATLABSystem: '<S8>/MAVLinkEncoderBlock' incorporates:
    //   BusAssignment: '<Root>/Bus Assignment2'
    //   BusCreator: '<S5>/MAVLinkMsgBusCreator'
    //   Constant: '<Root>/Constant1'
    //   Constant: '<Root>/Constant2'
    //   Constant: '<Root>/Constant3'
    //   Constant: '<Root>/Constant4'
    //   Constant: '<Root>/Constant5'
    //   Constant: '<S5>/ComponentIDConstant'
    //   Constant: '<S5>/MsgIDConstant'
    //   Constant: '<S5>/SystemIDConstant'
    //   MATLABSystem: '<S5>/MsgModifier'
    //
    MAVLinkCodegen_fetchSerializerObj
      (quad_to_mission_planner_DW.obj.mavlinkObj.MAVLinkObjPointer,
       &serializerObj_1, 1, 1);
    payloadStruct_1.custom_mode = 0U;
    payloadStruct_1.type = 2U;
    payloadStruct_1.autopilot = 3U;
    payloadStruct_1.base_mode = 81U;
    payloadStruct_1.system_status = 4U;
    payloadStruct_1.mavlink_version = 3U;
    MAVLinkCodegen_finalizeAndSerializeMsg(serializerObj_1, &payloadStruct_1, 1,
      1, 0U, 9.0, 9.0, 50.0, &quad_to_mission_planner_B.MAVLinkEncoderBlock_o1[0],
      &b_receivedLength);

    // Gain: '<S202>/Integral Gain'
    rtb_IntegralGain = 0.5 * quad_to_mission_planner_ConstB.Sum3;

    // Gain: '<S150>/Integral Gain'
    rtb_IntegralGain_l = 0.0 * quad_to_mission_planner_ConstB.Sum2;

    // Gain: '<S98>/Integral Gain'
    rtb_IntegralGain_h = 0.0 * quad_to_mission_planner_ConstB.Sum1;

    // Gain: '<S46>/Integral Gain'
    rtb_IntegralGain_g = 1.5 * rtb_Sum_j;
  }

  {
    char_T *sErr;

    // Update for UnitDelay: '<Root>/Unit Delay'
    quad_to_mission_planner_DW.UnitDelay_DSTATE = quad_to_mission_planner_B.Phi;

    // Update for UnitDelay: '<Root>/Unit Delay2'
    quad_to_mission_planner_DW.UnitDelay2_DSTATE =
      quad_to_mission_planner_B.Theta;

    // Update for UnitDelay: '<Root>/Unit Delay3'
    quad_to_mission_planner_DW.UnitDelay3_DSTATE = quad_to_mission_planner_B.Psi;

    // Update for UnitDelay: '<Root>/Unit Delay1'
    quad_to_mission_planner_DW.UnitDelay1_DSTATE = quad_to_mission_planner_B.Z;

    // Update for DiscreteIntegrator: '<S49>/Integrator'
    quad_to_mission_planner_DW.Integrator_DSTATE += 0.01 * rtb_IntegralGain_g;

    // Update for DiscreteIntegrator: '<S44>/Filter'
    quad_to_mission_planner_DW.Filter_DSTATE += 0.01 * rtb_FilterCoefficient;

    // Update for DiscreteIntegrator: '<S101>/Integrator'
    quad_to_mission_planner_DW.Integrator_DSTATE_h += 0.01 * rtb_IntegralGain_h;

    // Update for DiscreteIntegrator: '<S96>/Filter'
    quad_to_mission_planner_DW.Filter_DSTATE_a += 0.01 * rtb_FilterCoefficient_j;

    // Update for DiscreteIntegrator: '<S153>/Integrator'
    quad_to_mission_planner_DW.Integrator_DSTATE_c += 0.01 * rtb_IntegralGain_l;

    // Update for DiscreteIntegrator: '<S148>/Filter'
    quad_to_mission_planner_DW.Filter_DSTATE_g += 0.01 * rtb_FilterCoefficient_k;

    // Update for DiscreteIntegrator: '<S205>/Integrator'
    quad_to_mission_planner_DW.Integrator_DSTATE_f += 0.01 * rtb_IntegralGain;

    // Update for DiscreteIntegrator: '<S200>/Filter'
    quad_to_mission_planner_DW.Filter_DSTATE_k += 0.01 * rtb_FilterCoefficient_h;

    // Update for S-Function (sdspToNetwork): '<Root>/UDP Send' incorporates:
    //   MATLABSystem: '<S6>/MAVLinkEncoderBlock'

    sErr = GetErrorBuffer(&quad_to_mission_planner_DW.UDPSend_NetworkLib[0U]);
    LibUpdate_Network(&quad_to_mission_planner_DW.UDPSend_NetworkLib[0U],
                      &quad_to_mission_planner_B.MAVLinkEncoderBlock_o1_p[0U],
                      32);
    if (*sErr != 0) {
      (&quad_to_mission_planner_M)->setErrorStatus(sErr);
      (&quad_to_mission_planner_M)->setStopRequested(1);
    }

    // End of Update for S-Function (sdspToNetwork): '<Root>/UDP Send'

    // Update for S-Function (sdspToNetwork): '<Root>/UDP Send1' incorporates:
    //   MATLABSystem: '<S7>/MAVLinkEncoderBlock'

    sErr = GetErrorBuffer(&quad_to_mission_planner_DW.UDPSend1_NetworkLib[0U]);
    LibUpdate_Network(&quad_to_mission_planner_DW.UDPSend1_NetworkLib[0U],
                      &quad_to_mission_planner_B.MAVLinkEncoderBlock_o1_h[0U],
                      40);
    if (*sErr != 0) {
      (&quad_to_mission_planner_M)->setErrorStatus(sErr);
      (&quad_to_mission_planner_M)->setStopRequested(1);
    }

    // End of Update for S-Function (sdspToNetwork): '<Root>/UDP Send1'

    // Update for S-Function (sdspToNetwork): '<Root>/UDP Send2' incorporates:
    //   MATLABSystem: '<S8>/MAVLinkEncoderBlock'

    sErr = GetErrorBuffer(&quad_to_mission_planner_DW.UDPSend2_NetworkLib[0U]);
    LibUpdate_Network(&quad_to_mission_planner_DW.UDPSend2_NetworkLib[0U],
                      &quad_to_mission_planner_B.MAVLinkEncoderBlock_o1[0U], 21);
    if (*sErr != 0) {
      (&quad_to_mission_planner_M)->setErrorStatus(sErr);
      (&quad_to_mission_planner_M)->setStopRequested(1);
    }

    // End of Update for S-Function (sdspToNetwork): '<Root>/UDP Send2'
  }

  // Update absolute time for base rate
  // The "clockTick0" counts the number of times the code of this task has
  //  been executed. The absolute time is the multiplication of "clockTick0"
  //  and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
  //  overflow during the application lifespan selected.

  (&quad_to_mission_planner_M)->Timing.t[0] =
    ((time_T)(++(&quad_to_mission_planner_M)->Timing.clockTick0)) *
    (&quad_to_mission_planner_M)->Timing.stepSize0;

  {
    // Update absolute timer for sample time: [0.01s, 0.0s]
    // The "clockTick1" counts the number of times the code of this task has
    //  been executed. The resolution of this integer timer is 0.01, which is the step size
    //  of the task. Size of "clockTick1" ensures timer will not overflow during the
    //  application lifespan selected.

    (&quad_to_mission_planner_M)->Timing.clockTick1++;
  }

  rate_scheduler((&quad_to_mission_planner_M));
}

// Model initialize function
void quad_to_mission_planner::initialize()
{
  // Registration code
  {
    // Setup solver object
    rtsiSetSimTimeStepPtr(&(&quad_to_mission_planner_M)->solverInfo,
                          &(&quad_to_mission_planner_M)->Timing.simTimeStep);
    rtsiSetTPtr(&(&quad_to_mission_planner_M)->solverInfo,
                (&quad_to_mission_planner_M)->getTPtrPtr());
    rtsiSetStepSizePtr(&(&quad_to_mission_planner_M)->solverInfo,
                       &(&quad_to_mission_planner_M)->Timing.stepSize0);
    rtsiSetErrorStatusPtr(&(&quad_to_mission_planner_M)->solverInfo,
                          (&quad_to_mission_planner_M)->getErrorStatusPtr());
    rtsiSetRTModelPtr(&(&quad_to_mission_planner_M)->solverInfo,
                      (&quad_to_mission_planner_M));
  }

  rtsiSetSimTimeStep(&(&quad_to_mission_planner_M)->solverInfo, MAJOR_TIME_STEP);
  rtsiSetIsMinorTimeStepWithModeChange(&(&quad_to_mission_planner_M)->solverInfo,
    false);
  rtsiSetIsContModeFrozen(&(&quad_to_mission_planner_M)->solverInfo, false);
  rtsiSetSolverName(&(&quad_to_mission_planner_M)->solverInfo,
                    "FixedStepDiscrete");
  (&quad_to_mission_planner_M)->setTPtr(&(&quad_to_mission_planner_M)
    ->Timing.tArray[0]);
  (&quad_to_mission_planner_M)->Timing.stepSize0 = 0.01;

  {
    void *ptrObj;
    char_T *sErr;

    // Start for S-Function (sdspToNetwork): '<Root>/UDP Send'
    sErr = GetErrorBuffer(&quad_to_mission_planner_DW.UDPSend_NetworkLib[0U]);
    CreateUDPInterface(&quad_to_mission_planner_DW.UDPSend_NetworkLib[0U]);
    if (*sErr == 0) {
      LibCreate_Network(&quad_to_mission_planner_DW.UDPSend_NetworkLib[0U], 1,
                        "0.0.0.0", -1, "127.0.0.1", 14550, 8192, 1, 0);
    }

    if (*sErr == 0) {
      LibStart(&quad_to_mission_planner_DW.UDPSend_NetworkLib[0U]);
    }

    if (*sErr != 0) {
      DestroyUDPInterface(&quad_to_mission_planner_DW.UDPSend_NetworkLib[0U]);
      if (*sErr != 0) {
        (&quad_to_mission_planner_M)->setErrorStatus(sErr);
        (&quad_to_mission_planner_M)->setStopRequested(1);
      }
    }

    // End of Start for S-Function (sdspToNetwork): '<Root>/UDP Send'

    // Start for S-Function (sdspToNetwork): '<Root>/UDP Send1'
    sErr = GetErrorBuffer(&quad_to_mission_planner_DW.UDPSend1_NetworkLib[0U]);
    CreateUDPInterface(&quad_to_mission_planner_DW.UDPSend1_NetworkLib[0U]);
    if (*sErr == 0) {
      LibCreate_Network(&quad_to_mission_planner_DW.UDPSend1_NetworkLib[0U], 1,
                        "0.0.0.0", -1, "127.0.0.1", 14550, 8192, 1, 0);
    }

    if (*sErr == 0) {
      LibStart(&quad_to_mission_planner_DW.UDPSend1_NetworkLib[0U]);
    }

    if (*sErr != 0) {
      DestroyUDPInterface(&quad_to_mission_planner_DW.UDPSend1_NetworkLib[0U]);
      if (*sErr != 0) {
        (&quad_to_mission_planner_M)->setErrorStatus(sErr);
        (&quad_to_mission_planner_M)->setStopRequested(1);
      }
    }

    // End of Start for S-Function (sdspToNetwork): '<Root>/UDP Send1'

    // Start for S-Function (sdspToNetwork): '<Root>/UDP Send2'
    sErr = GetErrorBuffer(&quad_to_mission_planner_DW.UDPSend2_NetworkLib[0U]);
    CreateUDPInterface(&quad_to_mission_planner_DW.UDPSend2_NetworkLib[0U]);
    if (*sErr == 0) {
      LibCreate_Network(&quad_to_mission_planner_DW.UDPSend2_NetworkLib[0U], 1,
                        "0.0.0.0", -1, "127.0.0.1", 14550, 8192, 1, 0);
    }

    if (*sErr == 0) {
      LibStart(&quad_to_mission_planner_DW.UDPSend2_NetworkLib[0U]);
    }

    if (*sErr != 0) {
      DestroyUDPInterface(&quad_to_mission_planner_DW.UDPSend2_NetworkLib[0U]);
      if (*sErr != 0) {
        (&quad_to_mission_planner_M)->setErrorStatus(sErr);
        (&quad_to_mission_planner_M)->setStopRequested(1);
      }
    }

    // End of Start for S-Function (sdspToNetwork): '<Root>/UDP Send2'

    // Start for MATLABSystem: '<S7>/MAVLinkEncoderBlock'
    quad_to_mission_planner_DW.obj_e.matlabCodegenIsDeleted = false;
    quad_to_mission_planner_DW.obj_e.isSetupComplete = false;
    quad_to_mission_planner_DW.obj_e.isInitialized = 1;
    ptrObj = nullptr;
    MAVLinkCodegen_constructMAVLinkCodegenPointer(&ptrObj);
    quad_to_mission_planner_DW.obj_e.mavlinkObj.MAVLinkObjPointer = ptrObj;
    MAVLinkCodegen_setVersion
      (quad_to_mission_planner_DW.obj_e.mavlinkObj.MAVLinkObjPointer, 2.0);
    quad_to_mission_planner_DW.obj_e.isSetupComplete = true;

    // Start for MATLABSystem: '<S6>/MAVLinkEncoderBlock'
    quad_to_mission_planner_DW.obj_f.matlabCodegenIsDeleted = false;
    quad_to_mission_planner_DW.obj_f.isSetupComplete = false;
    quad_to_mission_planner_DW.obj_f.isInitialized = 1;
    ptrObj = nullptr;
    MAVLinkCodegen_constructMAVLinkCodegenPointer(&ptrObj);
    quad_to_mission_planner_DW.obj_f.mavlinkObj.MAVLinkObjPointer = ptrObj;
    MAVLinkCodegen_setVersion
      (quad_to_mission_planner_DW.obj_f.mavlinkObj.MAVLinkObjPointer, 2.0);
    quad_to_mission_planner_DW.obj_f.isSetupComplete = true;

    // Start for MATLABSystem: '<S8>/MAVLinkEncoderBlock'
    quad_to_mission_planner_DW.obj.matlabCodegenIsDeleted = false;
    quad_to_mission_planner_DW.obj.isSetupComplete = false;
    quad_to_mission_planner_DW.obj.isInitialized = 1;
    ptrObj = nullptr;
    MAVLinkCodegen_constructMAVLinkCodegenPointer(&ptrObj);
    quad_to_mission_planner_DW.obj.mavlinkObj.MAVLinkObjPointer = ptrObj;
    MAVLinkCodegen_setVersion
      (quad_to_mission_planner_DW.obj.mavlinkObj.MAVLinkObjPointer, 2.0);
    quad_to_mission_planner_DW.obj.isSetupComplete = true;
  }
}

// Model terminate function
void quad_to_mission_planner::terminate()
{
  char_T *sErr;

  // Terminate for MATLABSystem: '<S7>/MAVLinkEncoderBlock'
  if (!quad_to_mission_planner_DW.obj_e.matlabCodegenIsDeleted) {
    quad_to_mission_planner_DW.obj_e.matlabCodegenIsDeleted = true;
  }

  // End of Terminate for MATLABSystem: '<S7>/MAVLinkEncoderBlock'

  // Terminate for MATLABSystem: '<S6>/MAVLinkEncoderBlock'
  if (!quad_to_mission_planner_DW.obj_f.matlabCodegenIsDeleted) {
    quad_to_mission_planner_DW.obj_f.matlabCodegenIsDeleted = true;
  }

  // End of Terminate for MATLABSystem: '<S6>/MAVLinkEncoderBlock'

  // Terminate for S-Function (sdspToNetwork): '<Root>/UDP Send'
  sErr = GetErrorBuffer(&quad_to_mission_planner_DW.UDPSend_NetworkLib[0U]);
  LibTerminate(&quad_to_mission_planner_DW.UDPSend_NetworkLib[0U]);
  if (*sErr != 0) {
    (&quad_to_mission_planner_M)->setErrorStatus(sErr);
    (&quad_to_mission_planner_M)->setStopRequested(1);
  }

  LibDestroy(&quad_to_mission_planner_DW.UDPSend_NetworkLib[0U], 1);
  DestroyUDPInterface(&quad_to_mission_planner_DW.UDPSend_NetworkLib[0U]);

  // End of Terminate for S-Function (sdspToNetwork): '<Root>/UDP Send'

  // Terminate for S-Function (sdspToNetwork): '<Root>/UDP Send1'
  sErr = GetErrorBuffer(&quad_to_mission_planner_DW.UDPSend1_NetworkLib[0U]);
  LibTerminate(&quad_to_mission_planner_DW.UDPSend1_NetworkLib[0U]);
  if (*sErr != 0) {
    (&quad_to_mission_planner_M)->setErrorStatus(sErr);
    (&quad_to_mission_planner_M)->setStopRequested(1);
  }

  LibDestroy(&quad_to_mission_planner_DW.UDPSend1_NetworkLib[0U], 1);
  DestroyUDPInterface(&quad_to_mission_planner_DW.UDPSend1_NetworkLib[0U]);

  // End of Terminate for S-Function (sdspToNetwork): '<Root>/UDP Send1'

  // Terminate for MATLABSystem: '<S8>/MAVLinkEncoderBlock'
  if (!quad_to_mission_planner_DW.obj.matlabCodegenIsDeleted) {
    quad_to_mission_planner_DW.obj.matlabCodegenIsDeleted = true;
  }

  // End of Terminate for MATLABSystem: '<S8>/MAVLinkEncoderBlock'

  // Terminate for S-Function (sdspToNetwork): '<Root>/UDP Send2'
  sErr = GetErrorBuffer(&quad_to_mission_planner_DW.UDPSend2_NetworkLib[0U]);
  LibTerminate(&quad_to_mission_planner_DW.UDPSend2_NetworkLib[0U]);
  if (*sErr != 0) {
    (&quad_to_mission_planner_M)->setErrorStatus(sErr);
    (&quad_to_mission_planner_M)->setStopRequested(1);
  }

  LibDestroy(&quad_to_mission_planner_DW.UDPSend2_NetworkLib[0U], 1);
  DestroyUDPInterface(&quad_to_mission_planner_DW.UDPSend2_NetworkLib[0U]);

  // End of Terminate for S-Function (sdspToNetwork): '<Root>/UDP Send2'
}

time_T** quad_to_mission_planner::RT_MODEL_quad_to_mission_plan_T::getTPtrPtr()
{
  return &(Timing.t);
}

time_T* quad_to_mission_planner::RT_MODEL_quad_to_mission_plan_T::getTPtr()
  const
{
  return (Timing.t);
}

void quad_to_mission_planner::RT_MODEL_quad_to_mission_plan_T::setTPtr(time_T
  * aTPtr)
{
  (Timing.t = aTPtr);
}

boolean_T* quad_to_mission_planner::RT_MODEL_quad_to_mission_plan_T::
  getStopRequestedPtr()
{
  return (&(Timing.stopRequestedFlag));
}

boolean_T quad_to_mission_planner::RT_MODEL_quad_to_mission_plan_T::
  isMinorTimeStep() const
{
  return ((Timing.simTimeStep) == MINOR_TIME_STEP);
}

boolean_T quad_to_mission_planner::RT_MODEL_quad_to_mission_plan_T::
  isMajorTimeStep() const
{
  return ((Timing.simTimeStep) == MAJOR_TIME_STEP);
}

const char_T** quad_to_mission_planner::RT_MODEL_quad_to_mission_plan_T::
  getErrorStatusPtr()
{
  return &errorStatus;
}

boolean_T quad_to_mission_planner::RT_MODEL_quad_to_mission_plan_T::
  getStopRequested() const
{
  return (Timing.stopRequestedFlag);
}

void quad_to_mission_planner::RT_MODEL_quad_to_mission_plan_T::setStopRequested
  (boolean_T aStopRequested)
{
  (Timing.stopRequestedFlag = aStopRequested);
}

const char_T* quad_to_mission_planner::RT_MODEL_quad_to_mission_plan_T::
  getErrorStatus() const
{
  return (errorStatus);
}

void quad_to_mission_planner::RT_MODEL_quad_to_mission_plan_T::setErrorStatus(
  const char_T* const aErrorStatus)
{
  (errorStatus = aErrorStatus);
}

// Constructor
quad_to_mission_planner::quad_to_mission_planner() :
  quad_to_mission_planner_B(),
  quad_to_mission_planner_DW(),
  quad_to_mission_planner_M()
{
  // Currently there is no constructor body generated.
}

// Destructor
// Currently there is no destructor body generated.
quad_to_mission_planner::~quad_to_mission_planner() = default;

// Real-Time Model get method
quad_to_mission_planner::RT_MODEL_quad_to_mission_plan_T
  * quad_to_mission_planner::getRTM()
{
  return (&quad_to_mission_planner_M);
}

//
// File trailer for generated code.
//
// [EOF]
//
