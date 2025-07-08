module tb_mod_demod;

parameter DATA_WIDTH = 16;
reg clk;
reg rst;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] modulated_signal;
wire [DATA_WIDTH-1:0] demodulated_data;

mod_demod #(.DATA_WIDTH(DATA_WIDTH)) dut (
   .clk(clk),
   .rst(rst),
   .data_in(data_in),
   .modulated_signal(modulated_signal),
   .demodulated_data(demodulated_data)
);

property p_modulation_correctness;
    @(posedge clk) disable iff (!rst) ($onehot(data_in) => $onehot(modulated_signal));
endproperty

property p_demodulation_correctness;
    @(posedge clk) disable iff (!rst) ($onehot(modulated_signal) => $onehot(demodulated_data));
endproperty

property p_overflow_underflow;
    @(posedge clk) disable iff (!rst) ($onehot(data_in) |-> $onehot(demodulated_data));
endproperty

property p_edge_cases;
    @(posedge clk) disable iff (!rst) ((data_in == 0) |-> (modulated_signal == {DATA_WIDTH{1'b1}}));
    @(posedge clk) disable iff (!rst) ((data_in == {DATA_WIDTH{1'b1}}) |-> (modulated_signal == 0));
endproperty

assert property (p_modulation_correctness);
assert property (p_demodulation_correctness);
assert property (p_overflow_underflow);
assert property (p_edge_cases);

always #10 clk = ~clk; // Clock generation

initial begin
    rst = 1;
    #20 rst = 0;
    #100 $stop();
end

endmodule