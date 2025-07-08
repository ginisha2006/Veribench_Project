module tb_behav_counter;
// Input signals
reg clk;
reg clear;
reg load;
reg up_down;
reg [7:0] d;
// Output signal
wire [7:0] cnt;
// Instantiate the Behavioral Counter
behav_counter uut (
   .d(d),
   .clk(clk),
   .clear(clear),
   .load(load),
   .up_down(up_down),
   .qd(cnt)
);
initial begin
    // Initialize the clock
    clk = 0;
    forever #5 clk = ~clk;
    // Initialize the counter
    cnt = 8'h00;
    // Clear the counter
    clear = 1; #10;
    clear = 0;
    // Load the counter with initial value
    d = 8'h12; load = 1; #10;
    load = 0;
    // Count up
    up_down = 1; #20;
    up_down = 0;
    // Count down
    up_down = 1; #20;
    up_down = 0;
    // Clear the counter again
    clear = 1; #10;
    clear = 0;
    // Verify the final count
    $display("Final count: %h", cnt);
    // Finish the simulation
    $finish;
end
endmodule