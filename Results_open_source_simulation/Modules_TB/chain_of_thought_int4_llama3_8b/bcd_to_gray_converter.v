module bcd_to_gray_tb;
    localparam BCD_WIDTH = 4;
    localparam GRAY_WIDTH = 4;

    reg [BCD_WIDTH-1:0] bcd;
    wire [GRAY_WIDTH-1:0] gray;

    initial begin
        $monitor($time, "bcd=%b, gray=%b", bcd, gray);

        // Test all possible combinations of BCD inputs
        for (int i = 0; i < (1 << BCD_WIDTH); i++) begin
            bcd = i;
            #10;
        end

        // Test edge cases
        bcd = 8'h0; // All zeros
        #10;
        bcd = 8'hF; // All ones
        #10;
        bcd = 8'h3; // Most significant bit set
        #10;
        bcd = 8'hC; // Middle bits set
        #10;
        bcd = 8'h9; // Least significant bit set
        #10;
        bcd = 8'hE; // Mixed bits set
        #10;

        // Test corner cases
        bcd = 8'h1; // Only most significant bit set
        #10;
        bcd = 8'h5; // Only middle bits set
        #10;
        bcd = 8'h7; // Only least significant bit set
        #10;
        bcd = 8'hA; // Only two bits set
        #10;
        bcd = 8'hB; // Three bits set
        #10;
        bcd = 8'hF; // Four bits set
        #10;
    end
endmodule