package test
import chisel3._
import chisel3.experimental._
import chisel3.util._

class bus_addr_dec extends Module {
    var io = IO(new Bundle{
        val in = Input(UInt(32.W))
        val out = Output(Vec(8,UInt(1.W)))
    })

    val bools = io.in.asBools(8)
    io.out <> bools.asTypeOf(Vec(8,UInt(1.W)))
}