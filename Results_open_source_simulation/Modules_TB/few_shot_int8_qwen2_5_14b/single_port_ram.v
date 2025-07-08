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
    // Clock generation
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    // Display the header for the output
    $display("Time	data	addr	we	q");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%d	%b	%b", $time, data, addr, we, q);
    // Initialize signals
    data = 8'h00;
    addr = 6'h00;
    we = 0;
    // Apply clock delay
    #10;
    // Test case 1: Write 0x0A at address 0x00
    data = 8'h0A;
    addr = 6'h00;
    we = 1;
    #10;
    // Read from address 0x00
    we = 0;
    #10;
    // Test case 2: Write 0x1F at address 0x0F
    data = 8'h1F;
    addr = 6'h0F;
    we = 1;
    #10;
    // Read from address 0x0F
    we = 0;
    #10;
    // Test case 3: Write 0xFF at address 0x3F
    data = 8'hFF;
    addr = 6'h3F;
    we = 1;
    #10;
    // Read from address 0x3F
    we = 0;
    #10;
    // Finish the simulation
    $finish;
end
endmodule