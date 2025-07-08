module tb_counter (
    input clk,
    input reset,
    input ena,
    output reg [7:0] result
);
    wire [7:0] result_wire;

    counter dut (
        .clk(clk),
        .reset(reset),
        .ena(ena),
        .result(result_wire)
    );

    always #5 clk =~clk; // Clock signal generation

    property reset_assertion;
        @(posedge clk) reset |-> ##1 result == 8'b0;
    endproperty
    assert property (reset_assertion);

    property enable_increment;
        @(posedge clk) ~reset && ena |=> ##1 result == result_wire + 1;
    endproperty
    assert property (enable_increment);

    property disable_no_change;
        @(posedge clk) ~reset && !ena |-> ##1 result == result_wire;
    endproperty
    assert property (disable_no_change);

    property overflow_check;
        @(posedge clk) result == 8'hFF |-> ##1 reset || result == 8'h0;
    endproperty
    assert property (overflow_check);
endmodule