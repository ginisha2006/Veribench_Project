module rom_simple #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
)(
    input logic [ADDR_WIDTH-1:0] addr,
    output logic [DATA_WIDTH-1:0] data_out
);
    
logic [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH-1:0];

always_comb begin
    data_out = mem[addr];
end

endmodule