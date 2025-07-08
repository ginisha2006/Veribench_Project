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
        $display("Cycle %0d: a=%b, b=%b, sum=%b, carry=%b", $time, a, b, sum, carry);

        a = 'b0000_0001; b = 'b0000_0001;
        #10;
        $display("Cycle %0d: a=%b, b=%b, sum=%b, carry=%b", $time, a, b, sum, carry);

        a = 'b1111_1111; b = 'b0000_0001;
        #10;
        $display("Cycle %0d: a=%b, b=%b, sum=%b, carry=%b", $time, a, b, sum, carry);

        a = 'b1111_1111; b = 'b0000_0000;
        #10;
        $display("Cycle %0d: a=%b, b=%b, sum=%b, carry=%b", $time, a, b, sum, carry);

        a = 'b0000_0000; b = 'b1111_1111;
        #10;
        $display("Cycle %0d: a=%b, b=%b, sum=%b, carry=%b", $time, a, b, sum, carry);

        a = 'b1111_1111; b = 'b1111_1111;
        #10;
        $display("Cycle %0d: a=%b, b=%b, sum=%b, carry=%b", $time, a, b, sum, carry);

        a = 'b0000_0000; b = 'b0000_0000;
        #10;
        $display("Cycle %0d: a=%b, b=%b, sum=%b, carry=%b", $time, a, b, sum, carry);

        a = 'b1111_1111; b = 'b0000_0000;
        #10;
        $display("Cycle %0d: a=%b, b=%b, sum=%b, carry=%b", $time, a, b, sum, carry);

        a = 'b0000_0000; b = 'b1111_1111;
        #10;
        $display("Cycle %0d: a=%b, b=%b, sum=%b, carry=%b", $time, a, b, sum, carry);

        a = 'b1111_1111; b = 'b1111_1111;
        #10;
        $display("Cycle %0d: a=%b, b=%b, sum=%b, carry=%b", $time, a, b, sum, carry);

        $finish;
    end
endmodule