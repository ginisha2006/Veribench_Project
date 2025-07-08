module mod_demod_tb;

  reg clk;
  reg rst;
  reg [15:0] data_in;
  wire [15:0] modulated_signal;
  wire [15:0] demodulated_data;

  mod_demod #(
    .DATA_WIDTH(16)
  ) dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .modulated_signal(modulated_signal),
    .demodulated_data(demodulated_data)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;
    data_in = 16'hAAAA;
    #10 data_in = 16'h5555;
    #10 data_in = 16'h0000;
    #10 $finish;
  end

  always @(posedge clk) begin
    $monitor("Time: %t ns, data_in: %h, modulated_signal: %h, demodulated_data: %h", $time, data_in, modulated_signal, demodulated_data);
  end

endmodule