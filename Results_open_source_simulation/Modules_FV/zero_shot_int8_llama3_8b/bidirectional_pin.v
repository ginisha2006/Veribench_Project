module tb_bidir_pin;
    // Parameters
    localparam WIDTH = 1;

    // Signals
    logic [WIDTH-1:0] pin;
    logic dir;
    logic [WIDTH-1:0] data_out;
    logic [WIDTH-1:0] data_in;
    logic clk;

    // DUT instantiation
    bidir_pin dut (
       .pin(pin),
       .dir(dir),
       .data_out(data_out),
       .data_in(data_in)
    );

    // Clock generation
    always #10 clk = ~clk;

    // Properties
    property p_dir_set;
        @(posedge clk) ($onehot(dir));
    endproperty

    property p_data_out_drive;
        @(posedge clk) ((dir) => ($fell(p) == data_out));
    endproperty

    property p_data_in_capture;
        @(posedge clk) ((~dir) => ($rose(p) == data_in));
    endproperty

    property p_invalid_transition;
        @(posedge clk) (!dir &&!dir);
    endproperty

    assert property (p_dir_set);
    assert property (p_data_out_drive);
    assert property (p_data_in_capture);
    assert property (~p_invalid_transition);

endmodule