module tb_rom_simple;
// Parameters
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;
// Inputs
reg [ADDR_WIDTH-1:0] addr;
// Output
wire [DATA_WIDTH-1:0] data_out;
// Instantiate the Simple ROM
rom_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) uut (
   .addr(addr), 
   .data_out(data_out)
);
initial begin
    // Initialize the address counter
    addr = 0;
    // Read from the ROM
    $display("Address	Data");
    forever begin
        #10;
        $display("%h	%h", addr, data_out);
        addr = addr + 1;
        if (addr >= (1 << ADDR_WIDTH) - 1) addr = 0;
    end
end
endmodule