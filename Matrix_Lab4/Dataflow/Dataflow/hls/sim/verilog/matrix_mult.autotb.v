// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
`timescale 1ns/1ps


`define AUTOTB_DUT      matrix_mult
`define AUTOTB_DUT_INST AESL_inst_matrix_mult
`define AUTOTB_TOP      apatb_matrix_mult_top
`define AUTOTB_LAT_RESULT_FILE "matrix_mult.result.lat.rb"
`define AUTOTB_PER_RESULT_TRANS_FILE "matrix_mult.performance.result.transaction.xml"
`define AUTOTB_TOP_INST AESL_inst_apatb_matrix_mult_top
`define AUTOTB_MAX_ALLOW_LATENCY  15000000
`define AUTOTB_CLOCK_PERIOD_DIV2 5.00

`define AESL_MEM_A AESL_automem_A
`define AESL_MEM_INST_A mem_inst_A
`define AESL_MEM_B AESL_automem_B
`define AESL_MEM_INST_B mem_inst_B
`define AESL_MEM_AB AESL_automem_AB
`define AESL_MEM_INST_AB mem_inst_AB
`define AUTOTB_TVIN_A  "../tv/cdatafile/c.matrix_mult.autotvin_A.dat"
`define AUTOTB_TVIN_B  "../tv/cdatafile/c.matrix_mult.autotvin_B.dat"
`define AUTOTB_TVIN_AB  "../tv/cdatafile/c.matrix_mult.autotvin_AB.dat"
`define AUTOTB_TVIN_A_out_wrapc  "../tv/rtldatafile/rtl.matrix_mult.autotvin_A.dat"
`define AUTOTB_TVIN_B_out_wrapc  "../tv/rtldatafile/rtl.matrix_mult.autotvin_B.dat"
`define AUTOTB_TVIN_AB_out_wrapc  "../tv/rtldatafile/rtl.matrix_mult.autotvin_AB.dat"
`define AUTOTB_TVOUT_AB  "../tv/cdatafile/c.matrix_mult.autotvout_AB.dat"
`define AUTOTB_TVOUT_AB_out_wrapc  "../tv/rtldatafile/rtl.matrix_mult.autotvout_AB.dat"
module `AUTOTB_TOP;

parameter AUTOTB_TRANSACTION_NUM = 100;
parameter PROGRESS_TIMEOUT = 10000000;
parameter LATENCY_ESTIMATION = 8;
parameter LENGTH_A = 4;
parameter LENGTH_AB = 4;
parameter LENGTH_B = 4;

reg AESL_clock;
reg rst;
reg dut_rst;
reg start;
reg ce;
reg tb_continue;
wire AESL_start;
wire AESL_reset;
wire AESL_ce;
wire AESL_ready;
wire AESL_idle;
wire AESL_continue;
wire AESL_done;
reg AESL_done_delay = 0;
reg AESL_done_delay2 = 0;
reg AESL_ready_delay = 0;
wire ready;
wire ready_wire;
wire [1 : 0] A_address0;
wire  A_ce0;
wire [31 : 0] A_d0;
wire [31 : 0] A_q0;
wire  A_we0;
wire [1 : 0] A_address1;
wire  A_ce1;
wire [31 : 0] A_d1;
wire [31 : 0] A_q1;
wire  A_we1;
wire [1 : 0] B_address0;
wire  B_ce0;
wire [31 : 0] B_d0;
wire [31 : 0] B_q0;
wire  B_we0;
wire [1 : 0] B_address1;
wire  B_ce1;
wire [31 : 0] B_d1;
wire [31 : 0] B_q1;
wire  B_we1;
wire [1 : 0] AB_address0;
wire  AB_ce0;
wire [31 : 0] AB_d0;
wire [31 : 0] AB_q0;
wire  AB_we0;
wire [1 : 0] AB_address1;
wire  AB_ce1;
wire [31 : 0] AB_d1;
wire [31 : 0] AB_q1;
wire  AB_we1;
wire ap_start;
wire ap_done;
wire ap_ready;
wire ap_idle;
integer done_cnt = 0;
integer AESL_ready_cnt = 0;
integer ready_cnt = 0;
reg ready_initial;
reg ready_initial_n;
reg ready_last_n;
reg ready_delay_last_n;
reg done_delay_last_n;
reg interface_done = 0;


wire all_finish;
wire ap_clk;
wire ap_rst;
wire ap_rst_n;

