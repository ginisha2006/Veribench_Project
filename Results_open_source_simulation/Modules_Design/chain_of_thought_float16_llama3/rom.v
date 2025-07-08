module rom_simple #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 8)
    (input [ADDR_WIDTH-1:0] addr,
     output reg [DATA_WIDTH-1:0] data_out);

    reg [DATA_WIDTH-1:0] memory [2**ADDR_WIDTH-1:0];

    initial begin
        for (int i = 0; i < 2**ADDR_WIDTH; i++) 
            memory[i] = $unsigned($random % (1 << DATA_WIDTH));
    end

    always @(posedge clock) begin
        if (addr!= 0) begin
            data_out <= memory[addr];
        end
    end

endmodule