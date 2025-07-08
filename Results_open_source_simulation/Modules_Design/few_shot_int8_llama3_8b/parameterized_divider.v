module param_divider #(parameter WIDTH=8) (
    input [WIDTH-1:0] dividend,
    input [WIDTH-1:0] divisor,
    output [WIDTH-1:0] quotient,
    output [WIDTH-1:0] remainder
);
    reg [WIDTH-1:0] q, r;
    always @(posedge clock) begin
        if (r >= divisor)
            begin
                q <= q + 1;
                r <= r - divisor;
            end
        else
            r <= r;
    end
    assign quotient = q;
    assign remainder = r;
endmodule