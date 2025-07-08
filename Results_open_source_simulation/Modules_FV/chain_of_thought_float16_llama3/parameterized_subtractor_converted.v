module tb_param_subtractor;

parameter WIDTH = 8;

input [WIDTH-1:0] a, b;

output [WIDTH-1:0] diff;

output borrow;

param_subtractor #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.diff(diff),.borrow(borrow));

always @(*) begin assert (@(posedge clk) ($rose(borrow) |=> $distance(diff, {WIDTH{1'b0})) |-> $less_than($value(diff), $value(a))); end
always @(*) begin assert (@(posedge clk) ($fell(borrow) |=> $equal($value(diff), $value(a)))); end
always @(*) begin assert (@(posedge clk) ($rose(borrow) & $greater($value(a), $value(b)) |=> $overflow(diff))); end
always @(*) begin assert (@(posedge clk) ($fell(borrow) & $less($value(a), $value(b)) |=> $underflow(diff))); end

endmodule