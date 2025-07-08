module shift_8x64_taps_tb();

reg clk;
reg shift;
wire [7:0] sr_in;
wire [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

integer i;

initial begin
    #10 clk = 0;
    forever #(5) clk = ~clk;
end

initial begin
    shift = 0;
    sr_in = 8'h12;
    for (i = 0; i < 100; i++) begin
        @(posedge clk);
        if (i == 20) shift = 1;
        if (i > 50 && i % 10 == 0) sr_in = i % 16;
    end
    #100 $finish;
end

$monitor($time, "sr_in: %h, sr_tap_one: %h, sr_tap_two: %h, sr_tap_three: %h, sr_out: %h", sr_in, sr_tap_one, sr_tap_two, sr_tap_three, sr_out);

endmodule