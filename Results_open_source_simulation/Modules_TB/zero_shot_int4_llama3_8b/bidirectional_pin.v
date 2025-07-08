module tb_bidir_pin;

parameter WIDTH = 1;
reg dir;
reg [WIDTH-1:0] data_out;
wire [WIDTH-1:0] pin;
wire [WIDTH-1:0] data_in;

bidir_pin uut (
   .pin(pin),
   .dir(dir),
   .data_out(data_out),
   .data_in(data_in)
);

initial begin
    dir = 0; // Set direction to output initially
    data_out = 8'h12; // Initial value for data_out
    #10; // Wait for some time before changing direction
    
    dir = 1; // Change direction to input
    data_out = 8'h34; // New value for data_out
    #20; // Wait for some time before changing direction again
    
    dir = 0; // Change direction back to output
    data_out = 8'h56; // New value for data_out
    #30; // Wait for some time before ending simulation
    
    $monitor ($time, "dir: %b, pin: %h, data_in: %h", dir, pin, data_in);
end

initial begin
    repeat (5) begin
        dir = ~dir; // Toggle direction
        #10; // Wait for some time before toggling again
    end
end

endmodule