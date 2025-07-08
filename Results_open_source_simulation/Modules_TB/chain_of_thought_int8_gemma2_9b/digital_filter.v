module digital_filter_tb(
  );

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
    
    $monitor("Time: %t clk=%b data_in=%h data_out=%h", $time, clk, data_in, data_out);
    
    data_in = 16'h0001;
    #100;
    data_in = 16'hFFFF;
    #100;
    data_in = 16'h0000;
    #100;
  end

endmodule