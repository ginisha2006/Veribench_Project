module tb_shift_8x64_taps();
    reg clk, shift;
    reg [7:0] sr_in;
    wire [7:0] sr_out, sr_tap_one, sr_tap_two, sr_tap_three;
    
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
        
        #20;
        shift = 1;
        
        repeat(64) begin
            if (sr_in != 8'haa) sr_in = {sr_in[6:0], 1'b0};
            else sr_in = 8'hBB;
            
            #10;
        end
        
        #20;
        $finish;
    end
    
    initial begin
        $monitor($time, " ns: clk=%b, shift=%b, sr_in=%h, sr_out=%h, sr_tap_one=%h, sr_tap_two=%h, sr_tap_three=%h", clk, shift, sr_in, sr_out, sr_tap_one, sr_tap_two, sr_tap_three);
    end
endmodule