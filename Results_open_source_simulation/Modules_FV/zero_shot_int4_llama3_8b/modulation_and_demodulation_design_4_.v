module tb_mod_demod;
import "DPI-C" function void cb();
parameter DATA_WIDTH = 16;

logic clk;
logic rst;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] modulated_signal;
logic [DATA_WIDTH-1:0] demodulated_data;

mod_demod #(
   .DATA_WIDTH(DATA_WIDTH)
) dut (
   .clk(clk),
   .rst(rst),
   .data_in(data_in),
   .modulated_signal(modulated_signal),
   .demodulated_data(demodulated_data)
);

property p_clk_period;
    @(posedge clk) disable iff (!rst);
    ##1;
endproperty

property p_reset;
   !rst |=> ($rose(rst));
endproperty

property p_modulation;
    @(posedge clk) disable iff (!rst);
    data_in == modulated_signal ^ {DATA_WIDTH{1'b1}};
endproperty

property p_demodulation;
    @(posedge clk) disable iff (!rst);
    demodulated_data == modulated_signal ^ {DATA_WIDTH{1'b1}};
endproperty

property p_overflow_underflow;
   !(|data_in[DATA_WIDTH-1]) |=> (!rst);
   !(~&data_in[DATA_WIDTH-1]) |=> (!rst);
endproperty

property p_edge_cases;
    @(posedge clk) disable iff (!rst);
    data_in == 0 |-> modulated_signal == {DATA_WIDTH{1'b0}};
    data_in == (1 << DATA_WIDTH)-1 |-> modulated_signal == {DATA_WIDTH{1'b1}};
endproperty

property p_illegal_transition;
    @(posedge clk) disable iff (!rst);
   !($rose(data_in)) |=> modulated_signal == data_in;
   !($fell(data_in)) |=> modulated_signal == data_in;
endproperty

property p_all;
    p_clk_period;
    p_reset;
    p_modulation;
    p_demodulation;
    p_overflow_underflow;
    p_edge_cases;
    p_illegal_transition;
endproperty

assert property p_all;

always @ (posedge clk) begin
    clk = ~clk;
    #10;
    clk = ~clk;
    #10;
end

initial begin
    cb();
end

endmodule