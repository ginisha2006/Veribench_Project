module tb_ram_dual;
// Input signals
reg [7:0] data;
reg [5:0] read_addr;
reg [5:0] write_addr;
reg we;
reg read_clock;
reg write_clock;
// Output signal
wire [7:0] q;
// Instantiate the Dual Clock Synchronous RAM
ram_dual uut (
   .data(data),
   .read_addr(read_addr),
   .write_addr(write_addr),
   .we(we),
   .read_clock(read_clock),
   .write_clock(write_clock),
   .q(q)
);
integer i;
initial begin
    // Initialize the RAM
    for(i=0; i<64; i=i+1) begin
        ram_dual.ram[i] = 0;
    end
    // Display the header for the output
    $display("Time	data	write_addr	read_addr	q");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, data, write_addr, read_addr, q);
    // Test Case 1: Read from empty memory
    read_addr = 0; write_addr = 0; data = 8'h12; we = 0; read_clock = 0; write_clock = 0; #20; read_clock = 1; #10; read_clock = 0; #10;
    read_addr = 0; write_addr = 0; data = 8'h34; we = 0; read_clock = 0; write_clock = 0; #20; read_clock = 1; #10; read_clock = 0; #10;
    // Test Case 2: Write to memory
    read_addr = 0; write_addr = 0; data = 8'h56; we = 1; read_clock = 0; write_clock = 0; #20; write_clock = 1; #10; write_clock = 0; #10;
    read_addr = 0; write_addr = 0; data = 8'h78; we = 1; read_clock = 0; write_clock = 0; #20; write_clock = 1; #10; write_clock = 0; #10;
    // Test Case 3: Read from memory after writing
    read_addr = 0; write_addr = 0; data = 8'h00; we = 0; read_clock = 0; write_clock = 0; #20; write_clock = 1; #10; write_clock = 0; #10;
    read_addr = 0; write_addr = 0; data = 8'h00; we = 0; read_clock = 0; write_clock = 0; #20; read_clock = 1; #10; read_clock = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule