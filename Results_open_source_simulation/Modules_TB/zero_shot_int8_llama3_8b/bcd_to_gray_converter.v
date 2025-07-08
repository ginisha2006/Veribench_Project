module tb_bcd_to_gray;
    localparam BCD_WIDTH = 4;
    localparam GRAY_WIDTH = 4;

    reg [BCD_WIDTH-1:0] bcd;
    wire [GRAY_WIDTH-1:0] gray;

    bcd_to_gray dut (
       .bcd(bcd),
       .gray(gray)
    );

    initial begin
        $monitor($time, "bcd=%b, gray=%b", bcd, gray);

        // Test case 1: All zeros
        bcd <= 0;
        #10;
        repeat(2) @(posedge clock);
        $display("Test case 1: All zeros - PASS");

        // Test case 2: All ones
        bcd <= 15;
        #10;
        repeat(2) @(posedge clock);
        $display("Test case 2: All ones - PASS");

        // Test case 3: Mixed bits
        bcd <= 5; // 101 in binary
        #10;
        repeat(2) @(posedge clock);
        $display("Test case 3: Mixed bits - PASS");

        // Test case 4: Edge case - Most significant bit set
        bcd <= 14; // 1110 in binary
        #10;
        repeat(2) @(posedge clock);
        $display("Test case 4: Edge case - Most significant bit set - PASS");

        // Test case 5: Corner case - Least significant bit set
        bcd <= 1; // 0001 in binary
        #10;
        repeat(2) @(posedge clock);
        $display("Test case 5: Corner case - Least significant bit set - PASS");
    end

    always #10 clock = ~clock;
endmodule