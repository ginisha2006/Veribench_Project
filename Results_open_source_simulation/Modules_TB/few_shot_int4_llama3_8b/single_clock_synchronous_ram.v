module tb_ram_infer;
// Input signals
reg [7:0] data;
reg [5:0] read_addr;
reg [5:0] write_addr;
reg we;
reg clk;
// Output signal
wire [7:0] q;
// Initialize the RAM
reg [7:0] ram[63:0];
integer i;
initial begin
    // Initialize the RAM with some values
    for(i=0; i<64; i=i+1) begin
        ram[i] = i % 256;
    end
    // Set the clock period
    #100;
    // Toggle the clock
    forever begin
        clk = ~clk;
        #10;
    end
    // Test the RAM
    // Read from address 0
    read_addr = 0; write_addr = 0; data = 0; we = 1; #20;
    // Read from address 15
    read_addr = 15; write_addr = 15; data = 0; we = 0; #20;
    // Write to address 31
    read_addr = 31; write_addr = 31; data = 128; we = 1; #20;
    // Read from address 31
    read_addr = 31; write_addr = 0; data = 0; we = 0; #20;
    // Read from address 63
    read_addr = 63; write_addr = 63; data = 0; we = 0; #20;
    // Finish the simulation
    $finish;
end
endmodule