`include "bus.v"

`ifndef SIM_CYCLE
    `define SIM_CYCLE 60
`endif

// `timescale 1ns/1ns
module bus_arbiter_tb; 
    reg clk, reset; 
    reg m0_req_,m1_req_,m2_req_,m3_req_;
    wire m0_grnt_,m1_grnt_,m2_grnt_,m3_grnt_;
    parameter STEP = 5.0000; // 10 M

    bus_arbiter bus_arbiter(
        .clk(clk),
        .reset(reset),
        .m0_req_(m0_req_),
        .m0_grnt_(m0_grnt_),
        .m1_req_(m1_req_),
        .m1_grnt_(m1_grnt_),
        .m2_req_(m2_req_),
        .m2_grnt_(m2_grnt_),
        .m3_req_(m3_req_),
        .m3_grnt_(m3_grnt_));

    always #( STEP ) begin
		clk <= ~clk;
	end

    initial begin
		# 0 begin
			clk	 <= `HIGH;
			reset <= `RESET_ENABLE;
		end
        

        # ( STEP * 5 ) begin
			reset <= `RESET_DISABLE;
		end

        # ( STEP * 5 ) begin
            m0_req_ <= `ENABLE_;
        end

        # ( STEP * 6 ) begin
            m1_req_ <= `ENABLE_;
        end

        # ( STEP * 7 ) begin
            m2_req_ <= `ENABLE_;
        end

        # ( STEP * 8 ) begin
            m3_req_ <= `ENABLE_;
        end

        # ( STEP * 12 ) begin
            m0_req_ <= `DISABLE_;
        end

        # ( STEP * 14 ) begin
            m1_req_ <= `DISABLE_;
        end

        # ( STEP * 16 ) begin
            m2_req_ <= `DISABLE_;
        end

        # ( STEP * 18 ) begin
            m3_req_ <= `DISABLE_;
        end

        # ( STEP * `SIM_CYCLE ) begin
			$finish;
		end
    end

    initial
    begin            
        $dumpfile("bus_arbiter_tb.vcd"); //生成的vcd文件名称
        $dumpvars(0, bus_arbiter_tb);    //tb模块名称
    end 

endmodule