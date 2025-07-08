module ram_separate_io #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
)(
    input clk,
    input we,
    input [ADDR_WIDTH-1:0] addr,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out
);
    
reg [DATA_WIDTH-1:0] mem [0:(2**ADDR_WIDTH)-1];

always @(posedge clk)
begin
    if(we)
        mem[addr] <= data_in;
end

assign data_out = mem[addr];
    
endmodule