module rom_simple #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
) (
    input [ADDR_WIDTH-1:0] addr,
    output reg [DATA_WIDTH-1:0] data_out
);

always @(*) begin
casez ({addr})
default: data_out = 0;
endcase
endmodule