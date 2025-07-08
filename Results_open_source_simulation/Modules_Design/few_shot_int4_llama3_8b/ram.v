module ram_simple #(parameter DATA_WIDTH=8, ADDR_WIDTH=8) (
    input clk,
    input we,
    input [ADDR_WIDTH-1:0] addr,
    input [DATA_WIDTH-1:0] data_in,
    output [DATA_WIDTH-1:0] data_out
);
    reg [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH-1:0];
    
    always @(posedge clk)
        if (we) mem[addr] <= data_in;
    
    assign data_out = mem[addr];
endmodule