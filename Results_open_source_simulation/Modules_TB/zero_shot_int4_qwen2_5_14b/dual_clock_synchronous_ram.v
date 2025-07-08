module tb_ram_dual;

reg [7:0] data;
reg [5:0] read_addr, write_addr;
reg we, read_clock, write_clock;
wire [7:0] q;

ram_dual uut (
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
    data = 8'b0;
    read_addr = 6'b0;
    write_addr = 6'b0;
    we = 0;
    read_clock = 0;
    write_clock = 0;

    #10; // Wait for initial setup

    // Test case 1: Write then Read
    data = 8'hAA;
    write_addr = 6'b000000;
    we = 1;
    @(posedge write_clock);
    we = 0;
    read_addr = 6'b000000;
    @(posedge read_clock);
    if (q != 8'hAA) $display("Test Case 1 Failed");

    // Test case 2: Write with different addresses
    data = 8'hBB;
    write_addr = 6'b000001;
    we = 1;
    @(posedge write_clock);
    we = 0;
    read_addr = 6'b000001;
    @(posedge read_clock);
    if (q != 8'hBB) $display("Test Case 2 Failed");

    // Test case 3: Multiple writes followed by reads
    data = 8'hCC;
    write_addr = 6'b000010;
    we = 1;
    @(posedge write_clock);
    data = 8'hDD;
    write_addr = 6'b000011;
    @(posedge write_clock);
    we = 0;
    read_addr = 6'b000010;
    @(posedge read_clock);
    if (q != 8'hCC) $display("Test Case 3 Failed");
    read_addr = 6'b000011;
    @(posedge read_clock);
    if (q != 8'hDD) $display("Test Case 4 Failed");

    // Test case 4: No write, read should be zero
    read_addr = 6'b000100;
    @(posedge read_clock);
    if (q != 8'h00) $display("Test Case 5 Failed");

    // Edge case: Overlapping read/write on same address
    data = 8'hEE;
    write_addr = 6'b000000;
    we = 1;
    @(posedge write_clock);
    read_addr = 6'b000000;
    @(posedge read_clock);
    if (q != 8'hEE) $display("Edge Case 1 Failed");

    // Corner case: Continuous writing without reading
    for(int i=0; i<16; i++) begin
        data = {i};
        write_addr = i;
        we = 1;
        @(posedge write_clock);
    end
    read_addr = 6'b00000F;
    @(posedge read_clock);
    if (q != 8'h0F) $display("Corner Case 1 Failed");

    // Final check after multiple operations
    read_addr = 6'b000000;
    @(posedge read_clock);
    if (q != 8'h00) $display("Final Check Failed");

    $finish;
end

// Generate clocks
always #5 read_clock = ~read_clock;
always #10 write_clock = ~write_clock;

endmodule