module tb_true_dpram_sclk;
// Parameters
localparam WIDTH = 8;
localparam DEPTH = 64;
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
// Initialize the RAM
reg [WIDTH-1:0] ram [DEPTH-1:0];
initial begin
    for (int i = 0; i < DEPTH; i++) begin
        ram[i] = 0;
    end
end
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
    // Display the header for the output
    $display("Time	data_a	addr_a	data_b	addr_b	q_a	q_b");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b", $time, data_a, addr_a, data_b, addr_b, q_a, q_b);
    // Test Case 1: Write to port A
    clk = 0; data_a = 8'h12; addr_a = 6'h00; we_a = 1; data_b = 8'h34; addr_b = 6'h01; we_b = 0; #20; clk = 1; #10; clk = 0; #10; clk = 1; #10; clk = 0; #10;
    // Test Case 2: Read from port A
    clk = 0; data_a = 8'h12; addr_a = 6'h00; we_a = 0; data_b = 8'h34; addr_b = 6'h01; we_b = 0; #20; clk = 1; #10; clk = 0; #10; clk = 1; #10; clk = 0; #10;
    // Test Case 3: Write to port B
    clk = 0; data_a = 8'h56; addr_a = 6'h02; we_a = 0; data_b = 8'h78; addr_b = 6'h03; we_b = 1; #20; clk = 1; #10; clk = 0; #10; clk = 1; #10; clk = 0; #10;
    // Test Case 4: Read from port B
    clk = 0; data_a = 8'h56; addr_a = 6'h02; we_a = 0; data_b = 8'h78; addr_b = 6'h03; we_b = 0; #20; clk = 1; #10; clk = 0; #10; clk = 1; #10; clk = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule