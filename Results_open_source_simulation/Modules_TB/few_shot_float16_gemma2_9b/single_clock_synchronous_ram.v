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
    clk = 0; forever #5 clk = ~clk;
  end

  initial begin
    $display("Time\t clk\t we\t write_addr\t data\t read_addr\t q");
    #10; // Initial delay
    // Test Cases
    we = 1; write_addr = 0; data = 8'hAA; read_addr = 0; #10;
    we = 1; write_addr = 10; data = 8'hBB; read_addr = 0; #10;
    we = 0; read_addr = 0; #10;
    we = 0; read_addr = 10; #10;
    we = 1; write_addr = 20; data = 8'hCC; read_addr = 20; #10;
    we = 0; read_addr = 20; #10;
    $finish;
  end

endmodule