module ram_simple_tb #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
);

  reg clk;
  reg we;
  reg [ADDR_WIDTH-1:0] addr;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;

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
    addr = 0;
    data_in = 0;
    we = 0;
    #10;
    we = 1;
    data_in = 1'b1;
    #10;
    addr = 1;
    data_in = 2'b10;
    #10;
    addr = 2;
    data_in = 3'b110;
    #10;
    we = 0;
    addr = 0;
    #10;
    $display("Data out at address 0: %h", data_out);
    addr = 1;
    #10;
    $display("Data out at address 1: %h", data_out);
    addr = 2;
    #10;
    $display("Data out at address 2: %h", data_out);
  end

endmodule