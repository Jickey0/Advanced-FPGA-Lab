set SynModuleInfo {
  {SRCNAME matrix_mult_Pipeline_row MODELNAME matrix_mult_Pipeline_row RTLNAME matrix_mult_matrix_mult_Pipeline_row
    SUBMODULES {
      {MODELNAME matrix_mult_mul_32s_32s_32_1_1 RTLNAME matrix_mult_mul_32s_32s_32_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME matrix_mult_flow_control_loop_pipe_sequential_init RTLNAME matrix_mult_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME matrix_mult_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME matrix_mult MODELNAME matrix_mult RTLNAME matrix_mult IS_TOP 1}
}
