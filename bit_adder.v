module 12_to_32(in,out);
    input[11:0] in;
    output reg[31:0] out;
    always @(in) begin
        if (in[11:11] == 1) begin
            out <= {20'b11111111111111111111,in};
        end
        else begin
            out <= {20'b00000000000000000000,in};
        end
    end
endmodule