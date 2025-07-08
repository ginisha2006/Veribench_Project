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
    // Initialize inputs
    clk = 0;
    rst = 1;
    we = 0;
    read_addr1 = 0;
    read_addr2 = 0;
    write_addr = 0;
    write_data = 32'hDEADBEEF;
    // Clock generation
    forever #5 clk = ~clk;
end

initial begin
    // Display the header for the output
    $display("Time	rst	we	write_addr	read_addr1	read_addr2	read_data1	read_data2");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%d	%d	%h	%h", $time, rst, we, write_addr, read_addr1, read_addr2, read_data1, read_data2);
    
    // Reset phase
    rst = 1; #10;
    rst = 0; #10;
    
    // Write data to register at address 0
    we = 1; write_addr = 0; write_data = 32'hCAFEBABE; #10;
    we = 0; #10;
    
    // Read from register 0
    read_addr1 = 0; read_addr2 = 0; #10;
    
    // Write data to another register
    we = 1; write_addr = 1; write_data = 32'hBADC0FFEE; #10;
    we = 0; #10;
    
    // Read from different registers
    read_addr1 = 0; read_addr2 = 1; #10;
    
    // Finish the simulation
    $finish;
end
endmodule