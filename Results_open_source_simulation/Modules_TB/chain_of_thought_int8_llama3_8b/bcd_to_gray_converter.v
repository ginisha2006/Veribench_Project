module tb_bcd_to_gray;
    // Parameters
    localparam BCD_WIDTH = 4;
    localparam GRAY_WIDTH = 4;

    // Signals
    reg [BCD_WIDTH-1:0] bcd_in;
    wire [GRAY_WIDTH-1:0] gray_out;

    // Instantiate DUT
    bcd_to_gray dut (
       .bcd(bcd_in),
       .gray(gray_out)
    );

    initial begin
        // Initialize inputs
        bcd_in = 0;

        // Monitor outputs
        $monitor($time, "bcd_in=%b, gray_out=%b", bcd_in, gray_out);

        // Stimulus
        for (int i = 0; i < 16; i++) begin
            bcd_in = i;
            #10;
        end

        // Corner case: all ones
        bcd_in = 15;
        #10;

        // Corner case: all zeros
        bcd_in = 0;
        #10;

        // Edge case: transition from max to min
        for (int i = 15; i >= 0; i--) begin
            bcd_in = i;
            #10;
        end

        // Edge case: transition from min to max
        for (int i = 0; i <= 15; i++) begin
            bcd_in = i;
            #10;
        end
    end
endmodule