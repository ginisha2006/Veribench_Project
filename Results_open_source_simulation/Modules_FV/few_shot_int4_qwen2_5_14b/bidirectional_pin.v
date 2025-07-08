module tb_bidir_pin #(
    parameter WIDTH = 1
)();

    // Inputs
    reg dir;
    reg [WIDTH-1:0] data_out;
    
    // Output
    wire [WIDTH-1:0] data_in;

    // Bidirectional pin
    bidir_pin #(.WIDTH(WIDTH)) UUT (
        .pin(pin),
        .dir(dir),
        .data_out(data_out),
        .data_in(data_in)
    );

    // Properties

    // Property: When direction is high, pin should reflect data_out
    property p_data_out_driven;
        @(posedge dir) disable iff (!dir)
            $rose(dir) |-> pin === data_out;
    endproperty
    assert property(p_data_out_driven);

    // Property: When direction is low, pin should be high impedance
    property p_high_impedance;
        @(negedge dir) disable iff (dir)
            $fell(dir) |-> !$isunknown(pin);
    endproperty
    assert property(p_high_impedance);

    // Property: data_in should match pin value
    property p_data_in_match;
        @(posedge dir) disable iff (!dir)
            data_in === pin;
    endproperty
    assert property(p_data_in_match);

endmodule