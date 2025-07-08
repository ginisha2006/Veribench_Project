module param_divider #(
    parameter WIDTH = 8
)(
    input [WIDTH-1:0] dividend,
    input [WIDTH-1:0] divisor,
    output reg [WIDTH-1:0] quotient,
    output reg [WIDTH-1:0] remainder
);
    // This is a placeholder for actual division logic which would typically use DSP blocks.
    // The following is a simplified example of how one might implement it in pure Verilog without DSP primitives:
    always @(dividend, divisor) begin
        if(divisor == 0)
            $display("Error: Division by zero");
        else begin
            integer i;
            remainder = dividend;
            quotient = 0;
            for(i=0; i<WIDTH; i=i+1) begin
                if(remainder >= divisor) begin
                    remainder = remainder - divisor;
                    quotient[i] = 1'b1;
                end
                else
                    quotient[i] = 1'b0;
                if(i != WIDTH-1)
                    remainder = {remainder[WIDTH-2:0], 1'b0};
            end
        end
    end
endmodule