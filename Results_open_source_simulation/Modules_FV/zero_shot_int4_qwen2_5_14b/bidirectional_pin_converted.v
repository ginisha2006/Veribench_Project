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
    assert (@(posedge clk) disable iff (!dir)
            pin == data_out);

    assert (@(posedge clk) disable iff (dir)
            pin[0] === 1'bz);

endmodule