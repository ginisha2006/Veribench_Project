module param_shift_reg_tb;

  reg clk;
  reg rst;
  reg load;
  reg [7:0] data_in;
  wire [7:0] data_out;

  param_shift_reg dut (
    .clk(clk),
    .rst(rst),
    .load(load),
    .data_in(data_in),
    .data_out(data_out)
  );

  initial begin
    clk = 0; forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;
    load = 0;
    data_in = 8'b00001111;
    #10 load = 1;
    #10 data_in = 8'b11110000;
    #10 load = 1;
    #10 $finish;
  end

  initial begin
    $monitor("Time: %t clk=%b rst=%b load=%b data_in=%h data_out=%h", $time, clk, rst, load, data_in, data_out);
  end

endmodule