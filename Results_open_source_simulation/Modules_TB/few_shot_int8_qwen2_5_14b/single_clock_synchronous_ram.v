module tb_ram_infer;

// Inputs
input clk;
input we;
reg [7:0] data;
reg [5:0] read_addr;
reg [5:0] write_addr;

// Outputs
wire [7:0] q;

// Instantiate the RAM module
ram_infer uut (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .we(we),
    .clk(clk),
    .q(q)
);

// Generate clock signal
reg clk;
always #5 clk =~clk;

initial begin
    // Display the header for the output
    $display("Time	data	read_addr	write_addr	we	q");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%d	%b", $time, data, read_addr, write_addr, we, q);
    
    // Initialize signals
    clk = 0;
    data = 8'h00;
    read_addr = 6'h00;
    write_addr = 6'h00;
    we = 0;

    // Apply initial reset condition
    #10;

    // Test case 1: Write to address 0 with data 0x0A
    data = 8'h0A;
    write_addr = 6'h00;
    we = 1;
    #15;

    // Read from address 0
    read_addr = 6'h00;
    we = 0;
    #15;

    // Write to address 1 with data 0x1B
    data = 8'h1B;
    write_addr = 6'h01;
    we = 1;
    #15;

    // Read from address 1
    read_addr = 6'h01;
    we = 0;
    #15;

    // Write to address 31 with data 0xFF
    data = 8'hFF;
    write_addr = 6'h1F;
    we = 1;
    #15;

    // Read from address 31
    read_addr = 6'h1F;
    we = 0;
    #15;

    // Finish the simulation
    $finish;
end

endmodule