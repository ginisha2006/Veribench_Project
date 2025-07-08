module tb_param_divider;

    parameter WIDTH = 8;
    reg [WIDTH-1:0] dividend;
    reg [WIDTH-1:0] divisor;
    wire [WIDTH-1:0] quotient;
    wire [WIDTH-1:0] remainder;

    param_divider #(.WIDTH(WIDTH)) dut (
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder)
    );

    always begin
        #5 dividend <= $random;
        #5 divisor <= $random;
    end

    always @(*) begin assert (@(posedge $anyedge) divisor !== 0); end

    always @(*) begin assert (@(posedge $anyedge) quotient == dividend / divisor); end

    always @(*) begin assert (@(posedge $anyedge) remainder == dividend % divisor); end

endmodule