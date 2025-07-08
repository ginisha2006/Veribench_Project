module tb_param_subtractor;
    parameter WIDTH = 8;

    reg [WIDTH-1:0] a;
    reg [WIDTH-1:0] b;
    wire [WIDTH-1:0] diff;
    wire borrow;

    param_subtractor #(.WIDTH(WIDTH)) uut (
        .a(a),
        .b(b),
        .diff(diff),
        .borrow(borrow)
    );

    initial begin
        // Initialize inputs
        a = 0; b = 0;
        #10;
        $display("Initial state: a=%d, b=%d, diff=%d, borrow=%d", a, b, diff, borrow);

        // Test case 1: Normal subtraction (positive numbers)
        a = 5; b = 3;
        #10;
        $display("Test case 1: a=%d, b=%d, diff=%d, borrow=%d", a, b, diff, borrow);

        // Test case 2: Borrow case (smaller number subtracted from larger one)
        a = 3; b = 5;
        #10;
        $display("Test case 2: a=%d, b=%d, diff=%d, borrow=%d", a, b, diff, borrow);

        // Test case 3: Edge case with maximum values
        a = 'hFF; b = 'hFE;
        #10;
        $display("Test case 3: a=%d, b=%d, diff=%d, borrow=%d", a, b, diff, borrow);

        // Test case 4: Edge case with minimum values
        a = 0; b = 1;
        #10;
        $display("Test case 4: a=%d, b=%d, diff=%d, borrow=%d", a, b, diff, borrow);

        // Test case 5: All ones for a and all zeros for b
        a = 'hFF; b = 0;
        #10;
        $display("Test case 5: a=%d, b=%d, diff=%d, borrow=%d", a, b, diff, borrow);

        // Test case 6: All zeros for a and all ones for b
        a = 0; b = 'hFF;
        #10;
        $display("Test case 6: a=%d, b=%d, diff=%d, borrow=%d", a, b, diff, borrow);

        // Finish simulation
        $finish;
    end
endmodule