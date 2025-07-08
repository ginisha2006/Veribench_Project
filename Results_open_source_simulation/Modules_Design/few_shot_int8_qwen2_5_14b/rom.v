module rom_simple #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
)(
    input [ADDR_WIDTH-1:0] addr,
    output reg [DATA_WIDTH-1:0] data_out
);

reg [DATA_WIDTH-1:0] memory [2**ADDR_WIDTH-1:0];

initial begin
    // Initialization of memory content can be added here
    // Example:
    // memory[0] = 8'b10101010;
    // ...
end

always @(*) begin
    data_out = memory[addr];
end

endmodule