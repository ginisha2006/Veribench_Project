module tb_bidir_pin();

    // Parameters
    parameter WIDTH = 1;
    
    // Signals
    reg clk;
    reg dir;
    reg [WIDTH-1:0] data_out;
    wire [WIDTH-1:0] data_in;
    tri [WIDTH-1:0] pin;

    // DUT instantiation
    bidir_pin #(.WIDTH(WIDTH)) uut (
        .pin(pin),
        .dir(dir),
        .data_out(data_out),
        .data_in(data_in)
    );

    // Clock generation
    always begin
        clk = 0; #5; clk = 1; #5;
    end
    
    // Properties
    property prop_dir_output;
        @(posedge clk) disable iff (!dir)
            pin == data_out;
    endproperty

    assert property(prop_dir_output);

    property prop_tri_state;
        @(posedge clk) disable iff (dir)
            pin[0] === 1'bz;
    endproperty

    assert property(prop_tri_state);

endmodule