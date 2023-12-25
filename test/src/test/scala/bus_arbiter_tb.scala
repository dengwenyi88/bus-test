

package test

import chisel3.stage.ChiselGeneratorAnnotation

object testBusArbiter extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir","generated/bus_arbiter"),
        Seq(ChiselGeneratorAnnotation(() => new bus_arbiter)))
}