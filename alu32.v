/*
ALUオペコード
AND以外は全て下1bitで正負を判別。
0001 AND
0010 OR
0011 XOR
0100 加算
0101 減算
0110 算術左シフト
0111 算術右シフト
1000 左シフト
1001 右シフト
1100 slt
1101 sltu
仕様メモ
ビットシフトする場合in1に数字が入ることを期待しない。仮に数字が入力されていたとしても一切無視する。
*/
module ALU32(in0,in1,op,out,of_detect,zero_detect);
    input[31:0] in0;
    input[31:0] in1;
    input[3:0] op;
    output reg[31:0] out;
    output reg of_detect;
    output reg zero_detect;
    reg [31:0] val;
    always @((in0 != 0 || in1 != 0) && op != 0) begin
        case (op)
            4'b0001: out <= in0 & in1;
            4'b0010: out <= in0 | in1;
            4'b0011: out <= in0 ^ in1;
            4'b0100: {of_detect, out} <= in0 + in1; //ほぼ必要ないと思うけどオーバーフロー一応検知しておきます。
            4'b0101: 
                begin 
                    {of_detect, out} <= in0 - in1;
                    if (out == 0 && of_detect == 0) 
                    begin
                        zero_detect <= 1;
                    end
                end
            4'b0110: out <= in0 <<< in1;
            4'b0111: out <= in0 >>> in1;
            4'b1000: out <= in0 << in1;
            4'b1001: out <= in0 >> in1;
            4'b1100: out <= {31'b0000000000000000000000000000000,$signed(in0) > $signed(in1)};
            4'b1101: out <= {31'b0000000000000000000000000000000,in0 > in1};
        endcase
    end
endmodule

module test();

    reg [31:0] a;
    reg [31:0] b;
    reg [3:0] op;
    output [31:0] out;
    output of_detect;
    output zero_detect;
    ALU32 alu(.in0(a),.in1(b),.op(op),.out(out),.of_detect(of_detect),.zero_detect(zero_detect));
    initial begin
        #0
        a = 2147483647;
        b = 2147483646;
        op = 4'b1101;
        #10
        $displayb(out);
        $displayb(of_detect);
        $displayb(zero_detect);
    end
endmodule