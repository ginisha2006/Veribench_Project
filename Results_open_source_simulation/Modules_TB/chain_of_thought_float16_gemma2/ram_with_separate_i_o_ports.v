module ram_separate_io_tb;

  reg clk;
  reg we;
  reg [7:0] addr;
  reg [7:0] data_in;
  wire [7:0] data_out;

  ram_separate_io dut (
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
    we = 0;
    addr = 0;
    data_in = 8'hAA;
    #10 we = 1;
    #10 we = 0;
    addr = 1;
    data_in = 8'hBB;
    #10 we = 1;
    #10 we = 0;
    addr = 2;
    data_in = 8'hCC;
    #10 we = 1;
    #10 we = 0;
    $finish;
  end

  initial begin
    $monitor("Time: %t, addr=%b, we=%b, data_in=%h, data_out=%h", $time, addr, we, data_in, data_out);
  end

endmodule