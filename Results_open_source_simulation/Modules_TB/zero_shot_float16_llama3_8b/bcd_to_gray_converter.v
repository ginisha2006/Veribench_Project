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
        bcd = 8'h0;
        #10;
        bcd = 8'h9;
        #10;
        bcd = 8'ha;
        #10;
        bcd = 8'hf;

        #100 $finish;
    end

    bcd_to_gray uut (
       .bcd(bcd),
       .gray(gray)
    );
endmodule