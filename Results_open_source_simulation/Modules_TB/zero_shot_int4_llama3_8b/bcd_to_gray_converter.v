module bcd_to_gray_tb;
    localparam BCD_WIDTH = 4;
    localparam GRAY_WIDTH = 4;

    reg [BCD_WIDTH-1:0] bcd;
    wire [GRAY_WIDTH-1:0] gray;

    initial begin
        $monitor($time, "bcd=%b, gray=%b", bcd, gray);

        // Test all possible BCD inputs
        for (int i = 0; i < (1 << BCD_WIDTH); i++) begin
            bcd = i;
            #10;
        end

        // Test edge cases
        bcd = 8'h0; // All zeros
        #10;
        bcd = 8'hF; // All ones
        #10;
        bcd = 8'h9; // Most significant bit is one
        #10;
        bcd = 8'hA; // Most significant bit is zero
        #10;

        // Test corner cases
        bcd = 8'h1; // Only most significant bit is one
        #10;
        bcd = 8'h2; // Only second most significant bit is one
        #10;
        bcd = 8'h3; // Only third most significant bit is one
        #10;
        bcd = 8'hC; // Only fourth most significant bit is one
        #10;

        // Test invalid inputs
        bcd = 8'x; // Invalid value
        #10;
        bcd = 8'hG; // Invalid value
        #10;
    end
endmodule