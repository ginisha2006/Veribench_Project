module tb_shift_8x64_taps;
    reg clk, shift;
    wire [7:0] sr_in, sr_out, sr_tap_one, sr_tap_two, sr_tap_three;
    
    shift_8x64_taps uut (
        .clk(clk),
        .shift(shift),
        .sr_in(sr_in),
        .sr_out(sr_out),
        .sr_tap_one(sr_tap_one),
        .sr_tap_two(sr_tap_two),
        .sr_tap_three(sr_tap_three)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        shift = 0;
        sr_in = 8'hAA;
        
        #20 shift = 1;
        #20 sr_in = 8'hBB;
        #20 sr_in = 8'hCC;
        #20 sr_in = 8'hDD;
        #20 sr_in = 8'hEE;
        #20 sr_in = 8'hFF;
        
        #20 shift = 0;
        #20 sr_in = 8'h00;
        
        #20 $finish;
    end
    
    initial begin
        $monitor($time, " ns: clk=%b, shift=%b, sr_in=%h, sr_out=%h, sr_tap_one=%h, sr_tap_two=%h, sr_tap_three=%h", clk, shift, sr_in, sr_out, sr_tap_one, sr_tap_two, sr_tap_three);
    end
endmodule