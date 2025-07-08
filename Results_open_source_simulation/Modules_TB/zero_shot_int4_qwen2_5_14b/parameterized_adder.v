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
        $display("Test Case 1: a=0, b=0");
        $monitor("%d %d %d %b", a, b, sum, carry);

        a = 'b1; b = 'b0;
        #10;
        $display("Test Case 2: a=1, b=0");
        
        a = 'b0; b = 'b1;
        #10;
        $display("Test Case 3: a=0, b=1");

        a = 'b1; b = 'b1;
        #10;
        $display("Test Case 4: a=1, b=1");

        a = 'b1; b = 'b1;
        #10;
        $display("Test Case 5: a=1, b=1 (repeat)");

        a = 'b1; b = 'b'h7fff;
        #10;
        $display("Test Case 6: a=1, b=%h", b);

        a = 'b'h7fff; b = 'b'1;
        #10;
        $display("Test Case 7: a=%h, b=1", a);

        a = 'b'h7fff; b = 'b'h7fff;
        #10;
        $display("Test Case 8: a=%h, b=%h", a, b);

        a = 'b'hffff; b = 'b'hffff;
        #10;
        $display("Test Case 9: a=%h, b=%h (overflow)", a, b);

        #100;
        $finish;
    end
endmodule