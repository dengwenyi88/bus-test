circuit bus_arbiter :
  module RRArbiter :
    input clock : Clock
    input reset : Reset
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<1>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<1>}, chosen : UInt<2>}

    wire choice : UInt
    choice <= UInt<2>("h3")
    io.chosen <= choice @[Arbiter.scala 54:13]
    io.out.valid <= io.in[io.chosen].valid @[Arbiter.scala 55:16]
    io.out.bits <= io.in[io.chosen].bits @[Arbiter.scala 56:15]
    node _ctrl_validMask_grantMask_lastGrant_T = and(io.out.ready, io.out.valid) @[Decoupled.scala 52:35]
    reg lastGrant : UInt<2>, clock with :
      reset => (UInt<1>("h0"), lastGrant) @[Reg.scala 19:16]
    when _ctrl_validMask_grantMask_lastGrant_T : @[Reg.scala 20:18]
      lastGrant <= io.chosen @[Reg.scala 20:22]
    node grantMask_0 = gt(UInt<1>("h0"), lastGrant) @[Arbiter.scala 81:49]
    node grantMask_1 = gt(UInt<1>("h1"), lastGrant) @[Arbiter.scala 81:49]
    node grantMask_2 = gt(UInt<2>("h2"), lastGrant) @[Arbiter.scala 81:49]
    node grantMask_3 = gt(UInt<2>("h3"), lastGrant) @[Arbiter.scala 81:49]
    node validMask_0 = and(io.in[0].valid, grantMask_0) @[Arbiter.scala 82:76]
    node validMask_1 = and(io.in[1].valid, grantMask_1) @[Arbiter.scala 82:76]
    node validMask_2 = and(io.in[2].valid, grantMask_2) @[Arbiter.scala 82:76]
    node validMask_3 = and(io.in[3].valid, grantMask_3) @[Arbiter.scala 82:76]
    node _ctrl_T = or(validMask_0, validMask_1) @[Arbiter.scala 45:68]
    node _ctrl_T_1 = or(_ctrl_T, validMask_2) @[Arbiter.scala 45:68]
    node _ctrl_T_2 = or(_ctrl_T_1, validMask_3) @[Arbiter.scala 45:68]
    node _ctrl_T_3 = or(_ctrl_T_2, io.in[0].valid) @[Arbiter.scala 45:68]
    node _ctrl_T_4 = or(_ctrl_T_3, io.in[1].valid) @[Arbiter.scala 45:68]
    node _ctrl_T_5 = or(_ctrl_T_4, io.in[2].valid) @[Arbiter.scala 45:68]
    node ctrl_1 = eq(validMask_0, UInt<1>("h0")) @[Arbiter.scala 45:78]
    node ctrl_2 = eq(_ctrl_T, UInt<1>("h0")) @[Arbiter.scala 45:78]
    node ctrl_3 = eq(_ctrl_T_1, UInt<1>("h0")) @[Arbiter.scala 45:78]
    node ctrl_4 = eq(_ctrl_T_2, UInt<1>("h0")) @[Arbiter.scala 45:78]
    node ctrl_5 = eq(_ctrl_T_3, UInt<1>("h0")) @[Arbiter.scala 45:78]
    node ctrl_6 = eq(_ctrl_T_4, UInt<1>("h0")) @[Arbiter.scala 45:78]
    node ctrl_7 = eq(_ctrl_T_5, UInt<1>("h0")) @[Arbiter.scala 45:78]
    node _T = and(UInt<1>("h1"), grantMask_0) @[Arbiter.scala 86:34]
    node _T_1 = or(_T, ctrl_4) @[Arbiter.scala 86:50]
    node _T_2 = and(ctrl_1, grantMask_1) @[Arbiter.scala 86:34]
    node _T_3 = or(_T_2, ctrl_5) @[Arbiter.scala 86:50]
    node _T_4 = and(ctrl_2, grantMask_2) @[Arbiter.scala 86:34]
    node _T_5 = or(_T_4, ctrl_6) @[Arbiter.scala 86:50]
    node _T_6 = and(ctrl_3, grantMask_3) @[Arbiter.scala 86:34]
    node _T_7 = or(_T_6, ctrl_7) @[Arbiter.scala 86:50]
    node _io_in_0_ready_T = and(_T_1, io.out.ready) @[Arbiter.scala 74:21]
    io.in[0].ready <= _io_in_0_ready_T @[Arbiter.scala 74:16]
    node _io_in_1_ready_T = and(_T_3, io.out.ready) @[Arbiter.scala 74:21]
    io.in[1].ready <= _io_in_1_ready_T @[Arbiter.scala 74:16]
    node _io_in_2_ready_T = and(_T_5, io.out.ready) @[Arbiter.scala 74:21]
    io.in[2].ready <= _io_in_2_ready_T @[Arbiter.scala 74:16]
    node _io_in_3_ready_T = and(_T_7, io.out.ready) @[Arbiter.scala 74:21]
    io.in[3].ready <= _io_in_3_ready_T @[Arbiter.scala 74:16]
    when io.in[2].valid : @[Arbiter.scala 91:26]
      choice <= UInt<2>("h2") @[Arbiter.scala 91:35]
    when io.in[1].valid : @[Arbiter.scala 91:26]
      choice <= UInt<1>("h1") @[Arbiter.scala 91:35]
    when io.in[0].valid : @[Arbiter.scala 91:26]
      choice <= UInt<1>("h0") @[Arbiter.scala 91:35]
    when validMask_3 : @[Arbiter.scala 93:24]
      choice <= UInt<2>("h3") @[Arbiter.scala 93:33]
    when validMask_2 : @[Arbiter.scala 93:24]
      choice <= UInt<2>("h2") @[Arbiter.scala 93:33]
    when validMask_1 : @[Arbiter.scala 93:24]
      choice <= UInt<1>("h1") @[Arbiter.scala 93:33]

  module bus_arbiter :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<1>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<1>}, chosen : UInt<2>}

    inst arbiter of RRArbiter @[bus_arbiter.scala 13:25]
    arbiter.clock <= clock
    arbiter.reset <= reset
    arbiter.io.in <= io.in @[bus_arbiter.scala 14:19]
    io.out.bits <= arbiter.io.out.bits @[bus_arbiter.scala 15:12]
    io.out.valid <= arbiter.io.out.valid @[bus_arbiter.scala 15:12]
    arbiter.io.out.ready <= io.out.ready @[bus_arbiter.scala 15:12]
    io.chosen <= arbiter.io.chosen @[bus_arbiter.scala 16:15]

