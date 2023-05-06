/*
Boolの仕様(しかしここでは0,1で表現)を先に示しておく。
is_write:trueでレジスタに書き込み
alusrc:trueで即値,falseでレジスタ
pcsrc:trueで即値,falseで+4
regwritesrc:trueでALU,falseでメモリ
is_access_memory:trueでアクセス
is_write_memory:trueでメモリに書き込み
*/
module decoder(read_reg1, read_reg2, write_reg, is_write, alu_op, alusrc, pcsrc, regwritesrc, is_access_memory, is_write_memory, op_value,u_out);
    inout is_write, alusrc, pcsrc, regwritesrc, is_access_memory, is_write_memory;
    inout [4:0] read_reg1, read_reg2, write_reg;
    input [31:0] op_value;
    output[2:0] alu_op;
    output [31:0] to_alu_in0, to_alu_in1;
    output [31:0] u_out;
    reg [31:0] u_out_reg, to_alu_in0_reg, to_alu_in1_reg;
    assign u_out = u_out_reg;
    //即値を判断しデコード
    always @* begin
        case(op_value[6:0])
            7'b0110111 || 7'b0010111: u_out_reg <= op_value;
            
        endcase
    end
endmodule