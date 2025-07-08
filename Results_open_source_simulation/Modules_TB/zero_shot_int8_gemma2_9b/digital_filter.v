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
    $monitor("Time: %t clk=%b data_in=%h data_out=%h", $time, clk, data_in, data_out);
    data_in = 16'hAAAA;
    #100;
    data_in = 16'hBBBB;
    #100;
    data_in = 16'hCCCC;
    #100;
    $finish;
  end

  initial begin
    coeff[0] = 16'hAAAA;
    coeff[1] = 16'hBBBB;
    coeff[2] = 16'hCCCC;
    // ... assign remaining coefficients
  end

endmodule