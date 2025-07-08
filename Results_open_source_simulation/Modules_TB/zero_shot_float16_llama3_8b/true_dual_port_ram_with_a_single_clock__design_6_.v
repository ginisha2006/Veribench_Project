module true_dpram_sclk_tb;

reg [7:0] data_a, data_b;
reg [5:0] addr_a, addr_b;
reg we_a, we_b;
reg clk;
wire [7:0] q_a, q_b;

true_dpram_sclk dut (
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
    #100; // wait for clock to stabilize
    clk = 0;
    forever begin
        #10 clk = ~clk;
    end
end

initial begin
    $monitor($time, "clk=%b, addr_a=%h, addr_b=%h, we_a=%b, we_b=%b, data_a=%h, data_b=%h, q_a=%h, q_b=%h", clk, addr_a, addr_b, we_a, we_b, data_a, data_b, q_a, q_b);
    
    // Test Case 1: Write to Port A, Read from Port A
    data_a = 8'h12; addr_a = 6'b000010; we_a = 1; we_b = 0; #20;
    data_a = 8'h34; addr_a = 6'b000011; we_a = 1; we_b = 0; #20;
    addr_a = 6'b000010; we_a = 0; we_b = 0; #10;
    $display("Expected q_a = %h, Actual q_a = %h", 8'h12, q_a); #10;
    $display("Expected q_a = %h, Actual q_a = %h", 8'h34, q_a); #10;
    
    // Test Case 2: Write to Port B, Read from Port B
    data_b = 8'h56; addr_b = 6'b001000; we_a = 0; we_b = 1; #20;
    data_b = 8'h78; addr_b = 6'b001001; we_a = 0; we_b = 1; #20;
    addr_b = 6'b001000; we_a = 0; we_b = 0; #10;
    $display("Expected q_b = %h, Actual q_b = %h", 8'h56, q_b); #10;
    $display("Expected q_b = %h, Actual q_b = %h", 8'h78, q_b); #10;
    
    // Test Case 3: Write to both ports, read from both ports
    data_a = 8'h90; addr_a = 6'b010000; we_a = 1; we_b = 1; #20;
    data_b = 8'hab; addr_b = 6'b010001; we_a = 1; we_b = 1; #20;
    addr_a = 6'b010000; addr_b = 6'b010001; we_a = 0; we_b = 0; #10;
    $display("Expected q_a = %h, Actual q_a = %h", 8'h90, q_a); #10;
    $display("Expected q_b = %h, Actual q_b = %h", 8'hab, q_b); #10;
end

initial begin
    $finish;
end

endmodule