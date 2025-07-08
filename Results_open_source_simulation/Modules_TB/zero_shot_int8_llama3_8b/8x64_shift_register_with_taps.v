module shift_8x64_taps_tb();

reg clk;
reg shift;
wire [7:0] sr_in;
wire [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

integer i;

initial begin
    #100 clk = 1'b0;
    forever #(5) clk = ~clk;

    for (i = 0; i < 4; i++) begin
        #20 shift = 1'b0;
        #10 shift = 1'b1;
        #40 shift = 1'b0;
    end

    #200 $display("Test complete");
    $finish;
end

initial begin
    sr_in = 8'h12;
end

always @(posedge clk)
begin
    $monitor($time, "clk=%b, shift=%b, sr_in=%h", clk, shift, sr_in);
    $monitor($time, "sr_tap_one=%h, sr_tap_two=%h, sr_tap_three=%h, sr_out=%h", sr_tap_one, sr_tap_two, sr_tap_three, sr_out);
end

endmodule