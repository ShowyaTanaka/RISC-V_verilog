/*
Boolの仕様(しかしここでは0,1で表現)を先に示しておく。
is_write:trueでレジスタに書き込み
alusrc:trueで即値,falseでレジスタ
regwritesrc:trueでALU,falseでメモリ
is_access_memory:trueでアクセス
is_write_memory:trueでメモリに書き込み
load_from_pc:trueでPC->ALUin1にする.
alu_to_pc:trueでALU->PC(このとき,pcsrcと接続することでaluとの接続を実現)
Bool以外
pcsrc:trueで即値,0で+4(これはBoolとは違うが一旦Bool)
pc_full_input:trueでpcの値をpcsrcから入力された値に変更
*/
module decoder(read_reg1, read_reg2, write_reg, is_write, alu_op, alusrc, pcsrc, regwritesrc, is_access_memory, is_write_memory, op_value, output2_value, load_from_pc, alu_to_pc);
    output reg is_write, alusrc, pcsrc, regwritesrc, is_access_memory, is_write_memory, load_from_pc, alu_to_pc, pc_full_input;
    //write_regについては指定したアドレスに直接書き込むためのHWを作成(?)この時レジスタの変更だけでは必ずしも期待した値とは限らないので最終的にはMUXで切り替えた入力を検知して書き込む。
    //ALUに直通する配線。U-Typeだと使う。MUXでALU_input0の切り替え。この時MUX側はdecoderを優先する仕様にするべきと考えている。
    output[19:0] output_value;
    output[31:0] output2_value;
    reg [4:0] read_reg1_reg, read_reg2_reg, write_reg_reg, alu_op_reg;
    inout [4:0] read_reg1, read_reg2, write_reg;
    input [31:0] op_value;
    output[3:0] alu_op;
    reg[19:0] output_value_reg;
    reg[31:0] output2_value_reg;
    assign read_reg1 = read_reg1_reg;
    assign read_reg2 = read_reg2_reg;
    assign write_reg = write_reg_reg;
    assign output_value = output_value_reg;
    assign output2_value = output2_value_reg;
    assign alu_op = alu_op_reg;
    //本来不要なレジスタであるが可読性を上げるために一旦作成しておく。
    reg [6:0] op;
    reg [2:0] funct3;

    //即値を判断しデコード
    always @* begin
        op <= op_value[6:0];
        if (op == 7'b0110111) begin
            //U-Type
            write_reg_reg <= op_value[11:7];
            output_value_reg <= op_value[31:12];
            output2_value_reg <= 7'b0;
            alu_op_reg <= 8;
            pcsrc <= 0;
        end
        else if (op == 7'b0010111) begin
            //auipc
            load_from_pc = 1;
            write_reg_reg <= op_value[11:7];
            output_value_reg <= op_value[31:12];
            alu_op_reg <= 8;
            load_from_pc = 0;
            pcsrc = 0;
        end
        else if (op == 7'b1101111) begin
            //jal
            //J-Type(same as U-Type)
            //PCから値を読み取り,レジスタに格納する(2クロック使わないと無理か...?)
            write_reg_reg <= op_value[11:7];
            output_value_reg <= 1;
            load_from_pc <= 1;
            alu_op_reg <= 2;
            pcsrc = op_value[31:12];
        end
        else if (op == 7'b1100111) begin
            //jalr
            //I-type
            write_reg_reg <= op_value[11:7];
            output_value_reg <= 1;
            load_from_pc <= 1;
            output_value_reg <= op_value[19:15];
            output2_value_reg <= op_value[31:20];
            pc_full_input = 1;
            alu_to_pc = 1;
            alu_op_reg = 2;
            alu_to_pc = 0;
        end
        else if (op == 7'b1100011) begin
            //branchは
        end
    end
endmodule