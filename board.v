//muxなどをここに設置し切る。
`include "decoder.v"
`include "u_exec.v"
`include "alu32.v"
`include "context_2in_1out_mux.v"
module board(decoder_in,pc_value);
    wire dec_is_write, dec_alusrc, dec_pcsrc, dec_regwritesrc, dec_is_access_memory, dec_is_write_memory;
    wire[31:0] decode_to_u, decodeout_alu_0, decodeout_alu_1;
    wire[2:0] decode_to_alu;
    wire[4:0] dec_read_reg1, dec_read_reg2, dec_write_reg;
    input[31:0] pc_value;
    decoder Decoder(.read_reg1(dec_read_reg1),.read_reg2(dec_read_reg2),.write_reg(dec_write_reg),
    .is_write(dec_is_write),.alu_op(decode_to_alu),.alusrc(dec_alusrc),
    .pcsrc(dec_pcsrc),.regwritesrc(dec_regwritesrc),.is_access_memory(dec_is_access_memory),.is_write_memory(dec_is_write_memory),
    .op_value(op),.u_out(decode_to_u));
    alu32 alu()
endmodule