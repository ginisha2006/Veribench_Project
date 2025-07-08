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
        $display("Cycle %d: a=%d, b=%d, sum=%d, carry=%d", $time, a, b, sum, carry);

        a = 'hFF; b = 'hFF;
        #10;
        $display("Cycle %d: a=%d, b=%d, sum=%d, carry=%d", $time, a, b, sum, carry);

        a = 'h7F; b = 'h80;
        #10;
        $display("Cycle %d: a=%d, b=%d, sum=%d, carry=%d", $time, a, b, sum, carry);

        a = 'hFE; b = 'h01;
        #10;
        $display("Cycle %d: a=%d, b=%d, sum=%d, carry=%d", $time, a, b, sum, carry);

        a = 'h01; b = 'h01;
        #10;
        $display("Cycle %d: a=%d, b=%d, sum=%d, carry=%d", $time, a, b, sum, carry);

        a = 'h00; b = 'h00;
        #10;
        $display("Cycle %d: a=%d, b=%d, sum=%d, carry=%d", $time, a, b, sum, carry);

        a = 'hFF; b = 'h01;
        #10;
        $display("Cycle %d: a=%d, b=%d, sum=%d, carry=%d", $time, a, b, sum, carry);

        a = 'h01; b = 'hFF;
        #10;
        $display("Cycle %d: a=%d, b=%d, sum=%d, carry=%d", $time, a, b, sum, carry);

        a = 'h80; b = 'h80;
        #10;
        $display("Cycle %d: a=%d, b=%d, sum=%d, carry=%d", $time, a, b, sum, carry);

        a = 'h00; b = 'hFF;
        #10;
        $display("Cycle %d: a=%d, b=%d, sum=%d, carry=%d", $time, a, b, sum, carry);

        a = 'hFF; b = 'h00;
        #10;
        $display("Cycle %d: a=%d, b=%d, sum=%d, carry=%d", $time, a, b, sum, carry);

        a = 'h00; b = 'h00;
        #10;
        $display("Cycle %d: a=%d, b=%d, sum=%d, carry=%d", $time, a, b, sum, carry);

        $finish;
    end
endmodule