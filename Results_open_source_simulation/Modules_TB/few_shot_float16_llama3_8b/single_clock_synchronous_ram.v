module tb_ram_infer;
// Inputs
reg [7:0] data;
reg [5:0] read_addr;
reg [5:0] write_addr;
reg we;
reg clk;
// Output
wire [7:0] q;
// Instantiate the RAM Infer
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
    clk = 0;
    forever #5 clk = ~clk;
    // Initialize the RAM
    for (int i = 0; i < 64; i++) ram_infer.uut.ram[i] = 0;
    // Read and write some values
    data = 16'h1234; write_addr = 6'h20; we = 1; #10;
    data = 16'h5678; write_addr = 6'h30; we = 1; #10;
    read_addr = 6'h20; #10;
    $display("Read value: %h", q); // Should be 16'h1234
    read_addr = 6'h30; #10;
    $display("Read value: %h", q); // Should be 16'h5678
    // Finish the simulation
    $finish;
end
endmodule