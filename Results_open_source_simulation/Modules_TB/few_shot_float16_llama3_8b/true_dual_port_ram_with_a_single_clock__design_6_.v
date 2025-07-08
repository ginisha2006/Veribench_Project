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
    // Initialize the RAM
    for (int i = 0; i < 64; i++) begin
        ram[i] = 0;
    end
    // Display the header for the output
    $display("Time	data_a	addr_a	data_b	addr_b	q_a	q_b");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%x	%d	%x	%d	%x	%x", $time, data_a, addr_a, data_b, addr_b, q_a, q_b);
    // Test Case 1: Write to Port A
    data_a = 16#AA; addr_a = 16#12; we_a = 1; we_b = 0; #20;
    data_a = 16#BB; addr_a = 16#34; we_a = 1; we_b = 0; #20;
    // Test Case 2: Read from Port A
    data_a = 16#00; addr_a = 16#12; we_a = 0; we_b = 0; #20;
    data_a = 16#AA; addr_a = 16#34; we_a = 0; we_b = 0; #20;
    // Test Case 3: Write to Port B
    data_b = 16#CC; addr_b = 16#56; we_b = 1; we_a = 0; #20;
    data_b = 16#DD; addr_b = 16#78; we_b = 1; we_a = 0; #20;
    // Test Case 4: Read from Port B
    data_b = 16#00; addr_b = 16#56; we_b = 0; we_a = 0; #20;
    data_b = 16#CC; addr_b = 16#78; we_b = 0; we_a = 0; #20;
    // Finish the simulation
    $finish;
end
endmodule