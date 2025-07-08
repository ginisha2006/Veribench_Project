module rom_simple #(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 8)
    (input [ADDR_WIDTH-1:0] addr,
     output reg [DATA_WIDTH-1:0] data_out);

reg [DATA_WIDTH-1:0] rom [2**ADDR_WIDTH-1:0];

initial
    begin
        for (int i = 0; i < 2**ADDR_WIDTH; i++)
            rom[i] = $unsigned($random % (1 << DATA_WIDTH));
    end

always @(posedge clock)
    if (addr == 0)
        data_out <= rom[0];
    else
        data_out <= rom[addr];

endmodule