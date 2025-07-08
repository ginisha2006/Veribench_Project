module tb_true_dpram_sclk;
// Inputs
reg [7:0] data_a;
reg [7:0] data_b;
reg [5:0] addr_a;
reg [5:0] addr_b;
reg we_a;
reg we_b;
reg clk;

// Outputs
wire [7:0] q_a;
wire [7:0] q_b;

// Instantiate the True Dual-Port RAM with a Single Clock
true_dpram_sclk uut (
    .data_a(data_a),
    .data_b(data_b),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .we_a(we_a),
    .we_b(we_b),
    .clk(clk),
    .q_a(q_a),
    .q_b(q_b)
);

initial begin
    // Display the header for the output
    $display("Time	data_a	addr_a	we_a	q_a	data_b	addr_b	we_b	q_b");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%d	%b	%b	%b	%d	%b	%b", $time, data_a, addr_a, we_a, q_a, data_b, addr_b, we_b, q_b);
    
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
    
    // Apply stimuli
    @(negedge clk)
    data_a = 8'hAA; addr_a = 6'h00; we_a = 1; @(negedge clk); // Write to address 0
    
    @(negedge clk)
    data_b = 8'hBB; addr_b = 6'h01; we_b = 1; @(negedge clk); // Write to address 1
    
    @(negedge clk)
    we_a = 0; addr_a = 6'h00; @(negedge clk); // Read from address 0
    
    @(negedge clk)
    we_b = 0; addr_b = 6'h01; @(negedge clk); // Read from address 1
    
    @(negedge clk)
    data_a = 8'hCC; addr_a = 6'h01; we_a = 1; @(negedge clk); // Overwrite address 1
    
    @(negedge clk)
    we_b = 0; addr_b = 6'h01; @(negedge clk); // Read overwritten value at address 1
    
    // Finish the simulation
    $finish;
end
endmodule