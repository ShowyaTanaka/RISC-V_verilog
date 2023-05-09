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
    wire [4:0] r_addr1,r_addr2;
    //モジュールたちをいかに設置。
    decoder decode(.clk(clk),.read_reg1(r_addr1),.read_reg2(r_addr2));
endmodule