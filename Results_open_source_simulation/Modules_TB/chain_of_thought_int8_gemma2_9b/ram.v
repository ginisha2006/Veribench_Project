module ram_simple_tb #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 8);
  reg clk;
  reg we;
  reg [ADDR_WIDTH-1:0] addr;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;
  ram_simple dut (clk, we, addr, data_in, data_out);

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    we = 0;
    addr = 0;
    data_in = 0;
    #10;
    we = 1;
    data_in = 8'hAA;
    addr = 0;
    #10;
    we = 0;
    addr = 0;
    #10;
    we = 1;
    data_in = 8'hBB;
    addr = 1;
    #10;
    we = 0;
    addr = 1;
    #10;
    we = 1;
    data_in = 8'hCC;
    addr = 2;
    #10;
    we = 0;
    addr = 2;
    #10;
    $display("Data out: %h", data_out);
    $finish;
  end

endmodule