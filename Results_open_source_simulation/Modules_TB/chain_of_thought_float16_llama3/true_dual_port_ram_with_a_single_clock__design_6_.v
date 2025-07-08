module true_dpram_sclk_tb;

reg [7:0] data_a, data_b;
reg [5:0] addr_a, addr_b;
reg we_a, we_b;
reg clk;
wire [7:0] q_a, q_b;

initial begin
    #10; // delay for setup
    clk = 0;
    forever begin
        #5 clk = ~clk; // toggle clock
    end
end

initial begin
    $monitor($time, "data_a=%h addr_a=%h we_a=%b data_b=%h addr_b=%h we_b=%b q_a=%h q_b=%h", 
             data_a, addr_a, we_a, data_b, addr_b, we_b, q_a, q_b);

    // Test Case 1: Read from both ports
    data_a = 8'h12; addr_a = 6'b000010; we_a = 1; data_b = 8'h34; addr_b = 6'b001011; we_b = 1;
    #20;
    data_a = 8'h56; addr_a = 6'b010100; we_a = 0; data_b = 8'h78; addr_b = 6'b011110; we_b = 0;
    #20;

    // Test Case 2: Write to both ports
    data_a = 8'h90; addr_a = 6'b100000; we_a = 1; data_b = 8'hab; addr_b = 6'b101101; we_b = 1;
    #20;
    data_a = 8'hbc; addr_a = 6'b110010; we_a = 0; data_b = 8'hde; addr_b = 6'b111011; we_b = 0;
    #20;

    // Test Case 3: Mixed read/write operations
    data_a = 8'hf0; addr_a = 6'b000001; we_a = 1; data_b = 8'h12; addr_b = 6'b001000; we_b = 0;
    #20;
    data_a = 8'h34; addr_a = 6'b010001; we_a = 0; data_b = 8'h56; addr_b = 6'b011000; we_b = 1;
    #20;

    #100 $finish;
end

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

endmodule