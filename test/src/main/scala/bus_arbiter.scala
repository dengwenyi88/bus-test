package test
import chisel3._
import chisel3.experimental._
import chisel3.util._

class bus_arbiter extends Module {
    var io = IO(new Bundle{
        var in = Flipped(Vec(4,Decoupled(UInt(1.W))))
        var out = Decoupled(UInt(1.W))
        var chosen = Output(UInt(2.W))
    })

    var arbiter = Module(new RRArbiter(UInt(1.W),4))
    arbiter.io.in <> io.in 
    io.out <> arbiter.io.out
    io.chosen := arbiter.io.chosen
}