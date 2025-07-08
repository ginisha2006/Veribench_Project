module tb_param_divider;
    parameter WIDTH = 8;

    reg [WIDTH-1:0] dividend;
    reg [WIDTH-1:0] divisor;
    wire [WIDTH-1:0] quotient;
    wire [WIDTH-1:0] remainder;

    initial begin
        // Initialize signals
        dividend = 0; divisor = 1; #10;
        dividend = 7; divisor = 3; #10;
        dividend = 15; divisor = 4; #10;
        dividend = 255; divisor = 1; #10;
        dividend = 255; divisor = 255; #10;
        dividend = 255; divisor = 0; #10;
        dividend = 127; divisor = 128; #10;
        dividend = 254; divisor = 127; #10;
        dividend = 255; divisor = 128; #10;
        dividend = 255; divisor = 254; #10;
        $finish;
    end

    param_divider #(WIDTH) uut (
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_param_divider);
    end

    always @(posedge $realtime) begin
        $monitor("%t dividend=%b divisor=%b quotient=%b remainder=%b", $realtime, dividend, divisor, quotient, remainder);
    end
endmodule