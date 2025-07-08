module tb_bcd_to_gray;
    // Parameters
    localparam BCD_WIDTH = 4;
    localparam GRAY_WIDTH = 4;

    // Inputs and outputs
    reg [BCD_WIDTH-1:0] bcd_in;
    wire [GRAY_WIDTH-1:0] gray_out;

    // Instantiate DUT
    bcd_to_gray dut (
       .bcd(bcd_in),
       .gray(gray_out)
    );

    initial begin
        $monitor($time, "bcd_in=%b, gray_out=%b", bcd_in, gray_out);

        // Test cases
        bcd_in = 0; #10; $display("Expected: 0000, Actual: %b", gray_out); 
        bcd_in = 1; #10; $display("Expected: 0001, Actual: %b", gray_out); 
        bcd_in = 2; #10; $display("Expected: 0010, Actual: %b", gray_out); 
        bcd_in = 3; #10; $display("Expected: 0011, Actual: %b", gray_out); 
        bcd_in = 4; #10; $display("Expected: 0100, Actual: %b", gray_out); 
        bcd_in = 5; #10; $display("Expected: 0101, Actual: %b", gray_out); 
        bcd_in = 6; #10; $display("Expected: 0110, Actual: %b", gray_out); 
        bcd_in = 7; #10; $display("Expected: 0111, Actual: %b", gray_out); 
        bcd_in = 8; #10; $display("Expected: 1000, Actual: %b", gray_out); 
        bcd_in = 9; #10; $display("Expected: 1001, Actual: %b", gray_out); 
        bcd_in = 10; #10; $display("Expected: 1010, Actual: %b", gray_out); 
        bcd_in = 11; #10; $display("Expected: 1011, Actual: %b", gray_out); 
        bcd_in = 12; #10; $display("Expected: 1100, Actual: %b", gray_out); 
        bcd_in = 13; #10; $display("Expected: 1101, Actual: %b", gray_out); 
        bcd_in = 14; #10; $display("Expected: 1110, Actual: %b", gray_out); 
        bcd_in = 15; #10; $display("Expected: 1111, Actual: %b", gray_out); 

        #100 $finish;
    end

endmodule