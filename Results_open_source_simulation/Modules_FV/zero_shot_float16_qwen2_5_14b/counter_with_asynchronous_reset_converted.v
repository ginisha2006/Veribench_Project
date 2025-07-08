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
    assert (@(posedge clk) disable iff (!reset)
            reset |-> result == 8'b0);

    assert (@(posedge clk) disable iff (!ena)
            ena ##1 !ena |=> result[7:0] inside {[1:254]});

    assert (@(posedge clk) disable iff (!ena || reset)
            result == 8'd255 |-> !(ena && !reset) |-> result == 8'd0);

    assert (@(posedge clk) disable iff (!ena || reset)
            result == 8'd0 |-> !(ena && !reset) |-> result == 8'd1);

    assert (@(posedge clk) disable iff (!ena || reset)
            ena |-> result == result[7:0] + 1);

endmodule