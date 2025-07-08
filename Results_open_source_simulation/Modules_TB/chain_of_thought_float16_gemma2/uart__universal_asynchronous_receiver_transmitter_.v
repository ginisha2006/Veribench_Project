module uart_tb;

  reg clk;
  reg rst;
  reg rx;
  wire tx;
  reg [7:0] data_in;
  wire [7:0] data_out;

  uart_module dut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .tx(tx),
    .data_in(data_in),
    .data_out(data_out)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;
  end

  initial begin
    data_in = 8'h01;
    #10 data_in = 8'hFF;
    #10 data_in = 8'hAA;
    #10 data_in = 8'h00;
  end

  initial begin
    rx = 0;
    #10 rx = 1;
    #10 rx = 0;
  end

  always @(posedge clk) begin
    $monitor("clk=%b, rst=%b, rx=%b, tx=%b, data_in=%h, data_out=%h", clk, rst, rx, tx, data_in, data_out);
  end

endmodule