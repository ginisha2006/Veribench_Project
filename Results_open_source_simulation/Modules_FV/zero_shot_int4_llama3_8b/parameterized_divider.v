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

property p_quotient_correctness;
@(posedge clk) disable iff (!rst)
    assert property (@(posedge clk) quotient == dividend / divisor);
endproperty

property p_remainder_correctness;
@(posedge clk) disable iff (!rst)
    assert property (@(posedge clk) remainder == dividend % divisor);
endproperty

property p_overflow_check;
@(posedge clk) disable iff (!rst)
    assume property (@(posedge clk) dividend < (1 << WIDTH));
    assume property (@(posedge clk) divisor!= 0);
    assert property (@(posedge clk) quotient < (1 << WIDTH));
    assert property (@(posedge clk) remainder < (1 << WIDTH));
endproperty

property p_underflow_check;
@(posedge clk) disable iff (!rst)
    assume property (@(posedge clk) dividend >= 0);
    assume property (@(posedge clk) divisor > 0);
    assert property (@(posedge clk) quotient >= 0);
    assert property (@(posedge clk) remainder >= 0);
endproperty

always @(posedge clk)
    #10; // adjust this delay according to your design's clock period

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

endmodule