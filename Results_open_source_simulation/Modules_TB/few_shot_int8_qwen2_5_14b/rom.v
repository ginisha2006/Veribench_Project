module tb_rom_simple;
// Parameters
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

// Inputs
reg [ADDR_WIDTH-1:0] addr;

// Outputs
wire [DATA_WIDTH-1:0] data_out;

// Instantiate the ROM module
rom_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) uut (
    .addr(addr),
    .data_out(data_out)
);

initial begin
    // Display the header for the output
    $display("Time	addr	data_out");

    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b", $time, addr, data_out);

    // Apply various addresses to read from the ROM
    addr = 0; #10;
    addr = 1; #10;
    addr = 2; #10;
    addr = 3; #10;
    addr = 4; #10;
    addr = 5; #10;
    addr = 6; #10;
    addr = 7; #10;
    addr = 8'd10; #10;
    addr = 8'd15; #10;
    addr = 8'hFF; #10;

    // Finish the simulation
    $finish;
end
endmodule