module tb_bidir_pin;
    // Parameters
    localparam WIDTH = 4; // Assuming WIDTH is 4 bits

    // Signals
    inout logic [WIDTH-1:0] pin;
    input logic dir;
    input logic [WIDTH-1:0] data_out;
    output logic [WIDTH-1:0] data_in;

    // DUT instantiation
    bidir_pin dut (
       .pin(pin),
       .dir(dir),
       .data_out(data_out),
       .data_in(data_in)
    );

    // Clock generation
    always #10 clk = ~clk; // Assume 10ns period

    // Properties
    property p_dir_set;
        @(posedge clk) ($onehot(dir));
    endproperty

    property p_data_out_drive;
        @(posedge clk) ((dir) => ($stable(data_out[0]));
    endproperty

    property p_data_in_drive;
        @(posedge clk) (!dir => ($stable({WIDTH{1'b0})));
    endproperty

    property p_pin_drive;
        @(posedge clk) ((dir) => (pin == data_out));
        @(posedge clk) (!dir => (pin == {WIDTH{1'bz})));
    endproperty

    property p_no_overflow;
        @(posedge clk) ($onehot(data_out) && $onehot(data_in));
    endproperty

    assert property (p_dir_set);
    assert property (p_data_out_drive);
    assert property (p_data_in_drive);
    assert property (p_pin_drive);
    assert property (p_no_overflow);

endmodule