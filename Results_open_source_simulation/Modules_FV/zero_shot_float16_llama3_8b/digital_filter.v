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

property p_data_width;
    @(posedge clk) disable iff (!rst) ($isunknown(data_in) |-> $rose(data_out));
endproperty

property p_coeff_width;
    @(posedge clk) disable iff (!rst) ($isunknown(coeff[0]) |-> $rose(data_out));
endproperty

property p_num_taps;
    @(posedge clk) disable iff (!rst) ($isunknown(coeff) |-> $rose(data_out));
endproperty

property p_overflow;
    @(posedge clk) disable iff (!rst) ((data_in > (1 << (DATA_WIDTH - 1)) | data_in < -(1 << (DATA_WIDTH - 1))) |->
        ##1 $fell(data_out));
endproperty

property p_underflow;
    @(posedge clk) disable iff (!rst) ((data_in < -(1 << (DATA_WIDTH - 1)) | data_in > (1 << (DATA_WIDTH - 1))) |->
        ##1 $fell(data_out));
endproperty

property p_edge_cases;
    @(posedge clk) disable iff (!rst) ((rst == 1'b1) |->
        ##1 $rose(data_out));
endproperty

property p_transition;
    @(posedge clk) disable iff (!rst) ((data_in!= data_in) |->
        ##1 $rose(data_out));
endproperty

assert property (p_data_width);
assert property (p_coeff_width);
assert property (p_num_taps);
assert property (p_overflow);
assert property (p_underflow);
assert property (p_edge_cases);
assert property (p_transition);

always #10 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    #20 rst = 0;
    #100 $finish;
end

endmodule