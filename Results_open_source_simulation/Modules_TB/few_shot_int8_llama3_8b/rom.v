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
    integer i;
    for (i=0; i<(1<<ADDR_WIDTH); i=i+1) begin
        $display($sformatf("Address %d:", i));
        addr = i; #100;
        $display("Data Out: %h", data_out);
    end
    // Finish the simulation
    $finish;
end
endmodule