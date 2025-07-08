module tb_ram_dual;

// Inputs
reg [7:0] data;
reg [5:0] read_addr, write_addr;
reg we, read_clock, write_clock;

// Output
wire [7:0] q;

// Instantiate the RAM Dual Clock Module
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
    // Display the header for the output
    $display("Time	data	read_addr	write_addr	we	read_clock	write_clock	q");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b	%b", $time, data, read_addr, write_addr, we, read_clock, write_clock, q);
    
    // Initialize signals
    read_clock = 0; write_clock = 0;
    
    // Test sequence
    // Initial state
    @(negedge $dumpfile());
    
    // Write operation
    data = 8'hAA; write_addr = 6'd10; we = 1; write_clock = 1; #10;
    write_clock = 0; #10;
    
    // Read operation
    read_addr = 6'd10; read_clock = 1; #10;
    read_clock = 0; #10;
    
    // Change data and write again
    data = 8'hBB; write_addr = 6'd10; we = 1; write_clock = 1; #10;
    write_clock = 0; #10;
    
    // Read back the new value
    read_addr = 6'd10; read_clock = 1; #10;
    read_clock = 0; #10;
    
    // Finish the simulation
    $finish;
end

// Generate clocks
always #5 read_clock = ~read_clock;
always #10 write_clock = ~write_clock;

endmodule