module rom_simple_tb;

  reg [7:0] addr;
  wire [7:0] data_out;

  rom_simple #(
    .DATA_WIDTH(8),
    .ADDR_WIDTH(8)
  ) dut (
    .addr(addr),
    .data_out(data_out)
  );

  initial begin
    $dumpfile("rom_sim.vcd");
    $dumpvars(0, rom_simple_tb);

    addr = 0;
    #10;
    $display("Addr: %h, Data: %h", addr, data_out);

    addr = 255;
    #10;
    $display("Addr: %h, Data: %h", addr, data_out);

    addr = 128;
    #10;
    $display("Addr: %h, Data: %h", addr, data_out);

    $finish;
  end

endmodule