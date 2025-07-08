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
    reg [31:0] regs [0:31];

    always @(posedge clk)
        if (rst)
            foreach(regs[i])
                regs[i] <= 32'b0;
        else if (we)
            regs[write_addr] <= write_data;

    always @*
        begin
            read_data1 = regs[read_addr1];
            read_data2 = regs[read_addr2];
        end
endmodule