module shift_8x64_taps (
    input clk,
    input shift,
    input [7:0] sr_in,
    output [7:0] sr_tap_one,
    output [7:0] sr_tap_two,
    output [7:0] sr_tap_three,
    output [7:0] sr_out
);

    reg [63:0] shift_reg;

    always @(posedge clk) begin
        if (shift) begin
            shift_reg <= {sr_in, shift_reg[63:8]};
        end else begin
            shift_reg <= shift_reg << 1;
        end
    end

    assign sr_tap_one = shift_reg[15:8];
    assign sr_tap_two = shift_reg[31:24];
    assign sr_tap_three = shift_reg[47:40];
    assign sr_out = shift_reg[63:56];

endmodule