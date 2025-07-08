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
        
        // Test case 1: Both inputs zero
        a = 0; b = 0;
        #10;
        
        // Test case 2: One input zero
        a = 0; b = 3;
        #10;
        a = 4; b = 0;
        #10;
        
        // Test case 3: Maximum values
        a = {WIDTH{1'b1}}; b = {WIDTH{1'b1}};
        #10;
        
        // Test case 4: Minimum values
        a = 0; b = 0;
        #10;
        
        // Test case 5: Random values
        a = 7; b = 9;
        #10;
        a = 15; b = 16;
        #10;
        
        // Edge case: Overflow
        a = {WIDTH{1'b1}} - 1; b = {WIDTH{1'b1}};
        #10;
        
        // Finalize
        $finish;
    end
    
    always @(posedge product) begin
        $display("Product: %d", product);
    end
endmodule