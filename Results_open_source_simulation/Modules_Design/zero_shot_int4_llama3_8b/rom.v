module rom_simple #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
) (
    input [ADDR_WIDTH-1:0] addr,
    output reg [DATA_WIDTH-1:0] data_out
);

reg [DATA_WIDTH-1:0] rom_memory [2**ADDR_WIDTH-1:0];

initial begin
    for (int i = 0; i < 2**ADDR_WIDTH; i++) begin
        rom_memory[i] = $signed($fread("rom_data.txt", i));
    end
end

always @ (posedge clk)
begin
    if (addr!= 'bx) begin
        data_out <= rom_memory[addr];
    end
end

endmodule