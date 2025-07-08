module rom_simple_tb;
  reg [7:0] addr;
  wire [7:0] data_out;
  rom_simple #(DATA_WIDTH=8, ADDR_WIDTH=8) dut (
    .addr(addr),
    .data_out(data_out)
  );
  initial begin
    $dumpfile("rom_sim.vcd");
    $dumpvars(0, rom_simple_tb);
    addr = 0;
    #10;
    addr = 1;
    #10;
    addr = 255;
    #10;
    addr = 0;
    #10;
    $finish;
  end
  always #5 addr = addr + 1;
  initial begin
    $monitor("addr=%b, data_out=%b", addr, data_out);
  end
endmodule