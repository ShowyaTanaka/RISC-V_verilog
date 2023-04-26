/*
ALUオペコード
0000 AND
0001 OR
0010 加算
0011 減算
0100 算術右シフト
0101 NOR
0110 右シフト
0111 左シフト
1000 in_0を12bit左シフトしたのちin1を加算。(U-Type用)
仕様メモ
ビットシフトする場合in1に数字が入ることを期待しない。仮に数字が入力されていたとしても一切無視する。
*/
module ALU32(in0,in1,op,out,of_detect,zero_detect);
    input[31:0] in0;
    input[31:0] in1;
    input[2:0] op;
    output reg[30:0] out;
    output reg of_detect;
    output reg zero_detect;
    reg [31:0] val;
    always @(op) begin
        if (op==0) begin
            out <= in0&in1;
        end
         else if (op == 1) begin
            out <= in0|in1;
        end else if (op == 2) begin
            //ほぼ必要ないと思うけどオーバーフロー一応検知しておきます。
            {of_detect, out} <= in0 + in1;
        end else if (op == 3) begin
            {of_detect, out} <= in0 - in1;
            if (out == 0 && of_detect == 0) begin
                zero_detect <= 1;
            end
        end
        else if (op == 4) begin
            out <= in0 >>> 1;
        end
        else if (op == 5) begin
            out <= in0 ~| in1;
        end
        else if(op == 6) begin
            out <= in0 >> 1;
        end 
        else if(op == 7) begin
            out <= in0 << 1;
        end
        else if(op == 8) begin
            out <= {in0[19:0],2'b000000000000} + in1;
        end
    end
endmodule

module test();

    reg [31:0] a;
    reg [31:0] b;
    reg [2:0] op;
    output [30:0] out;
    output of_detect;
    output zero_detect;
    ALU32 alu(.in0(a),.in1(b),.op(op),.out(out),.of_detect(of_detect),.zero_detect(zero_detect));
    initial begin
        #0
        a = 2147483647;
        b = 2147483647;
        op = 4'b0100;
        #10
        $displayb(out);
        $displayb(of_detect);
        $displayb(zero_detect);
    end
endmodule