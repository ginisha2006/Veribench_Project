module tb_seven_seg_display;
// Parameters
parameter DATA_WIDTH = 4;
// Inputs
reg [DATA_WIDTH-1:0] data;
// Outputs
wire [6:0] seg;
// Instantiate the Seven Segment Display
seven_seg_display #(.DATA_WIDTH(DATA_WIDTH)) uut (
    .data(data),
    .seg(seg)
);
initial begin
    // Display the header for the output
    $display("Time	data	seg[6]	seg[5]	seg[4]	seg[3]	seg[2]	seg[1]	seg[0]");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b	%b	%b", $time, data, seg[6], seg[5], seg[4], seg[3], seg[2], seg[1], seg[0]);
    // Apply various stimuli to the input 'data'
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
    data = 4'ha; #10; // Invalid value
    // Finish the simulation
    $finish;
end
endmodule