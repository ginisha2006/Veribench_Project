module single_port_ram_tb();

reg [7:0] data;
reg [5:0] addr;
wire [7:0] q;
reg clk;
reg we;

single_port_ram dut (
   .data(data),
   .addr(addr),
   .we(we),
   .clk(clk),
   .q(q)
);

initial begin
    #100; // wait for clock to stabilize
    clk = 0;
    forever begin
        #10 clk = ~clk;
    end
end

initial begin
    $monitor($time, "Addr: %b, Data: %h, We: %b, Q: %h", addr, data, we, q);
    
    // Test Case 1: Write and read
    data = 8'h12;
    addr = 6'b000010;
    we = 1;
    #20;
    data = 8'h34;
    addr = 6'b000011;
    we = 1;
    #20;
    addr = 6'b000010;
    #10;
    $display("Expected Q: 8'h12, Actual Q: %h", q);
    
    // Test Case 2: Read without write
    addr = 6'b000012;
    #10;
    $display("Expected Q: x, Actual Q: %h", q);
    
    // Test Case 3: Write and read with different addresses
    data = 8'h56;
    addr = 6'b001000;
    we = 1;
    #20;
    addr = 6'b000010;
    #10;
    $display("Expected Q: 8'h12, Actual Q: %h", q);
    
    // Test Case 4: Write and read with same address
    data = 8'h78;
    addr = 6'b000010;
    we = 1;
    #20;
    addr = 6'b000010;
    #10;
    $display("Expected Q: 8'h78, Actual Q: %h", q);
    
    // Test Case 5: Write and read with multiple writes
    data = 8'h90;
    addr = 6'b000011;
    we = 1;
    #20;
    data = 8'hab;
    addr = 6'b000011;
    we = 1;
    #20;
    addr = 6'b000011;
    #10;
    $display("Expected Q: 8'hab, Actual Q: %h", q);
    
    // Test Case 6: Write and read with multiple reads
    addr = 6'b000010;
    #10;
    addr = 6'b000011;
    #10;
    addr = 6'b000010;
    #10;
    $display("Expected Q: 8'h12, Actual Q: %h", q);
    
    $finish;
end

endmodule