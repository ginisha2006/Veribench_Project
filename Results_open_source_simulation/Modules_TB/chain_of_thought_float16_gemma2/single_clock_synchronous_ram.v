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
    clk = 0; forever #5 clk = ~clk;
  end

  initial begin
    data = 8'b00000001;
    write_addr = 6'b000001;
    we = 1;
    #10;
    data = 8'b11111111;
    write_addr = 6'b000010;
    we = 1;
    #10;
    read_addr = 6'b000001;
    $display("Read Data: %h", q);
    #10;
    read_addr = 6'b000010;
    $display("Read Data: %h", q);
    #10;
    we = 0;
    read_addr = 6'b000001;
    $display("Read Data: %h", q);
    #10;
    read_addr = 6'b000010;
    $display("Read Data: %h", q);
    #10;
  end

endmodule