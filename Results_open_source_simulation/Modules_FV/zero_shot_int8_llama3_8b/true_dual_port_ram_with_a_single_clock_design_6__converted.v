module tb_true_dpram_sclk;

reg [7:0] data_a, data_b;

reg [5:0] addr_a, addr_b;

reg we_a, we_b;

reg clk;

true_dpram_sclk dut (.data_a(data_a),.data_b(data_b),.addr_a(addr_a),.addr_b(addr_b),.we_a(we_a),.we_b(we_b),.clk(clk),.q_a(q_a),.q_b(q_b));

initial begin

#10 clk = 1'b0;

#10 clk = 1'b1;

repeat (10000) #10 clk = ~clk;

$stop;

end

assert property (@(posedge clk) port_a_write_correct);

assert property (@(posedge clk) port_a_read_correct);

assert property (@(posedge clk) port_b_write_correct);

assert property (@(posedge clk) port_b_read_correct);

assert property (@(posedge clk) no_overflow_addr_a);

assert property (@(posedge clk) no_overflow_addr_b);

assert property (@(posedge clk) no_underflow_addr_a);

assert property (@(posedge clk) no_underflow_addr_b);

assert property (@(posedge clk) no_write_conflict);

assert property (@(posedge clk) no_read_conflict);

endmodule