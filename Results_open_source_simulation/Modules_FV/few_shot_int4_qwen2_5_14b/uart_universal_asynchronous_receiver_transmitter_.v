module tb_uart_module #(
    parameter BAUD_RATE = 9600
)();

    // Inputs
    reg clk, rst, rx;
    reg [7:0] data_in;

    // Outputs
    wire tx;
    wire [7:0] data_out;

    // Instantiate the DUT
    uart_module #(.BAUD_RATE(BAUD_RATE)) UUT (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .tx(tx),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation for properties
    initial clk = 0;
    always #5 clk = ~clk;

    // Properties

    // Property: Ensure reset clears outputs
    property p_reset_clears_outputs;
        @(posedge rst) disable iff (!rst)
            !rst |-> (data_out === 8'b0 && tx === 1'b1);
    endproperty
    assert property (p_reset_clears_outputs);

    // Property: Ensure tx is high when idle
    property p_tx_idle_high;
        @(posedge clk) disable iff (!rst)
            !rx |-> tx === 1'b1;
    endproperty
    assert property (p_tx_idle_high);

    // Property: Ensure data_out is valid after transmission
    property p_data_valid_after_transmission;
        @(posedge clk) disable iff (!rst)
            $rose(rx) |-> ##[BAUD_RATE*4:BAUD_RATE*4+3] data_out !== 8'bZ;
    endproperty
    assert property (p_data_valid_after_transmission);

endmodule