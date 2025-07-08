module tb_rom_simple;
// Parameters
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;
// Input
reg [ADDR_WIDTH-1:0] addr;
// Output
wire [DATA_WIDTH-1:0] data_out;
// Instantiate the ROM
rom_simple #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) uut (
    .addr(addr),
    .data_out(data_out)
);
initial begin
    // Display the header for the output
    $display("Address	Data Out");
    // Monitor changes to address and data out
    $monitor("%d	%b", addr, data_out);
    // Test all addresses from 0 to 255
    for (addr = 0; addr < (1 << ADDR_WIDTH); addr = addr + 1) begin
        #10;
    end
    // Finish the simulation
    $finish;
end
endmodule