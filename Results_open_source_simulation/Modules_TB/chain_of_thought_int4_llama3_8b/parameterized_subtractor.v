module tb_param_subtractor;

parameter WIDTH = 8;
reg [WIDTH-1:0] a, b;
wire [WIDTH-1:0] diff;
wire borrow;

param_subtractor #(.WIDTH(WIDTH)) DUT (a, b, diff, borrow);

initial begin
    // Initialize inputs
    a = 0; b = 0;
    #10;

    // Test with small values
    a = 5; b = 3;
    #20;
    $display("Expected diff: %b, actual diff: %b", 5 - 3, diff);
    $display("Expected borrow: %b, actual borrow: %b", 1'b0, borrow);

    // Test with large values
    a = 255; b = 128;
    #20;
    $display("Expected diff: %b, actual diff: %b", 127, diff);
    $display("Expected borrow: %b, actual borrow: %b", 1'b1, borrow);

    // Test with overflow
    a = 256; b = 1;
    #20;
    $display("Expected diff: %b, actual diff: %b", 255, diff);
    $display("Expected borrow: %b, actual borrow: %b", 1'b1, borrow);

    // Test with underflow
    a = 0; b = 257;
    #20;
    $display("Expected diff: %b, actual diff: %b", -1, diff);
    $display("Expected borrow: %b, actual borrow: %b", 1'b1, borrow);

    // Test with zero values
    a = 0; b = 0;
    #20;
    $display("Expected diff: %b, actual diff: %b", 0, diff);
    $display("Expected borrow: %b, actual borrow: %b", 1'b0, borrow);

    // Test with negative values
    a = -1; b = -2;
    #20;
    $display("Expected diff: %b, actual diff: %b", 1, diff);
    $display("Expected borrow: %b, actual borrow: %b", 1'b1, borrow);

    // Test with mixed-sign values
    a = 5; b = -3;
    #20;
    $display("Expected diff: %b, actual diff: %b", 8, diff);
    $display("Expected borrow: %b, actual borrow: %b", 1'b1, borrow);

    #100 $finish;
end

always @(posedge clock) begin
    #10 $display("%t: %b", diff, borrow);
end

endmodule