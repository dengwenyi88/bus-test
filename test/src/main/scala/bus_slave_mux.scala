package test
import chisel3._
import chisel3.experimental._
import chisel3.util._

class bus_slave_bunle extends Bundle {
    val s_rd_data  = ValidIO(UInt(32.W))
}

class bus_slave_mux extends Module {
    var io = IO(new Bundle{
        val chosen = Input(UInt(8.W))
        var in = Input(Vec(8,Flipped(new bus_slave_bunle)))
        var out = Output(new bus_slave_bunle)
    })

    io.out <> Mux1H(io.chosen,io.in)
}