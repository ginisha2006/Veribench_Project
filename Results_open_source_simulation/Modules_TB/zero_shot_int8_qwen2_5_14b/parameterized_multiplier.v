module tb_param_multiplier;
    parameter WIDTH = 8;
    reg [WIDTH-1:0] a;
    reg [WIDTH-1:0] b;
    wire [2*WIDTH-1:0] product;

    param_multiplier #(.WIDTH(WIDTH)) uut (
        .a(a),
        .b(b),
        .product(product)
    );

    initial begin
        // Initialize inputs
        a = 0; b = 0;
        #10;
        
        // Test case 1: Basic multiplication
        a = 3; b = 4;
        #10;
        
        // Test case 2: Maximum value multiplication
        a = {WIDTH{1'b1}} - 1; b = {WIDTH{1'b1}} - 1;
        #10;
        
        // Test case 3: Zero multiplication
        a = 0; b = 7;
        #10;
        
        // Test case 4: One multiplication
        a = 1; b = 1;
        #10;
        
        // Test case 5: Edge case with one bit set in each operand
        a = 1 << (WIDTH / 2); b = 1 << (WIDTH / 2);
        #10;
        
        // Test case 6: Random values
        a = $random; b = $random;
        #10;
        
        // Final check after all tests
        $finish;
    end
    
    always @(posedge product) 
        $display("Product: %d", product);

endmodule