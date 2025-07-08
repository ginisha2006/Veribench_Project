module ram_infer_tb;

  reg [7:0] data;
  reg [5:0] read_addr, write_addr;
  reg we, clk;
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
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $monitor("Time: %t clk=%b we=%b read_addr=%b write_addr=%b data=%b q=%b", $time, clk, we, read_addr, write_addr, data, q);
    data = 8'h00;
    write_addr = 6'h00;
    we = 1;
    #10;
    data = 8'hFF;
    write_addr = 6'h10;
    we = 1;
    #10;
    read_addr = 6'h00;
    #10;
    read_addr = 6'h10;
    #10;
    we = 0;
    #10;
  end

endmodule