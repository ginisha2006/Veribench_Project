module tb_behav_counter;
// Inputs
reg clk;
reg clear;
reg load;
reg up_down;
reg [7:0] d;
// Output
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
    // Initialize the counter
    cnt = 8'h00;
    // Display the header for the output
    $display("Time	cnt");
    // Monitor changes to the counter
    $monitor("%0d	%b", $time, cnt);
    // Test Case 1: Clear the counter
    clear = 1; #20; clear = 0; #10;
    // Test Case 2: Load the counter with a value
    load = 1; d = 8'h12; #10; load = 0; #10;
    // Test Case 3: Increment the counter
    up_down = 1; #10;
    // Test Case 4: Decrement the counter
    up_down = 0; #10;
    // Test Case 5: Toggle the direction
    up_down = 1; #10; up_down = 0; #10;
    // Test Case 6: Hold the counter steady
    up_down = 0; #100;
    // Finish the simulation
    $finish;
end
endmodule