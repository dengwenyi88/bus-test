package test
import chisel3._
import chisel3.experimental._
import chisel3.util._

class bus_master_bunle extends Bundle {
    val m_addr     = ValidIO(UInt(32.W))
    val m_wr_data  = ValidIO(UInt(32.W))
}

class bus_master_mux extends Module {
    var io = IO(new Bundle{
        val chosen = Input(UInt(4.W))
        var in = Input(Vec(4,Flipped(new bus_master_bunle)))
        var out = Output(new bus_master_bunle)
    })

    // UIntToOH
    io.out <> Mux1H(io.chosen,io.in)
}