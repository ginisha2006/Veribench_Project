module tb_rom_simple;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg rst_n;
wire [DATA_WIDTH-1:0] data_out;
wire [ADDR_WIDTH-1:0] addr;

rom_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) uut (
   .addr(addr),
   .data_out(data_out)
);

initial begin
    $display("Starting testbench...");
    #100; // wait for 100 ns

    // Reset sequence
    rst_n <= 0;
    #10;
    rst_n <= 1;

    // Read from address 0
    addr <= 0;
    #10;
    $display($sformatf("Read from address 0: %h", data_out));

    // Read from address 7
    addr <= 7;
    #10;
    $display($sformatf("Read from address 7: %h", data_out));

    // Read from address 15
    addr <= 15;
    #10;
    $display($sformatf("Read from address 15: %h", data_out));

    // Read from address 16 (out of bounds)
    addr <= 16;
    #10;
    $display($sformatf("Read from address 16: %h", data_out));

    // Read from address -1 (out of bounds)
    addr <= -1;
    #10;
    $display($sformatf("Read from address -1: %h", data_out));

    // Repeat read from address 0
    addr <= 0;
    #10;
    $display($sformatf("Read from address 0 again: %h", data_out));

    #100; // wait for 100 ns
    $display("Testbench complete.");
end

always #5 clk = ~clk;

initial begin
    clk = 1;
    forever #2.5 clk = ~clk;
end

$monitor($time, "clk=%b, rst_n=%b, addr=%h, data_out=%h", clk, rst_n, addr, data_out);

endmodule