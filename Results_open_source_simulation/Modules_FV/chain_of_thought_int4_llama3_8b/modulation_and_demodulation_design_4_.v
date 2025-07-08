module tb_mod_demod;
parameter DATA_WIDTH = 16;

logic clk;
logic rst;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] modulated_signal;
logic [DATA_WIDTH-1:0] demodulated_data;

mod_demod dut (
   .clk(clk),
   .rst(rst),
   .data_in(data_in),
   .modulated_signal(modulated_signal),
   .demodulated_data(demodulated_data)
);

property p_initial_state;
   !rst |=> ($rose(clk));
endproperty

property p_clock_period;
    @(posedge clk) disable iff (!rst) dist => ##[10:20] $fell(clk);
endproperty

property p_edge_cases;
    property p_edge_case_0;
        data_in == 0 |=> modulated_signal == {DATA_WIDTH{1'b1}} && demodulated_data == 0;
    endproperty
    property p_edge_case_1;
        data_in == 1 |=> modulated_signal == ~{DATA_WIDTH{1'b1}} && demodulated_data == 1;
    endproperty
    assert property(p_edge_case_0);
    assert property(p_edge_case_1);
endproperty

property p_overflow_underflow;
    property p_overflow;
        data_in >= 2**DATA_WIDTH - 1 |=> $rise(demodulated_data);
    endproperty
    property p_underflow;
        data_in < 2**DATA_WIDTH - 1 |=> $fall(demodulated_data);
    endproperty
    assert property(p_overflow);
    assert property(p_underflow);
endproperty

property p_illegal_transition;
    property p_illegal_transition_0;
        rst && data_in!= 0 |=> $stable(modulated_signal);
    endproperty
    property p_illegal_transition_1;
        rst && data_in!= 1 |=> $stable(demodulated_data);
    endproperty
    assert property(p_illegal_transition_0);
    assert property(p_illegal_transition_1);
endproperty

always @(posedge clk) begin
    rst = 1; #10 rst = 0;
end

endmodule