`AUTOTB_DUT `AUTOTB_DUT_INST(
    .A_address0(A_address0),
    .A_ce0(A_ce0),
    .A_d0(A_d0),
    .A_q0(A_q0),
    .A_we0(A_we0),
    .A_address1(A_address1),
    .A_ce1(A_ce1),
    .A_d1(A_d1),
    .A_q1(A_q1),
    .A_we1(A_we1),
    .B_address0(B_address0),
    .B_ce0(B_ce0),
    .B_d0(B_d0),
    .B_q0(B_q0),
    .B_we0(B_we0),
    .B_address1(B_address1),
    .B_ce1(B_ce1),
    .B_d1(B_d1),
    .B_q1(B_q1),
    .B_we1(B_we1),
    .AB_address0(AB_address0),
    .AB_ce0(AB_ce0),
    .AB_d0(AB_d0),
    .AB_q0(AB_q0),
    .AB_we0(AB_we0),
    .AB_address1(AB_address1),
    .AB_ce1(AB_ce1),
    .AB_d1(AB_d1),
    .AB_q1(AB_q1),
    .AB_we1(AB_we1),
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_done(ap_done),
    .ap_ready(ap_ready),
    .ap_idle(ap_idle));
assign ap_clk = AESL_clock;
assign ap_rst = AESL_reset;
assign ap_rst_n = ~AESL_reset;
assign AESL_reset = dut_rst;
assign AESL_start = svtb_top.misc_if.tb2dut_ap_start;
assign AESL_ready = svtb_top.misc_if.dut2tb_ap_ready;
assign AESL_done  = svtb_top.misc_if.dut2tb_ap_done;
assign all_finish = svtb_top.misc_if.finished;
initial begin : initial_process
    integer proc_rand;
    rst = 1;
    # 100;
    repeat(0+3) @ (posedge AESL_clock);
    # 0.1;
    rst = 0;
end
initial begin : initial_process_for_dut_rst
    integer proc_rand;
    dut_rst = 1;
    # 100;
    repeat(3) @ (posedge AESL_clock);
    # 0.1;
    dut_rst = 0;
end
initial begin
    AESL_clock = 0;
    forever #`AUTOTB_CLOCK_PERIOD_DIV2 AESL_clock = ~AESL_clock;
end

    sv_module_top svtb_top();
//------------------------arrayA Instantiation--------------

// The input and output of arrayA
wire    arrayA_ce0, arrayA_ce1;
wire [4 - 1 : 0]    arrayA_we0, arrayA_we1;
wire    [1 : 0]    arrayA_address0, arrayA_address1;
wire    [31 : 0]    arrayA_din0, arrayA_din1;
wire    [31 : 0]    arrayA_dout0, arrayA_dout1;
wire    arrayA_ready;
wire    arrayA_done;

`AESL_MEM_A `AESL_MEM_INST_A(
    .clk        (AESL_clock),
    .rst        (AESL_reset),
    .ce0        (arrayA_ce0),
    .we0        (arrayA_we0),
    .address0   (arrayA_address0),
    .din0       (arrayA_din0),
    .dout0      (arrayA_dout0),
    .ce1        (arrayA_ce1),
    .we1        (arrayA_we1),
    .address1   (arrayA_address1),
    .din1       (arrayA_din1),
    .dout1      (arrayA_dout1),
    .ready      (arrayA_ready),
    .done    (arrayA_done)
);

// Assignment between dut and arrayA
assign arrayA_address0 = A_address0;
assign arrayA_ce0 = A_ce0;
assign A_q0 = arrayA_dout0;
assign arrayA_we0 = 0;
assign arrayA_din0 = 0;
assign arrayA_address1 = A_address1;
assign arrayA_ce1 = A_ce1;
assign A_q1 = arrayA_dout1;
assign arrayA_we1 = 0;
assign arrayA_din1 = 0;
assign arrayA_ready=    ready;
assign arrayA_done = 0;

event A_reshape_ap_done_evt;
event A_reshape_ap_ready_evt;
initial begin
     `AESL_MEM_INST_A.initialed       = svtb_top.misc_if.initialed_evt  ;
     `AESL_MEM_INST_A.finished        = svtb_top.misc_if.finished_evt   ;
     `AESL_MEM_INST_A.dut2tb_ap_ready = svtb_top.misc_if.dut2tb_ap_ready_evt;
     `AESL_MEM_INST_A.dut2tb_ap_done = svtb_top.misc_if.dut2tb_ap_ready_evt;
end
//------------------------arrayB Instantiation--------------

