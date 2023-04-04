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
module first_module(op,in0,in1,out,carry);
    wire [3:0] op;
    input in0, in1, carry;
    output out, carry;
    if (op == 0) begin
        out = in0 & in1;
        carry = 0;
    end elsif (op == 1) begin
        out = in0|in1;
        carry = 0;
    end elsif (op == 2) begin
        assign val = in0 + in1;
        out = val[1:0];
        carry = val[2:1];
    end elsif (op == 3 | op == 4) begin
        //最初の加算機のみはin1をビット反転させて1加える処理が必要。
        assign val = in0 + (in1^1) + 1;
        out = val[1:0];
        carry = val[2:1];
    end
    elsif (op == 5) begin
        out = in0 ~| in1;
        carry = 0;
    end
    elsif(op == 6) begin
        out = carry;
    end elsif(op == 7) begin
        carry = in0;
        out = 0;
    end
endmodule
