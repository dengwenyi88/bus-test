
package test
import chisel3._
import chisel3.experimental._
import chisel3.util._

class bus_bundle_in extends Bundle {
    val m_req      = Input(UInt(1.W))
    var m_grnt     = Output(UInt(1.W))
    var m_io       = Flipped(new bus_master_bunle)
}

class bus extends Module {
    var io = IO(new Bundle{
        var in_master = Input(Vec(4,new bus_bundle_in))
        var in_slave  = Input(Vec(8,Flipped(new bus_slave_bunle)))

        var out_m_data = Output(new bus_master_bunle)
        var out_s_data = Output(new bus_slave_bunle)
    })

    // 总线仲裁
    var arbiter = Module(new bus_arbiter)
    // val arbiter_io = Vec(4,Decoupled(UInt(1.W)))
    val reqs = io.in_master.zipWithIndex.foreach{ case (port,i) =>
        arbiter.io.in(i) := Wire(io.in_master(i).m_req)
        // arbiter_io(i) := io.in_master(i).m_req
    }
    io.in_master.zipWithIndex.foreach{ case (port,i) =>
        io.in_master(i).m_grnt = arbiter.io.chosen(i)
    }

    // 主设备
    var master_mux = Module(new bus_master_mux)
    master_mux.io.chosen <> arbiter.io.chosen
    master_mux.io.in.zipWithIndex.foreach{ case (port,i) =>
        master_mux.io.in(i) <> io.in_master(i).m_io
    }
    io.out_m_data <> master_mux.io.out

    // 从设备仲裁
    var addr_dec = Module(new bus_addr_dec)
    addr_dec.io.in <> master_mux.io.out.m_addr.asUInt
    val slave_chosen = addr_dec.io.out

    // 从设备
    var slave_mux = Module(new bus_slave_mux)
    slave_mux.io.chosen := slave_chosen.asUInt
    io.in_slave.zipWithIndex.foreach{ case (port,i) =>
        slave_mux.io.in(i) := io.in_slave(i)
    }
    io.out_s_data := slave_mux.io.out
}