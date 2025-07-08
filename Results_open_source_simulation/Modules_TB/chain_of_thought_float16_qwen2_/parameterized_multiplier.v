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
        
        // Test case 3: Full range positive values
        a = (1 << WIDTH) - 1; b = (1 << WIDTH) - 1;
        #10;
        
        // Test case 4: Negative values (assuming two's complement)
        a = -(1 << (WIDTH-1)); b = -(1 << (WIDTH-1));
        #10;
        
        // Test case 5: Mixed sign multiplication
        a = (1 << (WIDTH-1)); b = -(1 << (WIDTH-1));
        #10;
        a = -(1 << (WIDTH-1)); b = (1 << (WIDTH-1));
        #10;
        
        // Test case 6: Random values
        a = 7; b = 9;
        #10;
        a = 15; b = 15;
        #10;
        
        // End of tests
        $finish;
    end
    
    always @(posedge product) begin
        $display("Product: %d", product);
    end
endmodule