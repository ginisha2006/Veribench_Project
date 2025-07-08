module tb_ram_infer;
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
    clk = 0; forever #5 clk = ~clk; end

  initial begin
    $display("Time\t clk\t we\t read_addr\t write_addr\t data\t q");
    // Test Cases
    we = 0; read_addr = 0; write_addr = 0; data = 8'hAA; #10;
    we = 1; read_addr = 0; write_addr = 0; data = 8'hBB; #10;
    we = 0; read_addr = 0; write_addr = 0; data = 8'hCC; #10;
    we = 1; read_addr = 1; write_addr = 1; data = 8'hDD; #10;
    we = 0; read_addr = 1; write_addr = 1; data = 8'hEE; #10;
    $finish;
  end

endmodule