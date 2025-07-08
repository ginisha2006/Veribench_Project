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
    #10 addr = 1;
    #10 addr = 63;
    #10 addr = 127;
    #10 addr = 255;
    #10 $finish;
  end
  always @(posedge addr)
    $monitor("addr=%h, data_out=%h", addr, data_out);
endmodule