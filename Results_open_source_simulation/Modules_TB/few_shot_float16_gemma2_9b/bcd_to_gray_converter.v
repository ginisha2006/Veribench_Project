module tb_bcd_to_gray;
// Parameter
parameter BCD_WIDTH = 4;
parameter GRAY_WIDTH = 4;
// Input
reg [BCD_WIDTH-1:0] bcd;
// Output
wire [GRAY_WIDTH-1:0] gray;
// Instantiate the BCD to Gray Converter
bcd_to_gray #(
    .BCD_WIDTH(BCD_WIDTH),
    .GRAY_WIDTH(GRAY_WIDTH)
) uut (
    .bcd(bcd),
    .gray(gray)
);
initial begin
    // Display the header for the output
    $display("Time	bcd	gray");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b", $time, bcd, gray);
    // Test all possible BCD input combinations
    bcd = 0; #10;
    bcd = 1; #10;
    bcd = 2; #10;
    bcd = 3; #10;
    bcd = 4; #10;
    bcd = 5; #10;
    bcd = 6; #10;
    bcd = 7; #10;
    bcd = 8; #10;
    bcd = 9; #10;
    // Finish the simulation
    $finish;
end
endmodule