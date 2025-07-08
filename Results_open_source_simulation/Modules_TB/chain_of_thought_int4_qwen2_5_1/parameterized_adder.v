module tb_param_adder;
    parameter WIDTH = 8;

    reg [WIDTH-1:0] a;
    reg [WIDTH-1:0] b;
    wire [WIDTH-1:0] sum;
    wire carry;

    param_adder #(.WIDTH(WIDTH)) uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        // Initialize inputs
        a = 0; b = 0;
        #10;
        $display("Initial state: a=%d, b=%d, sum=%d, carry=%d", a, b, sum, carry);

        // Test case 1: Both inputs zero
        a = 0; b = 0;
        #10;
        $display("Test Case 1: a=%d, b=%d, sum=%d, carry=%d", a, b, sum, carry);

        // Test case 2: Maximum values
        a = (1<<WIDTH)-1; b = (1<<WIDTH)-1;
        #10;
        $display("Test Case 2: a=%d, b=%d, sum=%d, carry=%d", a, b, sum, carry);

        // Test case 3: One bit addition with carry out
        a = 1'b1; b = 1'b1;
        #10;
        $display("Test Case 3: a=%d, b=%d, sum=%d, carry=%d", a, b, sum, carry);

        // Test case 4: Random values
        a = $random; b = $random;
        #10;
        $display("Test Case 4: a=%d, b=%d, sum=%d, carry=%d", a, b, sum, carry);

        // Test case 5: Edge case - one input is max value, other is min value
        a = (1<<WIDTH)-1; b = 0;
        #10;
        $display("Test Case 5: a=%d, b=%d, sum=%d, carry=%d", a, b, sum, carry);

        // Finish simulation
        $finish;
    end

endmodule