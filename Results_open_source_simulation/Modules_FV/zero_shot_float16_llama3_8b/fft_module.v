module tb_fft_module;
    import uvm_pkg::*;
    import svu_pkg::*;

    parameter DATA_WIDTH = 16;
    parameter FFT_POINTS = 1024;

    reg clk;
    reg rst;
    reg start;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    wire done;

    fft_module #(.DATA_WIDTH(DATA_WIDTH),.FFT_POINTS(FFT_POINTS)) dut (
       .clk(clk),
       .rst(rst),
       .start(start),
       .data_in(data_in),
       .data_out(data_out),
       .done(done)
    );

    property p_clk_period;
        @(posedge clk) disable iff (!rst) ##[10:0] @(negedge clk);
    endproperty

    property p_reset_assertion;
       !rst |=> ($stable(rst) && $rose(rst));
    endproperty

    property p_start_assertion;
        start |=> (!$stable(start) && $fell(start));
    endproperty

    property p_data_in_range;
       ![DATA_WIDTH-1:0] data_in < 2**DATA_WIDTH - 1;
    endproperty

    property p_data_out_range;
       ![DATA_WIDTH-1:0] data_out < 2**DATA_WIDTH - 1;
    endproperty

    property p_done_assertion;
        done |=> (!$stable(done) && $rose(done));
    endproperty

    assert property (p_clk_period);
    assert property (p_reset_assertion);
    assert property (p_start_assertion);
    assert property (p_data_in_range);
    assert property (p_data_out_range);
    assert property (p_done_assertion);

    always #5 clk = ~clk; // Clock generation

    initial begin
        rst = 1'b1;
        repeat (10) @(posedge clk); // Wait for 10 clock cycles
        rst = 1'b0;
        start = 1'b1;
        repeat (100) @(posedge clk); // Run the DUT for 100 clock cycles
        start = 1'b0;
    end

endmodule