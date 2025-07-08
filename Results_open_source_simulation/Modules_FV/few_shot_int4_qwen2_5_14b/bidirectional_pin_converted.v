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
    assert (@(posedge dir) disable iff (!dir)
            $rose(dir) |-> pin === data_out);

    // Property: When direction is low, pin should be high impedance
    assert (@(negedge dir) disable iff (dir)
            $fell(dir) |-> !$isunknown(pin));

    // Property: data_in should match pin value
    assert (@(posedge dir) disable iff (!dir)
            data_in === pin);

endmodule