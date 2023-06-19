//clk:クロック
//rst:リセット
//ACKD_n,ACKI_n:メモリの値が取れたらアクティブになる
//IAD:プログラムカウンタと接続するように。
//IDT,DDT:メモリのデータパス(32bit)
//DAD:アドレスデータパス
//データを保持する系はクロックを受信したタイミングでリセットを(シングルサイクルなので)
//alu-regはslt用にmuxを設置する。
`include "decoder.v"
`include "rf32x32.v"
`include "bit_adder.v"
`include "mux.v"
module top(//Inputs
               clk,rst,
               ACKD_n,ACKI_n, 
               IDT,OINT_n,
               //Outputs
               IAD,DAD, 
               MREQ,WRITE, 
               SIZE,IACK_n, 
               //Inout
               DDT
               );
    input clk,rst,ACKD_n,ACKI_n;
    output[31:0] IAD,DAD;
    output MREQ,WRITE,IACK_n;
    output[1:0] SIZE;
    inout [31:0] DDT;
    input[31:0] IDT;
    input[2:0] OINT_n;
    wire write_signal;
    reg[31:0] IAD_reg,DAD_reg;
    reg MREQ_reg,WRITE_reg,IACK_n_reg;
    reg DDT_rw;//(0:read,1:write) 適宜書き換えるように。
    reg[31:0] DDT_reg;
    reg[1:0] SIZE_reg;
    assign SIZE=SIZE_reg;
    assign IAD=IAD_reg;
    assign DAD=DAD_reg;
    assign DDT=(DDT_rw)? DDT_reg:32'bz;
    //配線を作成。
    wire [31:0] dec_to_u;
    wire [4:0] r_addr1,r_addr2,w_addr;
    wire[3:0] dec_to_alu;
    wire[11:0] imm_out;
    wire[31:0] ext_to_alu_mux,mux_to_alu_in1,reg_to_mux0,reg_to_alu_in0;
    //モジュールたちをいかに設置。
    decoder decode(.clk(clk),.r_addr1(r_addr1),.r_addr2(r_addr2),.w_addr(w_addr),.alu_op(dec_to_alu),.op_value(IDT),.u_out(dec_to_u),.imm_out(imm_out));
    rf32x32 register(.clk(clk),.reset(rst),.wr_n(write_signal),.rd1_addr(r_addr1),.rd2_addr(r_addr2),.data1_out(reg_to_alu_in0));
    12_to_32 imm_ext(.in(imm_out),.out(ext_to_alu_mux));
    2in_1out_mux alu_val1(.in0(reg_to_mux0),.in1(ext_to_alu_mux),.out(mux_to_alu_in1));
    ALU32 R_I_alu(.in0(reg_to_alu_in0),.in1(mux_to_alu_in1),.op(dec_to_alu),.out(),.of_detect()); 
endmodule