module single_port_ram_tb();

reg [7:0] data_in;
reg [5:0] addr_in;
wire [7:0] q_out;
reg clk;
reg write_enable;

single_port_ram dut (
   .data(data_in),
   .addr(addr_in),
   .we(write_enable),
   .clk(clk),
   .q(q_out)
);

initial begin
    #100; // wait for clock to stabilize
    clk = 0;
    forever begin
        #10 clk = ~clk; // toggle clock
    end
end

initial begin
    $monitor($time, "Addr: %b, Data: %h, Q: %h", addr_in, data_in, q_out);
    
    // Test case 1: Read from address 0 with valid data
    data_in = 8'h12;
    addr_in = 6'b000000;
    write_enable = 1;
    #20;
    assert(q_out == 8'h12);
    
    // Test case 2: Read from address 31 with valid data
    data_in = 8'h34;
    addr_in = 6'b111111;
    write_enable = 1;
    #20;
    assert(q_out == 8'h34);
    
    // Test case 3: Read from address 0 with invalid data
    data_in = 8'x00;
    addr_in = 6'b000000;
    write_enable = 0;
    #20;
    assert(q_out == 8'x00);
    
    // Test case 4: Read from address 31 with invalid data
    data_in = 8'x00;
    addr_in = 6'b111111;
    write_enable = 0;
    #20;
    assert(q_out == 8'x00);
    
    // Test case 5: Write to address 15 with valid data
    data_in = 8'h56;
    addr_in = 6'b011111;
    write_enable = 1;
    #20;
    assert(q_out == 8'h56);
    
    // Test case 6: Write to address 15 with invalid data
    data_in = 8'x00;
    addr_in = 6'b011111;
    write_enable = 0;
    #20;
    assert(q_out == 8'x00);
    
    $finish;
end

endmodule