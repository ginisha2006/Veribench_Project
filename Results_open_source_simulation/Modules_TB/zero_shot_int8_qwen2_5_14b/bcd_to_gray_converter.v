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

        // Test case 0: All zeros
        bcd <= 4'b0000;
        #10;
        
        // Test case 1: Incremental values
        for (int i = 0; i < 16; i++) begin
            bcd <= i;
            #10;
        end
        
        // Test case 2: Edge case - maximum value
        bcd <= 4'b1001; // Maximum BCD value
        #10;
        
        // Test case 3: Random values
        bcd <= 4'b0110; // 6 in BCD
        #10;
        bcd <= 4'b1000; // 8 in BCD
        #10;
        bcd <= 4'b1001; // 9 in BCD
        #10;
        
        // Test case 4: Invalid BCD values
        bcd <= 4'b1010; // A in binary, invalid BCD
        #10;
        bcd <= 4'b1011; // B in binary, invalid BCD
        #10;
        bcd <= 4'b1100; // C in binary, invalid BCD
        #10;
        bcd <= 4'b1101; // D in binary, invalid BCD
        #10;
        bcd <= 4'b1110; // E in binary, invalid BCD
        #10;
        bcd <= 4'b1111; // F in binary, invalid BCD
        #10;
        
        $finish;
    end
    
    always @(posedge gray) begin
        $display("BCD=%b -> Gray=%b", bcd, gray);
    end
endmodule