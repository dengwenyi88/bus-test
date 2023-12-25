
`ifndef __STDDEF_HEADER__				
`define __STDDEF_HEADER__

	`define HIGH				1'b1	 // Highレベル
	`define LOW					1'b0	 // Lowレベル
	
	`define DISABLE				1'b0	 // 無効
	`define ENABLE				1'b1	 // 有効

	`define DISABLE_			1'b1	 // 無効
	`define ENABLE_				1'b0	 // 有効
	
	`define READ				1'b1	 // 読み出し
	`define WRITE				1'b0	 // 書き込み

	`define LSB					0		 // 最下位ビット

	`define BYTE_DATA_W			8		 // データ幅
	`define BYTE_MSB			7		 // 最上位ビット
	`define ByteDataBus			7:0		 // データバス

	`define WORD_DATA_W			32		 // データ幅
	`define WORD_MSB			31		 // 最上位ビット
	`define WordDataBus			31:0	 // データバス

	`define WORD_ADDR_W			30		 // アドレス幅
	`define WORD_ADDR_MSB		29		 // 最上位ビット
	`define WordAddrBus			29:0	 // アドレスバス

	`define BYTE_OFFSET_W		2		 // オフセット幅
	`define ByteOffsetBus		1:0		 // オフセットバス

	`define WordAddrLoc			31:2	 // ワードアドレスの位置
	`define ByteOffsetLoc		1:0		 // バイトオフセットの位置

	`define BYTE_OFFSET_WORD	2'b00	 // ワード境界

`endif
