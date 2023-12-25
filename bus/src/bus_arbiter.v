
`include "nettype.v"
`include "stddef.v"
`include "global_config.v"

`include "bus.v"

module bus_arbiter (
	input  wire		   clk,		 // クロック
	input  wire		   reset,	 // 非同期リセット
	
	input  wire		   m0_req_,	 // バスリクエスト
	output reg		   m0_grnt_, // バスグラント

	input  wire		   m1_req_,	 // バスリクエスト
	output reg		   m1_grnt_, // バスグラント

	input  wire		   m2_req_,	 // バスリクエスト
	output reg		   m2_grnt_, // バスグラント

	input  wire		   m3_req_,	 // バスリクエスト
	output reg		   m3_grnt_	 // バスグラント
);

	reg [`BusOwnerBus] owner;	 // バス権の所有者
   
	always @(*) begin
		m0_grnt_ = `DISABLE_;
		m1_grnt_ = `DISABLE_;
		m2_grnt_ = `DISABLE_;
		m3_grnt_ = `DISABLE_;
		
		case (owner)
			`BUS_OWNER_MASTER_0 : begin // バスマスタ0番
				m0_grnt_ = `ENABLE_;
			end
			`BUS_OWNER_MASTER_1 : begin // バスマスタ1番
				m1_grnt_ = `ENABLE_;
			end
			`BUS_OWNER_MASTER_2 : begin // バスマスタ2番
				m2_grnt_ = `ENABLE_;
			end
			`BUS_OWNER_MASTER_3 : begin // バスマスタ3番
				m3_grnt_ = `ENABLE_;
			end
		endcase
	end
   
	always @(posedge clk or `RESET_EDGE reset) begin
		if (reset == `RESET_ENABLE) begin
			owner <= #1 `BUS_OWNER_MASTER_0;
		end else begin
			case (owner)
				`BUS_OWNER_MASTER_0 : begin
					if (m0_req_ == `ENABLE_) begin			// バスマスタ0番
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else if (m1_req_ == `ENABLE_) begin // バスマスタ1番
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else if (m2_req_ == `ENABLE_) begin // バスマスタ2番
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else if (m3_req_ == `ENABLE_) begin // バスマスタ3番
						owner <= #1 `BUS_OWNER_MASTER_3;
					end
				end
				`BUS_OWNER_MASTER_1 : begin
					if (m1_req_ == `ENABLE_) begin			// バスマスタ1番
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else if (m2_req_ == `ENABLE_) begin // バスマスタ2番
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else if (m3_req_ == `ENABLE_) begin // バスマスタ3番
						owner <= #1 `BUS_OWNER_MASTER_3;
					end else if (m0_req_ == `ENABLE_) begin // バスマスタ0番
						owner <= #1 `BUS_OWNER_MASTER_0;
					end
				end
				`BUS_OWNER_MASTER_2 : begin // バス権所有者：バスマスタ2番
					if (m2_req_ == `ENABLE_) begin			// バスマスタ2番
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else if (m3_req_ == `ENABLE_) begin // バスマスタ3番
						owner <= #1 `BUS_OWNER_MASTER_3;
					end else if (m0_req_ == `ENABLE_) begin // バスマスタ0番
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else if (m1_req_ == `ENABLE_) begin // バスマスタ1番
						owner <= #1 `BUS_OWNER_MASTER_1;
					end
				end
				`BUS_OWNER_MASTER_3 : begin // バス権所有者：バスマスタ3番
					if (m3_req_ == `ENABLE_) begin			// バスマスタ3番
						owner <= #1 `BUS_OWNER_MASTER_3;
					end else if (m0_req_ == `ENABLE_) begin // バスマスタ0番
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else if (m1_req_ == `ENABLE_) begin // バスマスタ1番
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else if (m2_req_ == `ENABLE_) begin // バスマスタ2番
						owner <= #1 `BUS_OWNER_MASTER_2;
					end
				end
			endcase
		end
	end

endmodule
