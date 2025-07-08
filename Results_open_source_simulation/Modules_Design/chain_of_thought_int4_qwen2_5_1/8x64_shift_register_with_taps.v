module shift_8x64_taps (
    input clk,
    input shift,
    input [7:0] sr_in,
    output reg [7:0] sr_tap_one,
    output reg [7:0] sr_tap_two,
    output reg [7:0] sr_tap_three,
    output reg [7:0] sr_out
);
    reg [511:0] shift_reg;

    always @(posedge clk) begin
        if (shift)
            shift_reg = {shift_reg[503:0], sr_in};
        else
            shift_reg <= shift_reg;
    end

    assign sr_tap_one = shift_reg[15:8];
    assign sr_tap_two = shift_reg[31:24];
    assign sr_tap_three = shift_reg[47:40];
    assign sr_out = shift_reg[511:504];
endmodule