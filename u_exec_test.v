`include "u_exec.v"
module test();
    input[6:0] op;
    input[19:0] in;
    output[31:0] out;
    output[1:0] pcop;
    input[31:0] pcvalue;
    reg[31:0] pcvalue_reg;
    U_exec test_exec(.op(op),.in(in),.out(out),.pcop(pcop),.pcvalue(pcvalue));
    reg[6:0] op_reg;
    reg[19:0] in_reg;
    assign op = op_reg;
    assign in = in_reg;
    assign pcvalue=pcvalue_reg;
    initial begin
        #0
        in_reg <= 20'b11000000000000000001;
        op_reg <= 7'b0010111;
        pcvalue_reg <= 31'b0100000000000000000000000000000;
        #10
        $displayb(out);
    end
endmodule