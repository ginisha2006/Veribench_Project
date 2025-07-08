module uart_tb;
parameter BAUD_RATE = 9600;
reg clk;
reg rst;
wire tx;
wire [7:0] data_in;
wire [7:0] data_out;

initial begin
    #10; // delay for setup
    rst = 1'b1; // reset
    #20; // hold reset for some time
    rst = 1'b0; // release reset
    #100; // wait for some time before sending data
    
    // Send some data
    data_in = 8'h12; // send '12' in hexadecimal
    repeat(5) @(posedge clk); // send 5 times
    data_in = 8'h34; // send '34'
    repeat(3) @(posedge clk); // send 3 times
    data_in = 8'h56; // send '56'
    
    // Check received data
    $monitor($time, "tx:", tx);
    $monitor($time, "data_out:", data_out);
    
    // Test transmission stop bits
    data_in = 8'h00; // send null byte
    repeat(2) @(posedge clk); // send two stop bits
    
    // Test reception of multiple bytes
    data_in = 8'h78; // send '78'
    repeat(5) @(posedge clk); // send 5 times
    data_in = 8'h90; // send '90'
    repeat(3) @(posedge clk); // send 3 times
    data_in = 8'hAB; // send 'AB'
    
    // Test reception of short packets
    data_in = 8'hCD; // send 'CD'
    repeat(2) @(posedge clk); // send two stop bits
    data_in = 8'hEF; // send 'EF'
    repeat(1) @(posedge clk); // send one stop bit
    
    // Test reception of long packets
    data_in = 8'h12; // send '12'
    repeat(10) @(posedge clk); // send 10 times
    data_in = 8'h34; // send '34'
    repeat(5) @(posedge clk); // send 5 times
    data_in = 8'h56; // send '56'
    repeat(3) @(posedge clk); // send 3 times
    data_in = 8'h78; // send '78'
    repeat(2) @(posedge clk); // send two stop bits
    
    // Test reception of invalid characters
    data_in = 8'hFF; // send invalid character
    repeat(10) @(posedge clk); // send 10 times
    data_in = 8'h00; // send null byte
    repeat(2) @(posedge clk); // send two stop bits
    
    // Test reception of empty packet
    data_in = 8'h00; // send null byte
    repeat(10) @(posedge clk); // send 10 times
    data_in = 8'h00; // send null byte
    repeat(2) @(posedge clk); // send two stop bits
end

always #((BAUD_RATE)/1600000) clk = ~clk; // generate clock

endmodule