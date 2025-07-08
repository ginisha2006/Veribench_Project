module mod_demod_tb;
parameter DATA_WIDTH = 16;

reg clk;
reg rst;
wire [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] modulated_signal;
wire [DATA_WIDTH-1:0] demodulated_data;

initial begin
    #10; // delay for setup
    rst = 1'b1; // reset
    repeat(2) @(posedge clk); // wait for two clock cycles
    rst = 1'b0; // release reset
    #20; // delay for settling down

    // Test with all possible combinations of data_in bits
    for (int i = 0; i < (1 << DATA_WIDTH); i++) begin
        data_in = i;
        #10; // delay for data change
        @(posedge clk);
        $display("Data In: %h, Modulated Signal: %h, Demodulated Data: %h", data_in, modulated_signal, demodulated_data);
    end
end

always #5 clk = ~clk; // generate clock

initial begin
    clk = 1'b0; // initialize clock
    rst = 1'b1; // initialize reset
    #10; // delay for setup
    repeat(100) @(posedge clk); // run for some time
    $finish; // stop simulation
end

$monitor("Time: %t, clk: %b, rst: %b, data_in: %h, modulated_signal: %h, demodulated_data: %h",
         "Time", clk, rst, data_in, modulated_signal, demodulated_data);

endmodule