module tb_mod_demod;
    parameter DATA_WIDTH = 16;

    logic clk;
    logic rst;
    logic [DATA_WIDTH-1:0] data_in;
    logic [DATA_WIDTH-1:0] modulated_signal;
    logic [DATA_WIDTH-1:0] demodulated_data;

    // Clock generation
    always #10 clk = ~clk;

    // Instantiate DUT
    mod_demod dut (
       .clk(clk),
       .rst(rst),
       .data_in(data_in),
       .modulated_signal(modulated_signal),
       .demodulated_data(demodulated_data)
    );

    property p_initial_state;
       !rst |=> ($onehot(dut.modulated_signal));
    endproperty

    property p_edge_cases;
        @(posedge clk) disable iff (!rst) (dut.data_in == 0) |-> (dut.modulated_signal == {DATA_WIDTH{1'b1}});
        @(negedge clk) disable iff (!rst) (dut.data_in == 0) |-> (dut.modulated_signal == {DATA_WIDTH{1'b0}});
    endproperty

    property p_overflow_underflow;
        @(posedge clk) disable iff (!rst) ((dut.data_in!= 0) & (dut.modulated_signal == {DATA_WIDTH{1'b1})) |-> ##[1:DATA_WIDTH] dut.modulated_signal!= {DATA_WIDTH{1'b1}};
        @(negedge clk) disable iff (!rst) ((dut.data_in!= 0) & (dut.modulated_signal == {DATA_WIDTH{1'b0})) |-> ##[1:DATA_WIDTH] dut.modulated_signal!= {DATA_WIDTH{1'b0}};
    endproperty

    property p_illegal_transition;
        @(posedge clk) disable iff (!rst) (dut.modulated_signal!= {DATA_WIDTH{1'b1}) |-> ##1 dut.modulated_signal!= {DATA_WIDTH{1'b1}};
        @(negedge clk) disable iff (!rst) (dut.modulated_signal!= {DATA_WIDTH{1'b0}) |-> ##1 dut.modulated_signal!= {DATA_WIDTH{1'b0}};
    endproperty

    assert property (p_initial_state);
    assert property (p_edge_cases);
    assert property (p_overflow_underflow);
    assert property (p_illegal_transition);

endmodule