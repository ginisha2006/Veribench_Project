module tb_param_adder;

// Parameters
localparam WIDTH = 8;

// Signals
logic [WIDTH-1:0] a, b;
logic [WIDTH-1:0] sum;
logic carry;

// DUT instantiation
param_adder #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.sum(sum),.carry(carry));

// Clock generation
always #5 a <= ~a; // Non-deterministic clock
always #5 b <= ~b; // Non-deterministic clock

// Properties
always @(*) begin assert (@(posedge clk) ($onehot({a[WIDTH-1], b[WIDTH-1]} => sum == a + b))); end
always @(*) begin assert (@(posedge clk) (a[WIDTH-1] && b[WIDTH-1] => carry)); end
always @(*) begin assert (@(posedge clk) (~a[WIDTH-1] && ~b[WIDTH-1] =>!carry)); end
always @(*) begin assert (@(posedge clk) ((a >= 2**WIDTH - 1 || b >= 2**WIDTH - 1) => sum >= 2**WIDTH - 1)); end
always @(*) begin assert (@(posedge clk) ((a < -(2**WIDTH) || b < -(2**WIDTH)) => sum < -(2**WIDTH))); end

endmodule