module tb_param_divider;

parameter WIDTH = 8;

logic [WIDTH-1:0] dividend;
logic [WIDTH-1:0] divisor;
logic [WIDTH-1:0] quotient;
logic [WIDTH-1:0] remainder;
logic clk;
logic rst;

param_divider #(.WIDTH(WIDTH)) dut (
   .dividend(dividend),
   .divisor(divisor),
   .quotient(quotient),
   .remainder(remainder)
);

always @(posedge clk)
    #10; // adjust this delay according to your design's clock period

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

endmodule