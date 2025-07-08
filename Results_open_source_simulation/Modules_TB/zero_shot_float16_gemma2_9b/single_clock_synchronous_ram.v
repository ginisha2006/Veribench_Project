module ram_infer_tb;

  reg clk;
  reg we;
  reg [5:0] read_addr;
  reg [5:0] write_addr;
  reg [7:0] data;
  wire [7:0] q;

  ram_infer dut (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .we(we),
    .clk(clk),
    .q(q)
  );

  initial begin
    clk = 0; forever #5 clk = ~clk;
  end

  initial begin
    we = 0;
    read_addr = 0;
    write_addr = 0;
    data = 8'b00000001;
    #10 we = 1;
    #10 we = 0;
    read_addr = 0;
    #10 $display("q = %h", q);
    write_addr = 1;
    data = 8'b11111111;
    #10 we = 1;
    #10 we = 0;
    read_addr = 1;
    #10 $display("q = %h", q);
    $finish;
  end

endmodule