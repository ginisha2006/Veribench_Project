module shift_8x64_taps (
    input clk,
    input shift,
    input [7:0] sr_in,
    output reg [7:0] sr_tap_one,
    output reg [7:0] sr_tap_two,
    output reg [7:0] sr_tap_three,
    output reg [7:0] sr_out
);
    reg [7:0] shift_reg [0:63];

    always @(posedge clk) begin
        if (shift)
            shift_reg[0] <= sr_in;

        for (int i = 0; i < 63; i++)
            shift_reg[i+1] <= shift_reg[i];
        
        sr_tap_one <= shift_reg[15];
        sr_tap_two <= shift_reg[31];
        sr_tap_three <= shift_reg[47];
        sr_out <= shift_reg[63];
    end
endmodule