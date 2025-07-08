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
    $monitor("Time: %t, addr=%b, we=%b, data_in=%b, data_out=%b", $time, addr, we, data_in, data_out);
    addr = 0;
    data_in = 8'hAA;
    we = 1;
    #10;
    addr = 1;
    data_in = 8'hBB;
    we = 1;
    #10;
    addr = 0;
    we = 0;
    #10;
    $display("Read back value at address 0: %b", data_out);
    addr = 1;
    we = 0;
    #10;
    $display("Read back value at address 1: %b", data_out);
  end

endmodule