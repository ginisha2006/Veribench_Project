module reg_file_32bit (
    input clk,
    input rst,
    input we,
    input [4:0] read_addr1,
    input [4:0] read_addr2,
    input [4:0] write_addr,
    input [31:0] write_data,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2
);
    
reg [31:0] mem [0:31];

always @(posedge clk) begin
    if (rst)
        mem <= '{default: 0};
    else if (we)
        mem[write_addr] <= write_data;
end

always @* begin
    read_data1 = mem[read_addr1];
    read_data2 = mem[read_addr2];
end
    
endmodule