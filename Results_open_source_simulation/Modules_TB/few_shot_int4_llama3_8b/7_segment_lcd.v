module tb_seven_seg_display;
// Parameter
parameter DATA_WIDTH = 4;  // Default data width is 4 bits
// Input
reg [DATA_WIDTH-1:0] data;
// Output
wire [6:0] seg;
// Instantiate the Seven Segment Display
seven_seg_display #(.DATA_WIDTH(DATA_WIDTH)) uut (
   .data(data),
   .seg(seg)
);
initial begin
    // Display the header for the output
    $display("Time	data	seg");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b", $time, data, seg);
    // Test each digit from 0 to F
    data = 4'h0; #10;
    data = 4'h1; #10;
    data = 4'h2; #10;
    data = 4'h3; #10;
    data = 4'h4; #10;
    data = 4'h5; #10;
    data = 4'h6; #10;
    data = 4'h7; #10;
    data = 4'h8; #10;
    data = 4'h9; #10;
    data = 4'hA; #10;
    data = 4'hB; #10;
    data = 4'hC; #10;
    data = 4'hD; #10;
    data = 4'hE; #10;
    data = 4'hF; #10;
    // Test invalid data
    data = 4'h10; #10;
    // Finish the simulation
    $finish;
end
endmodule