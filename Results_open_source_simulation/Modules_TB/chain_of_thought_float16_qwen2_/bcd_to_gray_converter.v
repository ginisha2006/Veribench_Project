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

        // Stimulus for all possible BCD inputs
        #10 bcd = 4'b0000; $display("BCD=%b, Gray=%b", bcd, gray);
        #10 bcd = 4'b0001; $display("BCD=%b, Gray=%b", bcd, gray);
        #10 bcd = 4'b0010; $display("BCD=%b, Gray=%b", bcd, gray);
        #10 bcd = 4'b0011; $display("BCD=%b, Gray=%b", bcd, gray);
        #10 bcd = 4'b0100; $display("BCD=%b, Gray=%b", bcd, gray);
        #10 bcd = 4'b0101; $display("BCD=%b, Gray=%b", bcd, gray);
        #10 bcd = 4'b0110; $display("BCD=%b, Gray=%b", bcd, gray);
        #10 bcd = 4'b0111; $display("BCD=%b, Gray=%b", bcd, gray);
        #10 bcd = 4'b1000; $display("BCD=%b, Gray=%b", bcd, gray);
        #10 bcd = 4'b1001; $display("BCD=%b, Gray=%b", bcd, gray);

        // Edge case - invalid BCD values beyond 9
        #10 bcd = 4'b1010; $display("BCD=%b, Gray=%b", bcd, gray);
        #10 bcd = 4'b1011; $display("BCD=%b, Gray=%b", bcd, gray);
        #10 bcd = 4'b1100; $display("BCD=%b, Gray=%b", bcd, gray);
        #10 bcd = 4'b1101; $display("BCD=%b, Gray=%b", bcd, gray);
        #10 bcd = 4'b1110; $display("BCD=%b, Gray=%b", bcd, gray);
        #10 bcd = 4'b1111; $display("BCD=%b, Gray=%b", bcd, gray);

        #10 $finish;
    end
endmodule