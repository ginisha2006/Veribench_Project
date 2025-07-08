module tb_ram_dual;
// Inputs
reg [7:0] data;
reg [5:0] read_addr;
reg [5:0] write_addr;
reg we;
reg read_clock;
reg write_clock;
// Output
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
initial begin
    // Initialize the RAM
    for(int i=0; i<64; i++) begin
        ram_dual#0.ram[i] = 8'h00;
    end
    // Display the header for the output
    $display("Time	data	read_addr	write_addr	we	read_clock	write_clock	q");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b", $time, data, read_addr, write_addr, we, read_clock, write_clock, q);
    // Test Case 1: Read from address 0
    read_addr = 0; write_addr = 0; data = 8'hAA; we = 1; read_clock = 1; write_clock = 0; #20; read_clock = 0; #10; read_clock = 1; #10;
    // Test Case 2: Write to address 31
    read_addr = 0; write_addr = 31; data = 8'h55; we = 1; read_clock = 0; write_clock = 1; #20; write_clock = 0; #10; write_clock = 1; #10;
    // Test Case 3: Read from address 31
    read_addr = 31; write_addr = 0; data = 8'hz; we = 0; read_clock = 1; write_clock = 0; #20; read_clock = 0; #10; read_clock = 1; #10;
    // Finish the simulation
    $finish;
end
endmodule