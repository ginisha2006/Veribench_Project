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
        $display("Cycle %0d: a=%b, b=%b, product=%b", $time, a, b, product);

        // Test case 1: Both inputs zero
        a = 0; b = 0;
        #10;
        $display("Cycle %0d: a=%b, b=%b, product=%b", $time, a, b, product);

        // Test case 2: One input zero
        a = 0; b = 4'd7;
        #10;
        $display("Cycle %0d: a=%b, b=%b, product=%b", $time, a, b, product);

        // Test case 3: Non-zero inputs
        a = 4'd3; b = 4'd5;
        #10;
        $display("Cycle %0d: a=%b, b=%b, product=%b", $time, a, b, product);

        // Test case 4: Maximum values
        a = (1 << WIDTH) - 1; b = (1 << WIDTH) - 1;
        #10;
        $display("Cycle %0d: a=%b, b=%b, product=%b", $time, a, b, product);

        // Test case 5: Minimum values
        a = 0; b = (1 << WIDTH) - 1;
        #10;
        $display("Cycle %0d: a=%b, b=%b, product=%b", $time, a, b, product);

        // Test case 6: Random values
        a = 4'd9; b = 4'd11;
        #10;
        $display("Cycle %0d: a=%b, b=%b, product=%b", $time, a, b, product);

        // Finish simulation
        $finish;
    end
endmodule