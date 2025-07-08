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
    $display("Time	Addr	Data Out");
    // Monitor changes to address and data out
    $monitor("%0d	%b	%b", $time, addr, data_out);
    // Test all possible addresses
    for (int i = 0; i < (1 << ADDR_WIDTH); i++) begin
        addr = i;
        #10;
    end
    // Finish the simulation
    $finish;
end
endmodule