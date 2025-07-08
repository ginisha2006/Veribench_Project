module param_divider #(parameter WIDTH = 8)
    (input [WIDTH-1:0] dividend,
     input [WIDTH-1:0] divisor,
     output [WIDTH-1:0] quotient,
     output [WIDTH-1:0] remainder);

reg [WIDTH-1:0] temp;
wire [WIDTH-1:0] q;

always @(posedge clock) begin
    if (divisor!= 0) begin
        temp <= dividend - {1'b1, divisor};
        q <= dividend >= divisor? 1 : 0;
    end else begin
        temp <= 'bz;
        q <= 'bz;
    end
end

assign quotient = q;
assign remainder = temp;

endmodule