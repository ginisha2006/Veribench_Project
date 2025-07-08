module tb_counter;

parameter CLOCK_PERIOD = 10; // adjust this value according to your requirements

logic clk;
logic reset;
logic ena;
logic [7:0] result_exp;
logic [7:0] result;

counter dut (
   .clk(clk),
   .reset(reset),
   .ena(ena),
   .result(result)
);

always @(*) begin assert (@(posedge clk) disable iff (!reset); end
result == 0);
always @(*) begin assert (@(posedge clk) disable iff (!ena &&!reset); end
result == result_exp;
result_exp <= result + 1);
always @(*) begin assert (@(posedge clk) disable iff (!ena &&!reset); end
result >= 8'd128; // adjust this value according to your requirements);
always @(*) begin assert (@(posedge clk) disable iff (!ena &&!reset); end
result < 8'd0; // adjust this value according to your requirements);

initial begin
    #CLOCK_PERIOD * 5; // wait for some cycles before asserting reset
    reset = 1;
    #CLOCK_PERIOD * 2; // wait for some cycles after reset
    reset = 0;
    #CLOCK_PERIOD * 5; // wait for some cycles before enabling enable
    ena = 1;
    #CLOCK_PERIOD * 100; // wait for some cycles while enable is asserted
    ena = 0;
    #CLOCK_PERIOD * 5; // wait for some cycles after disabling enable
end

endmodule