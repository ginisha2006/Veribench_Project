module tb_bcd_to_gray;
// Parameters
parameter BCD_WIDTH = 4;
parameter GRAY_WIDTH = 4;
// Inputs
reg [BCD_WIDTH-1:0] bcd;
// Outputs
wire [GRAY_WIDTH-1:0] gray;
// Instantiate the BCD to Gray Converter
bcd_to_gray #(.BCD_WIDTH(BCD_WIDTH),.GRAY_WIDTH(GRAY_WIDTH)) uut (
   .bcd(bcd), 
   .gray(gray)
);
initial begin
    // Display the header for the output
    $display("Time	bcd		gray");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b", $time, bcd, gray);
    // Test all possible BCD values
    for (int i = 0; i < (1 << BCD_WIDTH); i++) begin
        bcd = i; #10;
    end
    // Finish the simulation
    $finish;
end
endmodule