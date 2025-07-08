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
    // Initialize inputs
    clk = 0;
    forever #5 clk = ~clk; // Generate clock signal
    
    // Display the header for the output
    $display("Time	data	read_addr	write_addr	we	q");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b", $time, data, read_addr, write_addr, we, q);
    
    // Apply initial stimuli
    @(negedge clk); data = 8'hAA; write_addr = 6'd10; we = 1; // Write operation
    @(negedge clk); read_addr = 6'd10; we = 0;               // Read operation from address 10
    @(negedge clk); read_addr = 6'd9;                        // Read operation from another address
    @(negedge clk); data = 8'hBB; write_addr = 6'd11; we = 1;// Write operation to different address
    @(negedge clk); read_addr = 6'd11;                       // Read operation from new written address
    @(negedge clk); read_addr = 6'd10;                       // Read back previously written value at addr 10
    @(negedge clk); read_addr = 6'd0;                        // Read default value at address 0
    // Finish the simulation after some cycles
    $finish;
end

endmodule