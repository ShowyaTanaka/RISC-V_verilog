//U-Typeの二つのみ別離させた。
module U_exec(op,in,out,pcop,pcvalue);
    //U_type用の別HWを作ります。
    //PCopは+4,入力値を+,入力値にセットの3択に
    input[6:0] op;
    input[19:0] in;
    output[31:0] out;
    output [1:0] pcop;
    input[31:0] pcvalue;
    reg[31:0] out_reg;
    reg[1:0] pcop_reg;
    assign out = out_reg;
    assign pcop = pcop_reg;
    always @(op != 0) begin
        case (op)
        7'b0110111: out_reg <= {in,12'b000000000000};
        7'b0010111: out_reg <= {in,12'b000000000000} + pcvalue;
        endcase
        pcop_reg <= 1;
    end
endmodule