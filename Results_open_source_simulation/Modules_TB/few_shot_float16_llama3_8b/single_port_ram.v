module tb_single_port_ram;
// Inputs
reg [7:0] data;
reg [5:0] addr;
reg we;
reg clk;
// Output
wire [7:0] q;
// Initialize the RAM
reg [7:0] ram[63:0];
integer i;
initial begin
    for(i=0; i<64; i++) ram[i] = 0;
    // Clock
    clk = 0;
    forever #5 clk = ~clk;
    // Display the header for the output
    $display("Time	data	addr	we	q");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, data, addr, we, q);
    // Test Case 1: Write data at address 0
    data = 16; addr = 0; we = 1; #20;
    data = 32; addr = 0; we = 1; #20;
    // Test Case 2: Read from address 0
    addr = 0; we = 0; #20;
    // Test Case 3: Write data at address 31
    data = 48; addr = 31; we = 1; #20;
    // Test Case 4: Read from address 31
    addr = 31; we = 0; #20;
    // Test Case 5: Write data at address 15
    data = 64; addr = 15; we = 1; #20;
    // Test Case 6: Read from address 15
    addr = 15; we = 0; #20;
    // Finish the simulation
    $finish;
end
endmodule