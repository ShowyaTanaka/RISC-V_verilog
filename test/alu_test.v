/*
ALUオペコード
0000 AND
0001 OR
0010 加算
0011 減算
0100 slt
0101 NOR
0110 右シフト
0111 左シフト
仕様メモ
ビットシフトする場合in1に数字が入ることを期待しない。仮に数字が入力されていたとしても一切無視する。
*/
module ALU32(in0,in1,op,out);
    input[31:0] in0;
    input[31:0] in1;
    input[2:0] op;
    output reg[31:0] out;
    always @* begin
        if (op==0) begin
            out <= in0&in1;
        end
         else if (op == 1) begin
            out <= in0|in1;
        end else if (op == 2) begin
            out <= in0 + in1;
        end else if (op == 3 | op == 4) begin
            //最初の加算機のみはin1をビット反転させて1加える処理が必要。
            out <= in0 - in1;
        end
        else if (op == 5) begin
            out <= in0 ~| in1;
        end
        else if(op == 6) begin
            out <= in0 >> 1;
        end else if(op == 7) begin
            out <= in0 << 1;
        end
    end
endmodule

module test();

    reg [31:0] a;
    reg [31:0] b;
    reg [2:0] op;
    output [31:0] out;
    ALU32 alu(.in0(a),.in1(b),.op(op),.out(out));
    initial begin
        #0
        a = 4'b0001;
        b = 4'b0001;
        op = 4'b0011;
        #10
        $displayb(out);
    end
endmodule