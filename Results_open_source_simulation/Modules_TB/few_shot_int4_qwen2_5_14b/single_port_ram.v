module tb_single_port_ram;
// Inputs
reg [7:0] data;
reg [5:0] addr;
reg we, clk;
// Outputs
wire [7:0] q;
// Instantiate the Single Port RAM
single_port_ram uut (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk),
    .q(q)
);
initial begin
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    // Display the header for the output
    $display("Time	data	addr	q	we");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, data, addr, q, we);
    // Reset signals
    data = 8'h00;
    addr = 6'h00;
    we   = 0;
    #10;
    // Test case 1: Write to address 0 with data 0x0A
    data = 8'h0A; addr = 6'h00; we = 1; #10;
    // Test case 2: Read from address 0 after write
    we = 0; #10;
    // Test case 3: Write to address 1 with data 0x1B
    data = 8'h1B; addr = 6'h01; we = 1; #10;
    // Test case 4: Read from address 1 after write
    we = 0; #10;
    // Test case 5: Write to address 31 with data 0xFF
    data = 8'hFF; addr = 6'h1F; we = 1; #10;
    // Test case 6: Read from address 31 after write
    we = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule