module rom_simple #(parameter DATA_WIDTH=8, ADDR_WIDTH=8) (
    input [ADDR_WIDTH-1:0] addr,
    output [DATA_WIDTH-1:0] data_out
);
    localparam ROM_SIZE = (1 << ADDR_WIDTH);
    reg [DATA_WIDTH-1:0] rom_memory [ROM_SIZE-1:0];

    initial begin
        $readmemh("rom_data.txt", rom_memory, 0, ROM_SIZE);
    end

    always @(*) begin
        data_out <= rom_memory[addr];
    end
endmodule