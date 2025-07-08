module tb_ram_dual;

reg [7:0] data;
reg [5:0] read_addr, write_addr;
reg we, read_clock, write_clock;
wire [7:0] q;

ram_dual dut (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .we(we),
    .read_clock(read_clock),
    .write_clock(write_clock),
    .q(q)
);

initial begin
    // Initialize signals
    read_clock = 0; write_clock = 0;
    read_addr = 6'b0; write_addr = 6'b0;
    data = 8'hAA; we = 0;
    
    #10 read_clock = 1; #10 read_clock = 0;
    #10 write_clock = 1; #10 write_clock = 0;
    
    // Write operation
    we = 1; data = 8'hFF; write_addr = 6'b000000;
    #10 write_clock = 1; #10 write_clock = 0;
    
    // Read operation
    read_addr = 6'b000000;
    #10 read_clock = 1; #10 read_clock = 0;
    
    // Check if read value matches written value
    $display("Read Value: %h", q);
    
    // Edge case - simultaneous read/write on same address
    we = 1; data = 8'hBB; write_addr = 6'b000000;
    read_addr = 6'b000000;
    #10 write_clock = 1; #10 write_clock = 0;
    #10 read_clock = 1; #10 read_clock = 0;
    
    // Check if read value is correct after simultaneous RW
    $display("Read Value After Simultaneous RW: %h", q);
    
    // Corner case - reading from an un-written address
    read_addr = 6'b000001;
    #10 read_clock = 1; #10 read_clock = 0;
    
    // Check if read value is default (unwritten state)
    $display("Read Unwritten Address: %h", q);
    
    // Final check with different addresses
    we = 1; data = 8'hCC; write_addr = 6'b000010;
    #10 write_clock = 1; #10 write_clock = 0;
    read_addr = 6'b000010;
    #10 read_clock = 1; #10 read_clock = 0;
    
    // Display final read value
    $display("Final Read Value: %h", q);
    
    // End simulation
    $finish;
end

endmodule