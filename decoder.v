/*
Boolの仕様(しかしここでは0,1で表現)を先に示しておく。
is_write:trueでレジスタに書き込み
alusrc:trueで即値,falseでレジスタ
pcsrc:trueで即値,falseで+4
regwritesrc:trueでALU,falseでメモリ
is_access_memory:trueでアクセス
is_write_memory:trueでメモリに書き込み
*/
module decoder(read_reg1, read_reg2, write_reg, is_write, alu_op, alusrc, pcsrc, regwritesrc, is_access_memory, is_write_memory, op_value);
    inout is_write, alusrc, pcsrc, regwritesrc, is_access_memory, is_write_memory;
    inout [4:0] read_reg1, read_reg2, write_reg;
    input [31:0] op_value;
    //即値を判断しデコード
    always @* begin
        case(op_value)
        
        endcase
    end
endmodule