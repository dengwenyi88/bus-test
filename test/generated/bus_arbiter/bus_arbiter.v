module RRArbiter(
  input        clock,
  output       io_in_0_ready,
  input        io_in_0_valid,
  input        io_in_0_bits,
  output       io_in_1_ready,
  input        io_in_1_valid,
  input        io_in_1_bits,
  output       io_in_2_ready,
  input        io_in_2_valid,
  input        io_in_2_bits,
  output       io_in_3_ready,
  input        io_in_3_valid,
  input        io_in_3_bits,
  input        io_out_ready,
  output       io_out_valid,
  output       io_out_bits,
  output [1:0] io_chosen
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  _GEN_1 = 2'h1 == io_chosen ? io_in_1_valid : io_in_0_valid; // @[Arbiter.scala 55:{16,16}]
  wire  _GEN_2 = 2'h2 == io_chosen ? io_in_2_valid : _GEN_1; // @[Arbiter.scala 55:{16,16}]
  wire  _GEN_5 = 2'h1 == io_chosen ? io_in_1_bits : io_in_0_bits; // @[Arbiter.scala 56:{15,15}]
  wire  _GEN_6 = 2'h2 == io_chosen ? io_in_2_bits : _GEN_5; // @[Arbiter.scala 56:{15,15}]
  wire  _ctrl_validMask_grantMask_lastGrant_T = io_out_ready & io_out_valid; // @[Decoupled.scala 52:35]
  reg [1:0] lastGrant; // @[Reg.scala 19:16]
  wire  grantMask_1 = 2'h1 > lastGrant; // @[Arbiter.scala 81:49]
  wire  grantMask_2 = 2'h2 > lastGrant; // @[Arbiter.scala 81:49]
  wire  grantMask_3 = 2'h3 > lastGrant; // @[Arbiter.scala 81:49]
  wire  validMask_1 = io_in_1_valid & grantMask_1; // @[Arbiter.scala 82:76]
  wire  validMask_2 = io_in_2_valid & grantMask_2; // @[Arbiter.scala 82:76]
  wire  validMask_3 = io_in_3_valid & grantMask_3; // @[Arbiter.scala 82:76]
  wire  ctrl_2 = ~validMask_1; // @[Arbiter.scala 45:78]
  wire  ctrl_3 = ~(validMask_1 | validMask_2); // @[Arbiter.scala 45:78]
  wire  ctrl_4 = ~(validMask_1 | validMask_2 | validMask_3); // @[Arbiter.scala 45:78]
  wire  ctrl_5 = ~(validMask_1 | validMask_2 | validMask_3 | io_in_0_valid); // @[Arbiter.scala 45:78]
  wire  ctrl_6 = ~(validMask_1 | validMask_2 | validMask_3 | io_in_0_valid | io_in_1_valid); // @[Arbiter.scala 45:78]
  wire  ctrl_7 = ~(validMask_1 | validMask_2 | validMask_3 | io_in_0_valid | io_in_1_valid | io_in_2_valid); // @[Arbiter.scala 45:78]
  wire  _T_3 = grantMask_1 | ctrl_5; // @[Arbiter.scala 86:50]
  wire  _T_5 = ctrl_2 & grantMask_2 | ctrl_6; // @[Arbiter.scala 86:50]
  wire  _T_7 = ctrl_3 & grantMask_3 | ctrl_7; // @[Arbiter.scala 86:50]
  wire [1:0] _GEN_9 = io_in_2_valid ? 2'h2 : 2'h3; // @[Arbiter.scala 91:{26,35}]
  wire [1:0] _GEN_10 = io_in_1_valid ? 2'h1 : _GEN_9; // @[Arbiter.scala 91:{26,35}]
  wire [1:0] _GEN_11 = io_in_0_valid ? 2'h0 : _GEN_10; // @[Arbiter.scala 91:{26,35}]
  wire [1:0] _GEN_12 = validMask_3 ? 2'h3 : _GEN_11; // @[Arbiter.scala 93:{24,33}]
  wire [1:0] _GEN_13 = validMask_2 ? 2'h2 : _GEN_12; // @[Arbiter.scala 93:{24,33}]
  assign io_in_0_ready = ctrl_4 & io_out_ready; // @[Arbiter.scala 74:21]
  assign io_in_1_ready = _T_3 & io_out_ready; // @[Arbiter.scala 74:21]
  assign io_in_2_ready = _T_5 & io_out_ready; // @[Arbiter.scala 74:21]
  assign io_in_3_ready = _T_7 & io_out_ready; // @[Arbiter.scala 74:21]
  assign io_out_valid = 2'h3 == io_chosen ? io_in_3_valid : _GEN_2; // @[Arbiter.scala 55:{16,16}]
  assign io_out_bits = 2'h3 == io_chosen ? io_in_3_bits : _GEN_6; // @[Arbiter.scala 56:{15,15}]
  assign io_chosen = validMask_1 ? 2'h1 : _GEN_13; // @[Arbiter.scala 93:{24,33}]
  always @(posedge clock) begin
    if (_ctrl_validMask_grantMask_lastGrant_T) begin // @[Reg.scala 20:18]
      lastGrant <= io_chosen; // @[Reg.scala 20:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  lastGrant = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module bus_arbiter(
  input        clock,
  input        reset,
  output       io_in_0_ready,
  input        io_in_0_valid,
  input        io_in_0_bits,
  output       io_in_1_ready,
  input        io_in_1_valid,
  input        io_in_1_bits,
  output       io_in_2_ready,
  input        io_in_2_valid,
  input        io_in_2_bits,
  output       io_in_3_ready,
  input        io_in_3_valid,
  input        io_in_3_bits,
  input        io_out_ready,
  output       io_out_valid,
  output       io_out_bits,
  output [1:0] io_chosen
);
  wire  arbiter_clock; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_in_0_ready; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_in_0_valid; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_in_0_bits; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_in_1_ready; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_in_1_valid; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_in_1_bits; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_in_2_ready; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_in_2_valid; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_in_2_bits; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_in_3_ready; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_in_3_valid; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_in_3_bits; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_out_ready; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_out_valid; // @[bus_arbiter.scala 13:25]
  wire  arbiter_io_out_bits; // @[bus_arbiter.scala 13:25]
  wire [1:0] arbiter_io_chosen; // @[bus_arbiter.scala 13:25]
  RRArbiter arbiter ( // @[bus_arbiter.scala 13:25]
    .clock(arbiter_clock),
    .io_in_0_ready(arbiter_io_in_0_ready),
    .io_in_0_valid(arbiter_io_in_0_valid),
    .io_in_0_bits(arbiter_io_in_0_bits),
    .io_in_1_ready(arbiter_io_in_1_ready),
    .io_in_1_valid(arbiter_io_in_1_valid),
    .io_in_1_bits(arbiter_io_in_1_bits),
    .io_in_2_ready(arbiter_io_in_2_ready),
    .io_in_2_valid(arbiter_io_in_2_valid),
    .io_in_2_bits(arbiter_io_in_2_bits),
    .io_in_3_ready(arbiter_io_in_3_ready),
    .io_in_3_valid(arbiter_io_in_3_valid),
    .io_in_3_bits(arbiter_io_in_3_bits),
    .io_out_ready(arbiter_io_out_ready),
    .io_out_valid(arbiter_io_out_valid),
    .io_out_bits(arbiter_io_out_bits),
    .io_chosen(arbiter_io_chosen)
  );
  assign io_in_0_ready = arbiter_io_in_0_ready; // @[bus_arbiter.scala 14:19]
  assign io_in_1_ready = arbiter_io_in_1_ready; // @[bus_arbiter.scala 14:19]
  assign io_in_2_ready = arbiter_io_in_2_ready; // @[bus_arbiter.scala 14:19]
  assign io_in_3_ready = arbiter_io_in_3_ready; // @[bus_arbiter.scala 14:19]
  assign io_out_valid = arbiter_io_out_valid; // @[bus_arbiter.scala 15:12]
  assign io_out_bits = arbiter_io_out_bits; // @[bus_arbiter.scala 15:12]
  assign io_chosen = arbiter_io_chosen; // @[bus_arbiter.scala 16:15]
  assign arbiter_clock = clock;
  assign arbiter_io_in_0_valid = io_in_0_valid; // @[bus_arbiter.scala 14:19]
  assign arbiter_io_in_0_bits = io_in_0_bits; // @[bus_arbiter.scala 14:19]
  assign arbiter_io_in_1_valid = io_in_1_valid; // @[bus_arbiter.scala 14:19]
  assign arbiter_io_in_1_bits = io_in_1_bits; // @[bus_arbiter.scala 14:19]
  assign arbiter_io_in_2_valid = io_in_2_valid; // @[bus_arbiter.scala 14:19]
  assign arbiter_io_in_2_bits = io_in_2_bits; // @[bus_arbiter.scala 14:19]
  assign arbiter_io_in_3_valid = io_in_3_valid; // @[bus_arbiter.scala 14:19]
  assign arbiter_io_in_3_bits = io_in_3_bits; // @[bus_arbiter.scala 14:19]
  assign arbiter_io_out_ready = io_out_ready; // @[bus_arbiter.scala 15:12]
endmodule
