module shift_8x64_taps (
    input clk,
    input shift,
    input [7:0] sr_in,
    output [7:0] sr_tap_one,
    output [7:0] sr_tap_two,
    output [7:0] sr_tap_three,
    output [7:0] sr_out
);
    reg [63:0] sr_reg;

    always @(posedge clk)
        if (shift)
            sr_reg <= {sr_reg[56:0], sr_in};
        else
            sr_reg <= sr_reg;

    assign sr_tap_one = sr_reg[15:8];
    assign sr_tap_two = sr_reg[31:24];
    assign sr_tap_three = sr_reg[47:40];
    assign sr_out = sr_reg[7:0];
endmodule