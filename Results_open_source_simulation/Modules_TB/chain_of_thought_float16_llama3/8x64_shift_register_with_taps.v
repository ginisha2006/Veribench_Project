module shift_8x64_taps_tb();

reg clk;
reg shift;
wire [7:0] sr_in;
wire [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

integer i;

initial begin
    #10 clk = 0;
    forever #(5) clk = ~clk;

    #20 shift = 0;
    for (i = 0; i < 100; i++) begin
        #10 sr_in = i % 256;
        #10 shift = 0;
        #10 shift = 1;
    end
    #10 shift = 0;
    #100 $finish;
end

initial begin
    $monitor($time, "sr_in: %h, sr_tap_one: %h, sr_tap_two: %h, sr_tap_three: %h, sr_out: %h", sr_in, sr_tap_one, sr_tap_two, sr_tap_three, sr_out);
end

shift_8x64_taps uut (
   .clk(clk),
   .shift(shift),
   .sr_in(sr_in),
   .sr_out(sr_out),
   .sr_tap_one(sr_tap_one),
   .sr_tap_two(sr_tap_two),
   .sr_tap_three(sr_tap_three)
);

endmodule