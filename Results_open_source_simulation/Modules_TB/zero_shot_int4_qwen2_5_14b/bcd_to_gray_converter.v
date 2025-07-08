module tb_bcd_to_gray;
    reg [3:0] bcd;
    wire [3:0] gray;

    bcd_to_gray #(.BCD_WIDTH(4), .GRAY_WIDTH(4)) uut (
        .bcd(bcd),
        .gray(gray)
    );

    initial begin
        $dumpfile("tb_bcd_to_gray.vcd");
        $dumpvars(0, tb_bcd_to_gray);

        // Test case 0000
        bcd <= 4'b0000;
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        // Test case 0001
        bcd <= 4'b0001;
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        // Test case 0010
        bcd <= 4'b0010;
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        // Test case 0011
        bcd <= 4'b0011;
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        // Test case 0100
        bcd <= 4'b0100;
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        // Test case 0101
        bcd <= 4'b0101;
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        // Test case 0110
        bcd <= 4'b0110;
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        // Test case 0111
        bcd <= 4'b0111;
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        // Test case 1000
        bcd <= 4'b1000;
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        // Test case 1001
        bcd <= 4'b1001;
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        // Edge case: Maximum value
        bcd <= 4'b1001; // 9 in BCD
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        // Corner case: Minimum value
        bcd <= 4'b0000; // 0 in BCD
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        // Random values
        bcd <= 4'b1010;
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        bcd <= 4'b1100;
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        bcd <= 4'b1111;
        #10;
        $monitor($time, " ns: bcd=%b, gray=%b", bcd, gray);

        #100;
        $finish;
    end
endmodule