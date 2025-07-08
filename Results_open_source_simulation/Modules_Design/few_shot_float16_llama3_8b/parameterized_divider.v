module param_divider #(parameter WIDTH=8) (
    input [WIDTH-1:0] dividend,
    input [WIDTH-1:0] divisor,
    output [WIDTH-1:0] quotient,
    output [WIDTH-1:0] remainder
);
    wire [WIDTH:0] temp;
    reg [WIDTH:0] q;
    always @(posedge 'b1)
        begin
            q <= q >> 1;
            if (q[W+1] == 1'b1)
                q[W+1] <= dividend[W] & ~divisor[W-1];
            else
                q[W+1] <= 1'b0;
            temp <= {q[W], dividend};
        end
    assign quotient = q[W-1:0];
    assign remainder = temp[W-1:0];
endmodule