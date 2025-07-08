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
    // Apply initial reset condition
    @(negedge clk);
    // Test write operation
    data = 8'hAA; addr = 6'h0F; we = 1; @(negedge clk); we = 0; @(negedge clk);
    // Test read operation from previously written address
    addr = 6'h0F; we = 0; @(negedge clk);
    // Test writing to different addresses
    data = 8'hBB; addr = 6'h1E; we = 1; @(negedge clk); we = 0; @(negedge clk);
    // Read back multiple values
    addr = 6'h0F; we = 0; @(negedge clk);
    addr = 6'h1E; we = 0; @(negedge clk);
    // Finish the simulation
    $finish;
end
endmodule