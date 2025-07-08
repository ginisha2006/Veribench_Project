module tb_seven_seg_display();
    // Clock and reset signals
    reg clk;
    reg rst;

    // Data input
    reg [3:0] data_in;

    // Seven segment display output
    wire [6:0] seg_out;

    // Instantiate the DUT
    seven_seg_display #(
       .DATA_WIDTH(4)
    ) dut (
       .data(data_in),
       .seg(seg_out)
    );

    initial begin
        // Initialize clock and reset
        clk = 0;
        rst = 1;

        #10 rst = 0;

        // Apply random data inputs
        for (int i = 0; i < 16; i++) begin
            data_in = $random();
            #20;
        end

        // Test specific cases
        data_in = 4'h0;
        #10;
        $monitor($time, "Data: %b, Segments: %b", data_in, seg_out);

        data_in = 4'hF;
        #10;
        $monitor($time, "Data: %b, Segments: %b", data_in, seg_out);

        data_in = 4'hA;
        #10;
        $monitor($time, "Data: %b, Segments: %b", data_in, seg_out);

        // Stop the simulation
        #100 $stop;
    end

    always #5 clk = ~clk;

endmodule