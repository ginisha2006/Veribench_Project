module param_divider #(parameter WIDTH=8) (
    input [WIDTH-1:0] dividend,
    input [WIDTH-1:0] divisor,
    output [WIDTH-1:0] quotient,
    output [WIDTH-1:0] remainder
);
    reg [WIDTH-1:0] q, r;
    always @(posedge 'clock)
        begin
            if (divisor!= 0)
                begin
                    q <= r >> 1;
                    r <= r & dividend << 1 | q - divisor;
                end
            else
                begin
                    q <= 'bx;
                    r <= 'bx;
                end
        end
    assign quotient = q;
    assign remainder = r;
endmodule