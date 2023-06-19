//2入力1出力のmux,テキスト条件は1,0のboolで。一応32bitまで入力可能。
module two_in_one_out_mux(in_0,in_1,out);
    input[31:0] in_0,in_1;
    output reg[31:0] out;
    
    always @(in_0) begin
        out <= in_0;
    end
    always @(in_1) begin
        out <= in_1;
    end
endmodule
module test();
    wire[31:0] in_0;
    wire[31:0] in_1;
    output[31:0] out;
    reg[31:0] in0_reg;
    reg[31:0] in1_reg;
    assign in_0=in0_reg;
    assign in_1=in1_reg;
    two_in_one_out_mux tes(.in_0(in_0),.in_1(in_1),.out(out));
    initial begin
        #0
        in0_reg = 5;
        #5
        $displayb(out);
        #10
        in1_reg = 10;
        #15
        $displayb(out);
    end
endmodule