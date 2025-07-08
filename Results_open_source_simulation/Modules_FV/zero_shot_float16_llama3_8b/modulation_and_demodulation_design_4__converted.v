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
    always @(*) begin assert (@(posedge clk) disable iff (!rst) ($onehot(data_in) => $onehot(modulated_signal))); end
    always @(*) begin assert (@(posedge clk) disable iff (!rst) ($onehot(modulated_signal) => $onehot(demodulated_data))); end
    always @(*) begin assert (@(posedge clk) disable iff (!rst) ((data_in ^ {DATA_WIDTH{1'b1}} == modulated_signal) && (modulated_signal ^ {DATA_WIDTH{1'b1}} == demodulated_data))); end

endmodule