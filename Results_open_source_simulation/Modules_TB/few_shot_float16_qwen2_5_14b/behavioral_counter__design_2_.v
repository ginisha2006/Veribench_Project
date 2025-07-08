module tb_behav_counter;
// Inputs
reg [7:0] d;
reg clk;
reg clear;
reg load;
reg up_down;
// Outputs
wire [7:0] qd;
// Instantiate the Behavioral Counter
behav_counter uut (
    .d(d),
    .clk(clk),
    .clear(clear),
    .load(load),
    .up_down(up_down),
    .qd(qd)
);
initial begin
    // Display the header for the output
    $display("Time	d	clear	load	up_down	qd");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b", $time, d, clear, load, up_down, qd);
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    // Initial state
    d = 8'd0;
    clear = 0; #10;
    clear = 1; #10;
    // Load value into counter
    d = 8'd10; load = 1; #10;
    load = 0; #10;
    // Counting up
    up_down = 1; #50;
    // Counting down
    up_down = 0; #50;
    // Clear the counter
    clear = 0; #10;
    clear = 1; #10;
    // Finish the simulation
    $finish;
end
endmodule