module tb_bcd_to_gray;
// Parameters
parameter BCD_WIDTH = 4;
parameter GRAY_WIDTH = 4;

// Inputs
reg [BCD_WIDTH-1:0] bcd;
// Outputs
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
    
    // Test Cases
    bcd = 4'd0; #10;
    bcd = 4'd1; #10;
    bcd = 4'd9; #10;
    bcd = 4'd10; #10;
    bcd = 4'd15; #10;
    bcd = 4'd16; #10;
    bcd = 4'd99; #10;
    bcd = 4'd100; #10;
    bcd = 4'd123; #10;
    bcd = 4'd255; #10;
    
    // Finish the simulation
    $finish;
end
endmodule