module tb_param_counter #(
    parameter MAX_COUNT = 255
)();

    // Inputs
    reg clk;
    reg rst;

    // Output
    wire [($clog2(MAX_COUNT+1))-1:0] count;

    // Instantiate the DUT
    param_counter #(.MAX_COUNT(MAX_COUNT)) UUT (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    // Clock generation for properties
    initial clk = 0;
    always #5 clk = ~clk;

    // Properties

    // Property: Reset should set count to zero
    property p_reset_to_zero;
        @(posedge clk) (rst && !$past(rst)) |-> count == 0;
    endproperty
    assert property (p_reset_to_zero);

    // Property: Count increments correctly until it reaches MAX_COUNT
    property p_count_increment;
        @(posedge clk) disable iff (rst)
            (count < MAX_COUNT - 1) |=> count[$clog2(MAX_COUNT)] === 1'b0 && count == count[($clog2(MAX_COUNT)-1):0] + 1;
    endproperty
    assert property (p_count_increment);

    // Property: When count reaches MAX_COUNT, it resets to zero
    property p_wraparound;
        @(posedge clk) disable iff (rst)
            (count == MAX_COUNT) |-> count == 0;
    endproperty
    assert property (p_wraparound);

endmodule