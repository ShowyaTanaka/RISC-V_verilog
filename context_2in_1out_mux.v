//2入力1出力のmux,テキスト条件は1,0のboolで。一応32bitまで入力可能。
module 2in_1out_mux(in_0,in_1,context,out);
    input[31:0] in_0,in_1;
    input[1:0] context;
    output[31:0] out;
    reg[31:0] out_reg
    assign out = out_reg;
    always @(context) begin
        if (context == 0) begin
            out_reg <= in_0;
        end
        else begin
            out_reg <= in_1;
        end
    end
endmodule