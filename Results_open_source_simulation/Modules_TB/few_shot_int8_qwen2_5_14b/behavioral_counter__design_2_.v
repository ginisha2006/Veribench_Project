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
    // Clock generation
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    // Initialize signals
    d = 8'd0;
    clear = 0;
    load = 0;
    up_down = 0;
    // Apply stimuli
    @(negedge clk) clear = 1; #10;
    @(negedge clk) load = 1; d = 8'd10; #10;
    @(negedge clk) load = 0; up_down = 1; #10;
    @(negedge clk) up_down = 0; #10;
    @(negedge clk) up_down = 1; #10;
    @(negedge clk) clear = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule