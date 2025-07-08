module tb_param_subtractor;

parameter WIDTH = 8;

logic [WIDTH-1:0] a, b;
logic [WIDTH-1:0] diff;
logic borrow;

param_subtractor #(.WIDTH(WIDTH)) dut (
   .a(a),
   .b(b),
   .diff(diff),
   .borrow(borrow)
);

always @(*) begin assert (@(posedge clk) ((a - b)[WIDTH-1:0] == diff)); end
always @(*) begin assert (@(posedge clk) ((a < b) | (a == b && borrow))); end
always @(*) begin assert (@(posedge clk) (~((a >= b) || (a == b && ~borrow)))); end
always @(*) begin assert (@(posedge clk) ($rose(borrow) && (a == (1 << WIDTH)-1))); end
always @(*) begin assert (@(posedge clk) ($fell(borrow) && (a == 0))); end
always @(*) begin assert (@(posedge clk) ((a == b) | (a == (1 << WIDTH)-1) | (a == 0))); end

always #10 clk = ~clk; // Clock generation

endmodule