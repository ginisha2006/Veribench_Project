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
    if (q != 8'hCC) $display("Test Case 3a Failed");
    read_addr = 6'b000011;
    @(posedge read_clock);
    if (q != 8'hDD) $display("Test Case 3b Failed");

    // Test case 4: Non-overlapping clocks
    data = 8'hEE;
    write_addr = 6'b000100;
    we = 1;
    @(posedge write_clock);
    we = 0;
    read_addr = 6'b000100;
    @(posedge read_clock);
    if (q != 8'hEE) $display("Test Case 4 Failed");

    // Test case 5: Edge case - simultaneous read/write on same address
    data = 8'hFF;
    write_addr = 6'b000101;
    read_addr = 6'b000101;
    we = 1;
    @(posedge write_clock);
    @(posedge read_clock);
    if (q != 8'hFF) $display("Test Case 5 Failed");

    // Test case 6: Corner case - consecutive writes to same address
    data = 8'hAB;
    write_addr = 6'b000110;
    we = 1;
    @(posedge write_clock);
    data = 8'hCD;
    @(posedge write_clock);
    we = 0;
    read_addr = 6'b000110;
    @(posedge read_clock);
    if (q != 8'hCD) $display("Test Case 6 Failed");

    // Finish simulation
    $finish;
end

// Clock generation
always #5 read_clock = ~read_clock;
always #7 write_clock = ~write_clock;

endmodule