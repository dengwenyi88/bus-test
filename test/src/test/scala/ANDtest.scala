
package test

import chisel3.stage.ChiselGeneratorAnnotation


object testMain extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir","generated/and"),Seq(ChiselGeneratorAnnotation(() => new AND)))
}