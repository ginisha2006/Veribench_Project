module uart_tb;
parameter BAUD_RATE = 9600;

reg clk;
reg rst;
wire tx;
wire [7:0] data_in;
wire [7:0] data_out;

uart_module uut (
   .clk(clk),
   .rst(rst),
   .rx(8'bx), // RX is not used in this testbench
   .tx(tx),
   .data_in(data_in),
   .data_out(data_out)
);

initial begin
    #10; // Wait for some time before starting the simulation
    rst = 1'b1; // Reset the module
    #20; // Hold reset for some time
    rst = 1'b0; // Deassert reset
    #50; // Allow the module to settle

    // Test transmission
    data_in = 8'h12; // Send '12'
    repeat(5) @(posedge clk); // Send 5 times at the baud rate
    $display("Sent: %b", data_in);

    // Test reception
    data_in = 8'h34; // Receive '34'
    repeat(5) @(negedge clk); // Receive 5 times at the baud rate
    $display("Received: %b", data_out);

    // Test idle line detection
    #100; // Idle line for some time
    $display("Idle line detected");

    #100; // Stop the simulation
    $finish;
end

always #10 clk = ~clk; // Generate clock signal

initial begin
    $monitor($time, "clk=%b, rst=%b, tx=%b, data_in=%b, data_out=%b", clk, rst, tx, data_in, data_out);
end
endmodule