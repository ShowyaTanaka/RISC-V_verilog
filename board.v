//muxなどをここに設置し切る。
`include "decoder.v"
`include "u_exec.v"
module board(op,decoder_in);
    wire[31:0] decode_to_u;
    wire[2:0] decode_to_alu
    decoder Decoder(.read_reg1(0),.read_reg2(0),.write_reg(0),.is_write(0),.alu_op(decode_to_alu))
endmodule