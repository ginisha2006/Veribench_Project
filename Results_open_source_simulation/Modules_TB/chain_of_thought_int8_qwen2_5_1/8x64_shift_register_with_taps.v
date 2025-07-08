module tb_shift_8x64_taps;
    reg clk;
    reg shift;
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
        #10;
        shift = 1;
        for (int i=0; i<64; i=i+1) begin
            if (i % 16 == 0 && i != 0) sr_in = {sr_in[6:0], sr_in[7]};
            else sr_in = sr_in + 1;
            #10;
        end
        #10;
        $finish;
    end

    initial begin
        $monitor($time,"ns: clk=%b, shift=%b, sr_in=%h, sr_out=%h, sr_tap_one=%h, sr_tap_two=%h, sr_tap_three=%h", clk, shift, sr_in, sr_out, sr_tap_one, sr_tap_two, sr_tap_three);
    end
endmodule