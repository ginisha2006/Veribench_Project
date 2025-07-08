module ram_simple_tb;

  reg clk;
  reg we;
  reg [7:0] addr;
  reg [7:0] data_in;
  wire [7:0] data_out;

  ram_simple dut (
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
    #10 addr = 1;
    data_in = 8'hBB;
    #10 addr = 0;
    #10 $display("Data out: %h", data_out);
    $finish;
  end

endmodule