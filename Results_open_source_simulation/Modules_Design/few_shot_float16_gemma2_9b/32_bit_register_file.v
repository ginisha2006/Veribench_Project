module reg_file_32bit (
    input clk,
    input rst,
    input we,
    input [4:0] read_addr1,
    input [4:0] read_addr2,
    input [4:0] write_addr,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);

    reg [31:0] regs [0:31];

    always @(posedge clk) begin
        if (rst) begin
            for (int i = 0; i < 32; i++) begin
                regs[i] <= 32'b0;
            end
        end else if (we) begin
            regs[write_addr] <= write_data;
        end
    end

    assign read_data1 = regs[read_addr1];
    assign read_data2 = regs[read_addr2];

endmodule