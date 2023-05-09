//2入力1出力のmux,テキスト条件は1,0のboolで。一応32bitまで入力可能。
module 2in_1out_mux(in_0,in_1,out);
    input[31:0] in_0,in_1;
    input is_in_1
    output[31:0] out;
    reg[31:0] out_reg;
    always @(in_0) begin
        out_reg <= in_0:
    end
    always @(in_1) begin
        out_reg <= in_1;
    end
endmodule