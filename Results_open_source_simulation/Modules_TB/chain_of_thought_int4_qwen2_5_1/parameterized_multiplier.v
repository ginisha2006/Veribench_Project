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
        a = 4'b0000; b = 4'b0000; #10;
        a = 4'b0001; b = 4'b0001; #10;
        a = 4'b1111; b = 4'b1111; #10;
        a = 4'b0000; b = 4'b1111; #10;
        a = 4'b1111; b = 4'b0000; #10;
        a = 4'b1111; b = 4'b1111; #10;
        a = 4'b0001; b = 4'b1111; #10;
        a = 4'b1111; b = 4'b0001; #10;
        a = 4'b1010; b = 4'b1010; #10;
        a = 4'b1111; b = 4'b1111; #10;
        
        // Edge case - all zeros
        a = 4'b0000; b = 4'b0000; #10;
        // Edge case - one bit set in each
        a = 4'b0001; b = 4'b0001; #10;
        // Corner case - max value
        a = 4'b1111; b = 4'b1111; #10;
        // Corner case - min value (all ones) with zero
        a = 4'b1111; b = 4'b0000; #10;
        // Corner case - zero with min value (all ones)
        a = 4'b0000; b = 4'b1111; #10;
        // Corner case - max values multiplied
        a = 4'b1111; b = 4'b1111; #10;
        // Random values
        a = 4'b1010; b = 4'b1010; #10;
        // Another random multiplication
        a = 4'b1111; b = 4'b1111; #10;
        
        // End of tests
        $finish;
    end
    
    always @(posedge a or posedge b) begin
        $monitor("%d %d -> %d", a, b, product);
    end
endmodule