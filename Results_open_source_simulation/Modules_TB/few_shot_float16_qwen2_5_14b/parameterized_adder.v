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
        $display("Time       a                   b                   sum                  carry");
        $monitor("%0t      %b                 %b                 %b                  %b", $time, a, b, sum, carry);

        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        a = 'hFF; b = 0; #10;
        a = 'hFF; b = 1; #10;
        a = 'hFF; b = 'hFF; #10;
        a = 'h7F; b = 'h80; #10;

        $finish;
    end
endmodule