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
// Instantiate the True Dual-Port RAM
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
    // Initialize the clock
    clk = 0;
    forever #5 clk = ~clk;
    // Display the header for the output
    $display("Time	data_a	addr_a	data_b	addr_b	q_a	q_b");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%h	%b	%h	%b	%b", $time, data_a, addr_a, data_b, addr_b, q_a, q_b);
    // Test Case 1: Write to Port A
    data_a = 16'h1234; addr_a = 6'd0; we_a = 1; we_b = 0; #20;
    // Read from Port A
    data_a = 8'hz; addr_a = 6'd0; we_a = 0; we_b = 0; #20;
    // Test Case 2: Write to Port B
    data_b = 16'h5678; addr_b = 6'd1; we_a = 0; we_b = 1; #20;
    // Read from Port B
    data_b = 8'hz; addr_b = 6'd1; we_a = 0; we_b = 0; #20;
    // Test Case 3: Write to both ports
    data_a = 16'h9abc; addr_a = 6'd2; we_a = 1; we_b = 1; #20;
    // Read from both ports
    data_a = 8'hz; addr_a = 6'd2; we_a = 0; we_b = 0; #20;
    data_b = 8'hz; addr_b = 6'd2; we_a = 0; we_b = 0; #20;
    // Finish the simulation
    $finish;
end
endmodule