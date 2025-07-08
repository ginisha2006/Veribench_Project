module tb_param_multiplier;

parameter WIDTH = 8;

reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
wire [2*WIDTH-1:0] product;

param_multiplier #(.WIDTH(WIDTH)) DUT (a, b, product);

initial begin
    // Initialize inputs
    a = 0;
    b = 0;

    // Test with small values
    #100; a = 3; b = 4; 
    #100; $display("product = %h", product); 

    // Test with large values
    #100; a = 127; b = 128; 
    #100; $display("product = %h", product); 

    // Test with overflow
    #100; a = 255; b = 256; 
    #100; $display("product = %h", product); 

    // Test with zero
    #100; a = 0; b = 0; 
    #100; $display("product = %h", product); 

    // Test with one
    #100; a = 1; b = 1; 
    #100; $display("product = %h", product); 

    // Test with negative numbers
    #100; a = -1; b = 1; 
    #100; $display("product = %h", product); 
    #100; a = 1; b = -1; 
    #100; $display("product = %h", product); 
    #100; a = -1; b = -1; 
    #100; $display("product = %h", product); 

    // Test with all combinations
    for (int i = 0; i < 2**WIDTH; i++) begin
        for (int j = 0; j < 2**WIDTH; j++) begin
            a = i; b = j;
            #100; $display("a = %h, b = %h, product = %h", a, b, product); 
        end
    end

    $finish;
end

always @(posedge clock) begin
    #1;
end

endmodule