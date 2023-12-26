

package test

import chisel3.stage.ChiselGeneratorAnnotation

object testMain extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir","generated/bus_arbiter"),
        Seq(ChiselGeneratorAnnotation(() => new bus_arbiter)))

    (new chisel3.stage.ChiselStage).execute(Array("--target-dir","generated/bus_master_mux"),
        Seq(ChiselGeneratorAnnotation(() => new bus_master_mux)))

    (new chisel3.stage.ChiselStage).execute(Array("--target-dir","generated/bus_addr_dec"),
        Seq(ChiselGeneratorAnnotation(() => new bus_addr_dec)))
}