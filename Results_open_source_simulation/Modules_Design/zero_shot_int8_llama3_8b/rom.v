module rom_simple #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 8)
(
    input [ADDR_WIDTH-1:0] addr,
    output reg [DATA_WIDTH-1:0] data_out
);

reg [DATA_WIDTH-1:0] rom [2**ADDR_WIDTH-1:0];

initial begin
    for (int i = 0; i < 2**ADDR_WIDTH; i++) begin
        rom[i] = i;
    end
end

assign data_out = rom[addr];

endmodule