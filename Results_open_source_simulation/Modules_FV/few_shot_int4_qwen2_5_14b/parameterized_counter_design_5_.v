module tb_param_counter #(
    parameter MAX_COUNT = 255
)();

    // Inputs
    reg clk;
    reg rst;

    // Output
    wire [$clog2(MAX_COUNT+1)-1:0] count;

    // Instantiate the DUT
    param_counter #(.MAX_COUNT(MAX_COUNT)) UUT (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    // Clock generation for properties
    initial clk = 0;
    always #5 clk = ~clk;

    // Property: Reset should set count to zero
    property p_reset_to_zero;
        @(posedge rst) (rst |-> count === 0);
    endproperty
    assert property (p_reset_to_zero);

    // Property: Count should increment correctly
    property p_count_increment;
        @(posedge clk) disable iff (!rst)
            (count < MAX_COUNT - 1 |-> $rose(count) ##1 count == count + 1);
    endproperty
    assert property (p_count_increment);

    // Property: Count should reset after reaching MAX_COUNT
    property p_count_wraparound;
        @(posedge clk) disable iff (!rst)
            (count == MAX_COUNT |-> $rose(count) ##1 count === 0);
    endproperty
    assert property (p_count_wraparound);

endmodule