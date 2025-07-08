module rom_simple #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
)(
    input [ADDR_WIDTH-1:0] addr,
    output reg [DATA_WIDTH-1:0] data_out
);

reg [DATA_WIDTH-1:0] mem [0:(2**ADDR_WIDTH)-1];

always @(*) begin
    case(addr)
        0: data_out <= 8'b0000_0001;
        1: data_out <= 8'b0000_0010;
        2: data_out <= 8'b0000_0100;
        3: data_out <= 8'b0000_1000;
        default: data_out <= 8'b0;
    endcase
end

endmodule