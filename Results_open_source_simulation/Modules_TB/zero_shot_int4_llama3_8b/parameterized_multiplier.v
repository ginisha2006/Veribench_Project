module tb_param_multiplier;

parameter WIDTH = 8;
reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
wire [2*WIDTH-1:0] product;

param_multiplier #(
   .WIDTH(WIDTH)
) dut (
   .a(a),
   .b(b),
   .product(product)
);

initial begin
    // Initialize inputs
    a = 0;
    b = 0;
    
    // Test with small values
    #10;
    a = 3'b00000101; // 5
    b = 3'b00000101; // 5
    #20;
    $display("Product: %h", product); // Expected result: 25
    
    // Test with large values
    #10;
    a = 3'b11111011; // 255
    b = 3'b11111011; // 255
    #20;
    $display("Product: %h", product); // Expected result: 65025
    
    // Test with zero value
    #10;
    a = 3'b00000000; // 0
    b = 3'b11111011; // 255
    #20;
    $display("Product: %h", product); // Expected result: 0
    
    // Test with negative values (not supported by this multiplier)
    #10;
    a = 3'b11111111; // -1
    b = 3'b11111011; // 255
    #20;
    $display("Product: %h", product); // Not expected result (not supported)
    
    // Test with overflow
    #10;
    a = 3'b11111111; // 255
    b = 3'b11111111; // 255
    #20;
    $display("Product: %h", product); // Expected result: 65535
    
    // Test with underflow
    #10;
    a = 3'b00000000; // 0
    b = 3'b00000000; // 0
    #20;
    $display("Product: %h", product); // Expected result: 0
    
    // Test with edge cases
    #10;
    a = 3'b00000001; // 1
    b = 3'b00000001; // 1
    #20;
    $display("Product: %h", product); // Expected result: 1
    
    #100;
    $finish;
end

always @(posedge clock) begin
    #10;
    $monitor("a=%b, b=%b, product=%h", a, b, product);
end

endmodule