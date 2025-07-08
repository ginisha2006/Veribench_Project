module seven_seg_display_tb;

parameter DATA_WIDTH = 4;

reg [DATA_WIDTH-1:0] data;
wire [6:0] seg;

initial begin
    // Initialize data values for testing
    data <= 4'h0; // Test with 0
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'h1; // Test with 1
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'h2; // Test with 2
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'h3; // Test with 3
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'h4; // Test with 4
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'h5; // Test with 5
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'h6; // Test with 6
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'h7; // Test with 7
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'h8; // Test with 8
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'h9; // Test with 9
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'hA; // Test with A
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'hB; // Test with B
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'hC; // Test with C
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'hD; // Test with D
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'hE; // Test with E
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'hF; // Test with F
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    data <= 4'h10; // Test with invalid value
    #10;
    $display("Data: %b, Segments: %b", data, seg);

    $finish;
end

seven_seg_display uut (
   .data(data),
   .seg(seg)
);

endmodule