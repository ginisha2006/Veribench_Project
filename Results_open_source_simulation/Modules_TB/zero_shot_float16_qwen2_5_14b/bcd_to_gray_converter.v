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

        // Test case 0000 -> 0000
        bcd <= 4'b0000;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        // Test case 0001 -> 0001
        bcd <= 4'b0001;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        // Test case 0010 -> 0011
        bcd <= 4'b0010;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        // Test case 0011 -> 0010
        bcd <= 4'b0011;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        // Test case 0100 -> 0110
        bcd <= 4'b0100;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        // Test case 0101 -> 0111
        bcd <= 4'b0101;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        // Test case 0110 -> 0101
        bcd <= 4'b0110;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        // Test case 0111 -> 0100
        bcd <= 4'b0111;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        // Test case 1000 -> 1100
        bcd <= 4'b1000;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        // Test case 1001 -> 1101
        bcd <= 4'b1001;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        // Edge case: Maximum value 1001 -> 1100
        bcd <= 4'b1001;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        // Corner case: Minimum value 0000 -> 0000
        bcd <= 4'b0000;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        // Random values
        bcd <= 4'b1010;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        bcd <= 4'b1011;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        bcd <= 4'b1100;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        bcd <= 4'b1101;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        bcd <= 4'b1110;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        bcd <= 4'b1111;
        #10;
        $display("BCD: %b, Gray: %b", bcd, gray);

        #10;
        $finish;
    end
endmodule