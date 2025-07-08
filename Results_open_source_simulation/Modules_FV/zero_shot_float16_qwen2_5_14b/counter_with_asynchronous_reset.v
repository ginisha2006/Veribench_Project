module tb_counter (
    input clk,
    input reset,
    input ena,
    output reg [7:0] result
);
    
    // DUT instantiation
    counter dut (
        .clk(clk),
        .reset(reset),
        .ena(ena),
        .result(result)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Properties
    property p_reset;
        @(posedge clk) disable iff (!reset)
            reset |-> result == 8'b0;
    endproperty
    assert property(p_reset);

    property p_enable;
        @(posedge clk) disable iff (!ena)
            ena ##1 !ena |=> result[7:0] inside {[1:254]};
    endproperty
    assert property(p_enable);

    property p_overflow;
        @(posedge clk) disable iff (!ena || reset)
            result == 8'd255 |-> !(ena && !reset) |-> result == 8'd0;
    endproperty
    assert property(p_overflow);

    property p_underflow;
        @(posedge clk) disable iff (!ena || reset)
            result == 8'd0 |-> !(ena && !reset) |-> result == 8'd1;
    endproperty
    assert property(p_underflow);

    property p_increment;
        @(posedge clk) disable iff (!ena || reset)
            ena |-> result == result[7:0] + 1;
    endproperty
    assert property(p_increment);

endmodule