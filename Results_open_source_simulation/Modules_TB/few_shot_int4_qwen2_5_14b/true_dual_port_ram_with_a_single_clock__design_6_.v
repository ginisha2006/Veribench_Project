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
    $display("Time	data_a	data_b	addr_a	addr_b	we_a	we_b	q_a	q_b");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%d	%d	%b	%b	%b	%b", $time, data_a, data_b, addr_a, addr_b, we_a, we_b, q_a, q_b);
    
    // Initialize signals
    clk = 0;
    forever #5 clk = ~clk; // Generate clock
    
    // Test case 1: Write to port A then read from port B
    data_a = 8'hAA; addr_a = 6'd1; we_a = 1; #10;
    we_a = 0; addr_b = 6'd1; we_b = 0; #10;
    
    // Test case 2: Write to port B then read from port A
    data_b = 8'hBB; addr_b = 6'd2; we_b = 1; #10;
    we_b = 0; addr_a = 6'd2; we_a = 0; #10;
    
    // Test case 3: Concurrent write to both ports
    data_a = 8'hCC; data_b = 8'hDD; we_a = 1; we_b = 1; #10;
    we_a = 0; we_b = 0; #10;
    
    // Test case 4: Read from different addresses simultaneously
    addr_a = 6'd1; addr_b = 6'd2; we_a = 0; we_b = 0; #10;
    
    // Test case 5: Overwrite previous value in port A
    data_a = 8'hEE; addr_a = 6'd1; we_a = 1; #10;
    we_a = 0; addr_b = 6'd1; we_b = 0; #10;
    
    // Finish the simulation
    $finish;
end
endmodule