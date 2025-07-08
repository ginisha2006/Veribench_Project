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

    // Reset assertion
    property p_reset_behavior;
        @(posedge clk) disable iff (!rst)
            data_out == 8'h00;
    endproperty
    assert property (p_reset_behavior);

    // Data out should reflect data_in after some cycles when reset is deasserted
    property p_data_transfer;
        @(posedge clk) disable iff (rst)
            ##[1:$] (data_out == data_in);
    endproperty
    assert property (p_data_transfer);

endmodule