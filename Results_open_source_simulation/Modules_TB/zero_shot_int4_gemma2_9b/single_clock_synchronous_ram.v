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
    // Stimulus
    data = 8'hAA;
    write_addr = 6'h00;
    we = 1;
    #10;
    data = 8'hBB;
    write_addr = 6'h10;
    we = 1;
    #10;
    read_addr = 6'h00;
    we = 0;
    #10;
    read_addr = 6'h10;
    we = 0;
    #10;
    $finish;
  end

  always @(posedge clk) begin
    $monitor("Time: %t, clk: %b, data: %h, read_addr: %h, write_addr: %h, we: %b, q: %h", $time, clk, data, read_addr, write_addr, we, q);
  end

endmodule