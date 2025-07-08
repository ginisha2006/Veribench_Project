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
        // Initialize vectors
        a = 0; b = 0; #10;
        $display("Product when a=0 and b=0 is %d", product);

        a = 0; b = 1; #10;
        $display("Product when a=0 and b=1 is %d", product);

        a = 1; b = 0; #10;
        $display("Product when a=1 and b=0 is %d", product);

        a = 1; b = 1; #10;
        $display("Product when a=1 and b=1 is %d", product);

        a = {WIDTH{1'b1}}; b = {WIDTH{1'b1}}; #10;
        $display("Product when a=%d and b=%d is %d", a, b, product);

        a = 'b1010; b = 'b1100; #10;
        $display("Product when a=%d and b=%d is %d", a, b, product);

        a = 'b10101010; b = 'b11001100; #10;
        $display("Product when a=%d and b=%d is %d", a, b, product);

        a = 'b101010101010; b = 'b110011001100; #10;
        $display("Product when a=%d and b=%d is %d", a, b, product);

        $finish;
    end

endmodule