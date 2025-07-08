module ram_separate_io #(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 8)
    (
        input wire clk,
        input wire we,
        input wire [ADDR_WIDTH-1:0] addr,
        input wire [DATA_WIDTH-1:0] data_in,
        output reg [DATA_WIDTH-1:0] data_out
    );
    reg [2**ADDR_WIDTH-1:0][DATA_WIDTH-1:0] mem;

    always @(posedge clk) begin
        if (we) mem[addr] <= data_in;
        data_out <= mem[addr];
    end
endmodule