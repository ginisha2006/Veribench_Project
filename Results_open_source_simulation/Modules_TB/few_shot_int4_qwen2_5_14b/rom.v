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
    
    // Initialize address
    addr = 0;
    
    // Loop through all addresses to read from ROM
    repeat ((1<<ADDR_WIDTH)) begin
        #10 addr = addr + 1;
    end
    
    // Finish the simulation
    $finish;
end
endmodule