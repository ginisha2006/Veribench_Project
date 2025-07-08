module ram_separate_io_tb;
  reg clk;
  reg we;
  reg [7:0] addr;
  reg [7:0] data_in;
  wire [7:0] data_out;

  ram_separate_io #(
    .DATA_WIDTH(8),
    .ADDR_WIDTH(8)
  ) dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    addr = 0;
    data_in = 8'hAA;
    we = 1;
    #10;
    we = 0;
    #10;
    addr = 1;
    data_in = 8'hBB;
    we = 1;
    #10;
    we = 0;
    #10;
    addr = 0;
    we = 0;
    $monitor("addr=%b, data_in=%h, data_out=%h", addr, data_in, data_out);
  end
endmodule