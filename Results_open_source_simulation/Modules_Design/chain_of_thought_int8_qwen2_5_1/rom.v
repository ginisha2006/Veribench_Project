module rom_simple #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
)(
    input [ADDR_WIDTH-1:0] addr,
    output reg [DATA_WIDTH-1:0] data_out
);

reg [DATA_WIDTH-1:0] memory [2**ADDR_WIDTH-1:0];

initial begin
    // Memory initialization can be added here if needed
end

always @* begin
    data_out = memory[addr];
end

endmodule