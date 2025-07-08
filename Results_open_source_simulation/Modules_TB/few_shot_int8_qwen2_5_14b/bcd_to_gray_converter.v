module tb_bcd_to_gray;
// Parameters
parameter BCD_WIDTH = 4;
parameter GRAY_WIDTH = 4;

// Inputs
reg [BCD_WIDTH-1:0] bcd;
// Outputs
wire [GRAY_WIDTH-1:0] gray;

// Instantiate the BCD to Gray converter
bcd_to_gray #(.BCD_WIDTH(BCD_WIDTH), .GRAY_WIDTH(GRAY_WIDTH)) uut (
    .bcd(bcd),
    .gray(gray)
);

initial begin
    // Display the header for the output
    $display("Time	bcd	gray");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b", $time, bcd, gray);
    
    // Test various BCD values from 0 to 9
    bcd = 4'b0000; #10;
    bcd = 4'b0001; #10;
    bcd = 4'b0010; #10;
    bcd = 4'b0011; #10;
    bcd = 4'b0100; #10;
    bcd = 4'b0101; #10;
    bcd = 4'b0110; #10;
    bcd = 4'b0111; #10;
    bcd = 4'b1000; #10;
    bcd = 4'b1001; #10;
    
    // Additional edge case tests
    bcd = 4'b1010; #10; // Invalid BCD value
    bcd = 4'b1011; #10; // Invalid BCD value
    bcd = 4'b1100; #10; // Invalid BCD value
    bcd = 4'b1101; #10; // Invalid BCD value
    bcd = 4'b1110; #10; // Invalid BCD value
    bcd = 4'b1111; #10; // Invalid BCD value
    
    // Finish the simulation
    $finish;
end
endmodule