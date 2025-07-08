module tb_param_counter();
    // Clock and reset signals
    reg clk = 0;
    reg rst = 0;

    // DUT instantiation
    param_counter dut (
       .clk(clk),
       .rst(rst),
       .count(count)
    );

    // Test variables
    integer i;
    reg [7:0] expected_count;

    initial begin
        #10; // Wait for 10 clock cycles before starting the test
        rst = 1; // Reset the counter
        #20; // Wait for 20 clock cycles after reset
        rst = 0; // Release the reset

        for (i = 0; i < 8; i++) begin
            #100; // Wait for 100 clock cycles
            $display($sformatf("Count: %h", count));
            if (i == 0) begin
                expected_count = 0;
            end else begin
                expected_count = expected_count + 1;
            end
            assert(count == expected_count);
        end

        #100; // Wait for 100 clock cycles
        $display("Final Count: %h", count);

        #100; // Wait for 100 clock cycles
        rst = 1; // Reset the counter again
        #20; // Wait for 20 clock cycles after reset
        $display("Final Count after reset: %h", count);
    end

    always #5 clk = ~clk; // Generate a clock signal with a period of 10 clock cycles

    $monitor($time, "clk=%b, rst=%b, count=%h", clk, rst, count);

endmodule