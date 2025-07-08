module tb_shift_8x64_taps();

reg clk;
reg shift;
wire [7:0] sr_in;
wire [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

integer i;

initial begin
    #10; // delay for setup
    clk = 0;
    shift = 0;
    sr_in = 8'h12; // initial input value
    
    repeat(5) begin
        #20; // clock period
        clk = ~clk; // toggle clock
    end
    
    #10; // delay after clock toggling
    
    shift = 1; // trigger shift operation
    repeat(3) begin
        #20; // clock period
        clk = ~clk; // toggle clock
    end
    
    shift = 0; // reset shift operation
    
    #10; // delay after shift operation
    
    $monitor($time, "sr_in: %h", sr_in,
             "sr_tap_one: %h", sr_tap_one,
             "sr_tap_two: %h", sr_tap_two,
             "sr_tap_three: %h", sr_tap_three,
             "sr_out: %h", sr_out);
    
    $display("Simulation complete");
end

endmodule