// The input and output of arrayB
wire    arrayB_ce0, arrayB_ce1;
wire [4 - 1 : 0]    arrayB_we0, arrayB_we1;
wire    [1 : 0]    arrayB_address0, arrayB_address1;
wire    [31 : 0]    arrayB_din0, arrayB_din1;
wire    [31 : 0]    arrayB_dout0, arrayB_dout1;
wire    arrayB_ready;
wire    arrayB_done;

`AESL_MEM_B `AESL_MEM_INST_B(
    .clk        (AESL_clock),
    .rst        (AESL_reset),
    .ce0        (arrayB_ce0),
    .we0        (arrayB_we0),
    .address0   (arrayB_address0),
    .din0       (arrayB_din0),
    .dout0      (arrayB_dout0),
    .ce1        (arrayB_ce1),
    .we1        (arrayB_we1),
    .address1   (arrayB_address1),
    .din1       (arrayB_din1),
    .dout1      (arrayB_dout1),
    .ready      (arrayB_ready),
    .done    (arrayB_done)
);

// Assignment between dut and arrayB
assign arrayB_address0 = B_address0;
assign arrayB_ce0 = B_ce0;
assign B_q0 = arrayB_dout0;
assign arrayB_we0 = 0;
assign arrayB_din0 = 0;
assign arrayB_address1 = B_address1;
assign arrayB_ce1 = B_ce1;
assign B_q1 = arrayB_dout1;
assign arrayB_we1 = 0;
assign arrayB_din1 = 0;
assign arrayB_ready=    ready;
assign arrayB_done = 0;

event B_reshape_ap_done_evt;
event B_reshape_ap_ready_evt;
initial begin
     `AESL_MEM_INST_B.initialed       = svtb_top.misc_if.initialed_evt  ;
     `AESL_MEM_INST_B.finished        = svtb_top.misc_if.finished_evt   ;
     `AESL_MEM_INST_B.dut2tb_ap_ready = svtb_top.misc_if.dut2tb_ap_ready_evt;
     `AESL_MEM_INST_B.dut2tb_ap_done = svtb_top.misc_if.dut2tb_ap_ready_evt;
end
//------------------------arrayAB Instantiation--------------

// The input and output of arrayAB
wire    arrayAB_ce0, arrayAB_ce1;
wire [4 - 1 : 0]    arrayAB_we0, arrayAB_we1;
wire    [1 : 0]    arrayAB_address0, arrayAB_address1;
wire    [31 : 0]    arrayAB_din0, arrayAB_din1;
wire    [31 : 0]    arrayAB_dout0, arrayAB_dout1;
wire    arrayAB_ready;
wire    arrayAB_done;

`AESL_MEM_AB `AESL_MEM_INST_AB(
    .clk        (AESL_clock),
    .rst        (AESL_reset),
    .ce0        (arrayAB_ce0),
    .we0        (arrayAB_we0),
    .address0   (arrayAB_address0),
    .din0       (arrayAB_din0),
    .dout0      (arrayAB_dout0),
    .ce1        (arrayAB_ce1),
    .we1        (arrayAB_we1),
    .address1   (arrayAB_address1),
    .din1       (arrayAB_din1),
    .dout1      (arrayAB_dout1),
    .ready      (arrayAB_ready),
    .done    (arrayAB_done)
);

// Assignment between dut and arrayAB
assign arrayAB_address0 = AB_address0;
assign arrayAB_ce0 = AB_ce0;
assign arrayAB_we0[0] = AB_we0;
assign arrayAB_we0[1] = AB_we0;
assign arrayAB_we0[2] = AB_we0;
assign arrayAB_we0[3] = AB_we0;
assign arrayAB_din0 = AB_d0;
assign arrayAB_we1 = 0;
assign arrayAB_din1 = 0;
assign arrayAB_ready= ready_initial | arrayAB_done;
assign arrayAB_done =    AESL_done_delay;

event AB_reshape_ap_done_evt;
event AB_reshape_ap_ready_evt;
initial begin
     `AESL_MEM_INST_AB.initialed       = svtb_top.misc_if.initialed_evt  ;
     `AESL_MEM_INST_AB.finished        = svtb_top.misc_if.finished_evt   ;
     `AESL_MEM_INST_AB.dut2tb_ap_done  = svtb_top.misc_if.dut2tb_ap_done_evt;
     `AESL_MEM_INST_AB.dut2tb_ap_ready = AB_reshape_ap_ready_evt;
end
initial begin
    forever begin
        @svtb_top.misc_if.dut2tb_ap_done_evt;
        #0;
        -> AB_reshape_ap_ready_evt;
    end
