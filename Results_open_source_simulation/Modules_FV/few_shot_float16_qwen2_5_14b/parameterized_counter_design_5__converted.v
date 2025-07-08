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
    always @(*) begin assert (@(posedge clk) (rst && !$past(rst)) |-> count == 0); end

    // Property: Count increments correctly until it reaches MAX_COUNT
    assert (@(posedge clk) disable iff (rst)
            (count < MAX_COUNT - 1) |=> count[$clog2(MAX_COUNT)] === 1'b0 && count == count[($clog2(MAX_COUNT)-1):0] + 1);

    // Property: When count reaches MAX_COUNT, it resets to zero
    assert (@(posedge clk) disable iff (rst)
            (count == MAX_COUNT) |-> count == 0);

endmodule