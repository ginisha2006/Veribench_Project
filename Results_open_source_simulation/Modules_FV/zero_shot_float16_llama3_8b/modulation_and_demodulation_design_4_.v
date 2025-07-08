module tb_mod_demod;
    // Parameters
    localparam DATA_WIDTH = 16;

    // Input/Output Signals
    logic clk;
    logic rst;
    logic [DATA_WIDTH-1:0] data_in;
    logic [DATA_WIDTH-1:0] modulated_signal;
    logic [DATA_WIDTH-1:0] demodulated_data;

    // DUT Instantiation
    mod_demod dut (
       .clk(clk),
       .rst(rst),
       .data_in(data_in),
       .modulated_signal(modulated_signal),
       .demodulated_data(demodulated_data)
    );

    // Clock Generation
    always #10 clk = ~clk;

    // Properties
    property p_modulation_correctness;
        @(posedge clk) disable iff (!rst) ($onehot(data_in) => $onehot(modulated_signal));
    endproperty

    property p_demodulation_correctness;
        @(posedge clk) disable iff (!rst) ($onehot(modulated_signal) => $onehot(demodulated_data));
    endproperty

    property p_xor_property;
        @(posedge clk) disable iff (!rst) ((data_in ^ {DATA_WIDTH{1'b1}} == modulated_signal) && (modulated_signal ^ {DATA_WIDTH{1'b1}} == demodulated_data));
    endproperty

    assert property (p_modulation_correctness);
    assert property (p_demodulation_correctness);
    assert property (p_xor_property);

endmodule