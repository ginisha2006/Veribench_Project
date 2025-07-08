module tb_mod_demod #(
    parameter DATA_WIDTH = 16
)();

    // Inputs
    reg clk;
    reg rst;
    reg [DATA_WIDTH-1:0] data_in;

    // Outputs
    wire [DATA_WIDTH-1:0] modulated_signal;
    wire [DATA_WIDTH-1:0] demodulated_data;

    // Instantiate the DUT
    mod_demod #(.DATA_WIDTH(DATA_WIDTH)) UUT (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .modulated_signal(modulated_signal),
        .demodulated_data(demodulated_data)
    );

    // Clock generation for properties
    initial clk = 0;
    always #5 clk = ~clk;

    // Properties

    property p_modulated_signal;
        @(posedge clk) (modulated_signal === data_in ^ {DATA_WIDTH{1'b1}});
    endproperty
    assert property (p_modulated_signal);

    property p_demodulated_data;
        @(posedge clk) (demodulated_data === modulated_signal ^ {DATA_WIDTH{1'b1}});
    endproperty
    assert property (p_demodulated_data);

    property p_round_trip;
        @(posedge clk) (demodulated_data === data_in);
    endproperty
    assert property (p_round_trip);

endmodule