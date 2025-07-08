module tb_param_divider;
    parameter WIDTH = 8;

    reg [WIDTH-1:0] dividend;
    reg [WIDTH-1:0] divisor;
    wire [WIDTH-1:0] quotient;
    wire [WIDTH-1:0] remainder;

    initial begin
        #10;
        dividend = 4'b0001; divisor = 4'b0010; #10; // 1 / 2
        dividend = 4'b0010; divisor = 4'b0001; #10; // 2 / 1
        dividend = 4'b1000; divisor = 4'b0001; #10; // 8 / 1
        dividend = 4'b0011; divisor = 4'b0011; #10; // 3 / 3
        dividend = 4'b0100; divisor = 4'b0000; #10; // 4 / 0 (corner case)
        dividend = 4'b1111; divisor = 4'b0001; #10; // 15 / 1
        dividend = 4'b1111; divisor = 4'b1000; #10; // 15 / 8
        dividend = 4'b0000; divisor = 4'b0001; #10; // 0 / 1
        dividend = 4'b0001; divisor = 4'b0000; #10; // 1 / 0 (corner case)
        dividend = 4'b1010; divisor = 4'b0011; #10; // 10 / 3
        $finish;
    end

    initial begin
        $dumpfile("param_divider.vcd");
        $dumpvars(0, tb_param_divider);
    end

    initial begin
        #1000;
        $finish;
    end

    param_divider #(.WIDTH(WIDTH)) uut (
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder)
    );

    always @(posedge $finish) begin
        $display("Simulation finished.");
    end

    always @(posedge $time) begin
        if ($time > 0 && $time < 1000) begin
            $monitor("%t: dividend=%b, divisor=%b, quotient=%b, remainder=%b", $time, dividend, divisor, quotient, remainder);
        end
    end
endmodule