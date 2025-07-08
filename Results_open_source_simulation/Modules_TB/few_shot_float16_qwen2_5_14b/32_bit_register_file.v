module tb_reg_file_32bit;
// Inputs
reg clk;
reg rst;
reg we;
reg [4:0] read_addr1;
reg [4:0] read_addr2;
reg [4:0] write_addr;
reg [31:0] write_data;
// Outputs
wire [31:0] read_data1;
wire [31:0] read_data2;

// Instantiate the 32-bit Register File
reg_file_32bit uut (
    .clk(clk),
    .rst(rst),
    .we(we),
    .read_addr1(read_addr1),
    .read_addr2(read_addr2),
    .write_addr(write_addr),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

initial begin
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // Display the header for the output
    $display("Time	rst	we	write_addr	read_addr1	read_addr2	write_data	read_data1	read_data2");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b	%b	%d	%d", $time, rst, we, write_addr, read_addr1, read_addr2, write_data, clk, read_data1, read_data2);
    
    // Reset the system
    rst = 1; #10;
    rst = 0; #10;
    
    // Write data to register at address 5
    we = 1; write_addr = 5; write_data = 32'hDEADBEEF; #10;
    we = 0; #10;
    
    // Read from registers at addresses 5 and 10
    read_addr1 = 5; read_addr2 = 10; #10;
    
    // Write data to register at address 10
    we = 1; write_addr = 10; write_data = 32'hCAFEBABE; #10;
    we = 0; #10;
    
    // Read from registers at addresses 5 and 10 again
    read_addr1 = 5; read_addr2 = 10; #10;
    
    // Final reset
    rst = 1; #10;
    rst = 0; #10;
    
    // Finish the simulation
    $finish;
end
endmodule