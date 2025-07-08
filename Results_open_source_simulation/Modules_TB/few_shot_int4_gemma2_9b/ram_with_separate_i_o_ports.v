module tb_ram_separate_io;
  // Parameters
  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;
  // Clock
  reg clk;
  // Inputs
  reg we;
  reg [ADDR_WIDTH-1:0] addr;
  reg [DATA_WIDTH-1:0] data_in;
  // Outputs
  wire [DATA_WIDTH-1:0] data_out;
  // Instantiate the RAM
  ram_separate_io #(
      .DATA_WIDTH(DATA_WIDTH),
      .ADDR_WIDTH(ADDR_WIDTH)
  ) uut (
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
    // Initialize write pattern
    data_in = 0;
    addr = 0;
    we = 1;
    #10;
    data_in = 1;
    addr = 1;
    we = 1;
    #10;
    data_in = 2;
    addr = 2;
    we = 1;
    #10;
    // Read back values
    addr = 0;
    we = 0;
    #10;
    $display("Data at address 0: %h", data_out);
    addr = 1;
    we = 0;
    #10;
    $display("Data at address 1: %h", data_out);
    addr = 2;
    we = 0;
    #10;
    $display("Data at address 2: %h", data_out);
    $finish;
  end
endmodule