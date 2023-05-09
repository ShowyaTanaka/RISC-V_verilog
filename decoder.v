/*
Boolの仕様(しかしここでは0,1で表現)を先に示しておく。
is_write:trueでレジスタに書き込み
alusrc:trueで即値,falseでレジスタ
pcsrc:trueで即値,falseで+4
regwritesrc:trueでALU,falseでメモリ
is_access_memory:trueでアクセス
is_write_memory:trueでメモリに書き込み
*/
//初期化時は出力を全て一旦0にする。

module decoder(clk,r_addr1, r_addr2, w_addr, alu_op, op_value,u_out,imm_out);
  //  inout is_write, alusrc, pcsrc, regwritesrc, is_access_memory, is_write_memory;
    output reg[4:0] r_addr1, r_addr2, w_addr;
    input [31:0] op_value;
    input clk;
    output reg[3:0] alu_op;
    output reg[31:0] u_out;
    output reg[11:0] imm_out;
    //ここは可読性上げるよう。
    reg[6:0] opcode;
    reg[4:0] rd;
    reg[2:0] funct3;
    reg[4:0] rs1;
    reg[4:0] rs2;
    reg[6:0] funct7;
    reg reverse_op;
    assign op_value[6:0] = opcode;
    assign op_value[11:7] = rd;
    assign op_value[14:12] = funct3;
    assign op_value[19:15] = rs1;
    assign op_value[24:20] = rs2;
    assign op_value[31:25] = funct7;
    assign op_value[30:30] = reverse_op;
    //以上。
    //即値を判断しデコード。opの入力に伴って動作するように。
    always @(posedge clk) begin
        u_out <= 0;
        alu_op <= 0;
    end
    always @(op_value) begin
        if (opcode == 7'b0110111 || opcode == 7'b0010111 ) 
        begin
           u_out <= op_value;
        end
        else if (opcode == 7'b0110011) 
        begin
            if (funct3 == 000) 
            begin
                //add,subのいずれか
                alu_op <= {3'b010,reverse_op};
                r_addr1 <= rs1;
                r_addr2 <= rs2;
                w_addr <= rd;
            end
            else if (funct3 == 001) 
            begin
                //SLL
                alu_op <= 4'b1000;
                r_addr1 <= rs1;
                r_addr2 <= rs2;
                w_addr <= rd;
            end
            else if (funct3[2:1] == 2'b01) 
            begin
                //SLT,SLTU
                alu_op <= {3'b110,funct3[0:0]};
                r_addr1 <= rs1;
                r_addr2 <= rs2;
                w_addr <= rd;
            end
            else if (funct3 == 3'b100) begin
                //XOR
                alu_op <= 4'b0011;
                r_addr1 <= rs1;
                r_addr2 <= rs2;
                w_addr <= rd;
            end
            else if (funct3 == 3'b101 && op_value[30:30] == 0)
             begin
                //SRL
                alu_op <= 4'b1001;
                r_addr1 <= rs1;
                r_addr2 <= rs2;
                w_addr <= rd;
            end
            else if (funct3 == 3'b101 && op_value[30:30] == 1)
            begin
                //SRA
                alu_op <= 4'b0111;
                r_addr1 <= rs1;
                r_addr2 <= rs2;
                w_addr <= rd;
            end
            else if (funct == 110) begin
                //OR
                alu_op <= 4'b0010;
                r_addr1 <= rs1;
            end
        end
    end


endmodule
module 5_to_12_bit(in,out);
//5bitから12bitへ拡張する。
    input[4:0] in;
    output reg[11:0] out; 
    always @(in) begin
        if (in[4:4] == 1) begin
            out <= {6'b111111,in};
        end
        else begin
            out <= {6'b000000,in};
        end
    end
endmodule