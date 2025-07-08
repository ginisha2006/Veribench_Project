module digital_filter_tb;

  reg clk;
  reg rst;
  reg [15:0] data_in;
  wire [15:0] data_out;
  reg [15:0] coeff [31:0];

  digital_filter dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .coeff(coeff)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;
    // Add your stimulus here
  end

  initial begin
    $monitor("Time: %t clk=%b rst=%b data_in=%h data_out=%h", $time, clk, rst, data_in, data_out);
  end

endmodule