end

////////////////////////////////////////////
// progress and performance
////////////////////////////////////////////

task wait_start();
    while (~AESL_start) begin
        @ (posedge AESL_clock);
    end
endtask

reg [31:0] clk_cnt = 0;
reg AESL_ready_p1;
reg AESL_start_p1;

always @ (posedge AESL_clock) begin
    if (AESL_reset == 1) begin
        clk_cnt <= 32'h0;
        AESL_ready_p1 <= 1'b0;
        AESL_start_p1 <= 1'b0;
    end
    else begin
        clk_cnt <= clk_cnt + 1;
        AESL_ready_p1 <= AESL_ready;
        AESL_start_p1 <= AESL_start;
    end
end

reg [31:0] start_timestamp [0:AUTOTB_TRANSACTION_NUM - 1];
reg [31:0] start_cnt;
reg [31:0] ready_timestamp [0:AUTOTB_TRANSACTION_NUM - 1];
reg [31:0] ap_ready_cnt;
reg [31:0] finish_timestamp [0:AUTOTB_TRANSACTION_NUM - 1];
reg [31:0] finish_cnt;
reg [31:0] lat_total;
event report_progress;

always @(posedge AESL_clock)
begin
    if (finish_cnt == AUTOTB_TRANSACTION_NUM - 1 && AESL_done == 1'b1)
        lat_total = clk_cnt - start_timestamp[0];
end

initial begin
    start_cnt = 0;
    finish_cnt = 0;
    ap_ready_cnt = 0;
    wait (AESL_reset == 0);
    wait_start();
    start_timestamp[start_cnt] = clk_cnt;
    start_cnt = start_cnt + 1;
    if (AESL_done) begin
        finish_timestamp[finish_cnt] = clk_cnt;
        finish_cnt = finish_cnt + 1;
    end
    -> report_progress;
    forever begin
        @ (posedge AESL_clock);
        if (start_cnt < AUTOTB_TRANSACTION_NUM) begin
            if ((AESL_start && AESL_ready_p1)||(AESL_start && ~AESL_start_p1)) begin
                start_timestamp[start_cnt] = clk_cnt;
                start_cnt = start_cnt + 1;
            end
        end
        if (ap_ready_cnt < AUTOTB_TRANSACTION_NUM) begin
            if (AESL_start_p1 && AESL_ready_p1) begin
                ready_timestamp[ap_ready_cnt] = clk_cnt;
                ap_ready_cnt = ap_ready_cnt + 1;
            end
        end
        if (finish_cnt < AUTOTB_TRANSACTION_NUM) begin
            if (AESL_done) begin
                finish_timestamp[finish_cnt] = clk_cnt;
                finish_cnt = finish_cnt + 1;
            end
        end
        -> report_progress;
    end
end

reg [31:0] progress_timeout;

initial begin : simulation_progress
    real intra_progress;
    wait (AESL_reset == 0);
    progress_timeout = PROGRESS_TIMEOUT;
    $display("////////////////////////////////////////////////////////////////////////////////////");
    $display("// Inter-Transaction Progress: Completed Transaction / Total Transaction");
    $display("// Intra-Transaction Progress: Measured Latency / Latency Estimation * 100%%");
    $display("//");
    $display("// RTL Simulation : \"Inter-Transaction Progress\" [\"Intra-Transaction Progress\"] @ \"Simulation Time\"");
    $display("////////////////////////////////////////////////////////////////////////////////////");
    print_progress();
    while (finish_cnt < AUTOTB_TRANSACTION_NUM) begin
        @ (report_progress);
        if (finish_cnt < AUTOTB_TRANSACTION_NUM) begin
            if (AESL_done) begin
                print_progress();
                progress_timeout = PROGRESS_TIMEOUT;
            end else begin
                if (progress_timeout == 0) begin
                    print_progress();
                    progress_timeout = PROGRESS_TIMEOUT;
                end else begin
                    progress_timeout = progress_timeout - 1;
                end
            end
        end
    end
    print_progress();
    $display("////////////////////////////////////////////////////////////////////////////////////");
    calculate_performance();
end

task get_intra_progress(output real intra_progress);
    begin
        if (start_cnt > finish_cnt) begin
            intra_progress = clk_cnt - start_timestamp[finish_cnt];
        end else if(finish_cnt > 0) begin
            intra_progress = LATENCY_ESTIMATION;
        end else begin
            intra_progress = 0;
        end
        intra_progress = intra_progress / LATENCY_ESTIMATION;
    end
endtask

task print_progress();
    real intra_progress;
    begin
        if (LATENCY_ESTIMATION > 0) begin
            get_intra_progress(intra_progress);
            $display("// RTL Simulation : %0d / %0d [%2.2f%%] @ \"%0t\"", finish_cnt, AUTOTB_TRANSACTION_NUM, intra_progress * 100, $time);
        end else begin
            $display("// RTL Simulation : %0d / %0d [n/a] @ \"%0t\"", finish_cnt, AUTOTB_TRANSACTION_NUM, $time);
        end
    end
endtask

task calculate_performance();
    integer i;
    integer fp;
    reg [31:0] latency [0:AUTOTB_TRANSACTION_NUM - 1];
    reg [31:0] latency_min;
    reg [31:0] latency_max;
    reg [31:0] latency_total;
    reg [31:0] latency_average;
    reg [31:0] interval [0:AUTOTB_TRANSACTION_NUM - 2];
    reg [31:0] interval_min;
    reg [31:0] interval_max;
    reg [31:0] interval_total;
    reg [31:0] interval_average;
    reg [31:0] total_execute_time;
    begin
        latency_min = -1;
        latency_max = 0;
        latency_total = 0;
        interval_min = -1;
        interval_max = 0;
        interval_total = 0;
        total_execute_time = lat_total;

        for (i = 0; i < AUTOTB_TRANSACTION_NUM; i = i + 1) begin
            // calculate latency
            latency[i] = finish_timestamp[i] - start_timestamp[i];
            if (latency[i] > latency_max) latency_max = latency[i];
            if (latency[i] < latency_min) latency_min = latency[i];
            latency_total = latency_total + latency[i];
            // calculate interval
            if (AUTOTB_TRANSACTION_NUM == 1) begin
                interval[i] = 0;
                interval_max = 0;
                interval_min = 0;
                interval_total = 0;
            end else if (i < AUTOTB_TRANSACTION_NUM - 1) begin
                interval[i] = start_timestamp[i + 1] - start_timestamp[i];
                if (interval[i] > interval_max) interval_max = interval[i];
                if (interval[i] < interval_min) interval_min = interval[i];
                interval_total = interval_total + interval[i];
            end
        end

        latency_average = latency_total / AUTOTB_TRANSACTION_NUM;
        if (AUTOTB_TRANSACTION_NUM == 1) begin
            interval_average = 0;
        end else begin
            interval_average = interval_total / (AUTOTB_TRANSACTION_NUM - 1);
        end

        fp = $fopen(`AUTOTB_LAT_RESULT_FILE, "w");

        $fdisplay(fp, "$MAX_LATENCY = \"%0d\"", latency_max);
        $fdisplay(fp, "$MIN_LATENCY = \"%0d\"", latency_min);
        $fdisplay(fp, "$AVER_LATENCY = \"%0d\"", latency_average);
        $fdisplay(fp, "$MAX_THROUGHPUT = \"%0d\"", interval_max);
        $fdisplay(fp, "$MIN_THROUGHPUT = \"%0d\"", interval_min);
        $fdisplay(fp, "$AVER_THROUGHPUT = \"%0d\"", interval_average);
        $fdisplay(fp, "$TOTAL_EXECUTE_TIME = \"%0d\"", total_execute_time);

        $fclose(fp);

        fp = $fopen(`AUTOTB_PER_RESULT_TRANS_FILE, "w");

        $fdisplay(fp, "%20s%16s%16s", "", "latency", "interval");
        if (AUTOTB_TRANSACTION_NUM == 1) begin
            i = 0;
            $fdisplay(fp, "transaction%8d:%16d%16d", i, latency[i], interval[i]);
        end else begin
            for (i = 0; i < AUTOTB_TRANSACTION_NUM; i = i + 1) begin
                if (i < AUTOTB_TRANSACTION_NUM - 1) begin
                    $fdisplay(fp, "transaction%8d:%16d%16d", i, latency[i], interval[i]);
                end else begin
                    $fdisplay(fp, "transaction%8d:%16d               x", i, latency[i]);
                end
            end
        end

        $fclose(fp);
    end
endtask


////////////////////////////////////////////
// Dependence Check
////////////////////////////////////////////

`ifndef POST_SYN

`endif
///////////////////////////////////////////////////////
// dataflow status monitor
///////////////////////////////////////////////////////
dataflow_monitor U_dataflow_monitor(
    .clock(AESL_clock),
    .reset(rst),
    .finish(all_finish));

`include "fifo_para.vh"
endmodule
