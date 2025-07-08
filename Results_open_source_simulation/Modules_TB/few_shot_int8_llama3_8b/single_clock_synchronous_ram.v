module tb_ram_infer;
// Inputs
reg [7:0] data;
reg [5:0] read_addr;
reg [5:0] write_addr;
reg we;
reg clk;
// Output
wire [7:0] q;
// Instantiate the RAM Infer Module
ram_infer uut (
   .data(data), 
   .read_addr(read_addr), 
   .write_addr(write_addr),
   .we(we), 
   .clk(clk), 
   .q(q)
);
initial begin
    // Initialize the clock
    clk = 0; #10; forever clk = ~clk; #10;
    // Initialize the RAM
    for (int i = 0; i < 64; i++) ram_infer.ram[i] = 0;
    // Read and write some values
    write_addr = 0; data = 16; we = 1; #20; write_addr = 1; data = 32; we = 1; #20;
    read_addr = 0; #10;
    $display("Time	read_addr	data	q");
    $monitor("%0d	%b	%b", $time, read_addr, q);
    // Check that the correct value was read back
    assert(q == 16) else $error("Incorrect read value");
    // Repeat the same operation with different addresses
    write_addr = 2; data = 48; we = 1; #20; write_addr = 3; data = 64; we = 1; #20;
    read_addr = 2; #10;
    $display("Time	read_addr	data	q");
    $monitor("%0d	%b	%b", $time, read_addr, q);
    // Check that the correct value was read back
    assert(q == 48) else $error("Incorrect read value");
    // Finish the simulation
    $finish;
end
endmodule