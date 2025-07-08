module tb_rom_simple;
// Parameter
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;
// Inputs
reg [ADDR_WIDTH-1:0] addr;
// Output
wire [DATA_WIDTH-1:0] data_out;
// Instantiate the ROM
rom_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) uut (
   .addr(addr), 
   .data_out(data_out)
);
initial begin
    // Display the header for the output
    $display("Time	addr	data_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b", $time, addr, data_out);
    // Read from ROM
    addr = 0; #10;
    addr = 1; #10;
    addr = 2; #10;
    addr = 255; #10;
    // Check if the ROM returns correct values
    // For example, assume the ROM contains the following data:
    // 0x00 -> 0x12
    // 0x01 -> 0x34
    //...
    // You can add more test cases as needed
    // Finish the simulation
    $finish;
end
endmodule