module tb_digital_filter;
parameter DATA_WIDTH = 16;
parameter COEFF_WIDTH = 16;
parameter NUM_TAPS = 32;

logic clk;
logic rst;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] data_out;
logic [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

digital_filter dut (
   .clk(clk),
   .rst(rst),
   .data_in(data_in),
   .data_out(data_out),
   .coeff(coeff)
);

property p_clk_period;
    @(posedge clk) disable iff (!rst);
    ##[10:0];
    @(negedge clk) disable iff (!rst);
endproperty

property p_coeff_width;
    ($onehot0 {coeff[i]} for i < NUM_TAPS);
endproperty

property p_data_width;
    ($onehot0 {data_in[i]} for i < DATA_WIDTH);
endproperty

property p_data_out_width;
    ($onehot0 {data_out[i]} for i < DATA_WIDTH);
endproperty

property p_reset;
   !rst |=>!data_out;
endproperty

property p_edge_cases;
    @(posedge clk) disable iff (!rst);
    data_in == 0 |-> data_out == 0;
    @(posedge clk) disable iff (!rst);
    data_in == 1'b1 |-> data_out == 1'b1;
endproperty

property p_overflow;
    data_in >= 2**DATA_WIDTH - 1 |-> data_out == data_in;
endproperty

property p_underflow;
    data_in <= 0 |-> data_out == 0;
endproperty

assert property (p_clk_period);
assert property (p_coeff_width);
assert property (p_data_width);
assert property (p_data_out_width);
assert property (p_reset);
assert property (p_edge_cases);
assert property (p_overflow);
assert property (p_underflow);

endmodule