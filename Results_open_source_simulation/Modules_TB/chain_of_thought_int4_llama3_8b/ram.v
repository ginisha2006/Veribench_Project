module tb_ram_simple;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_simple #(
   .DATA_WIDTH(DATA_WIDTH),
   .ADDR_WIDTH(ADDR_WIDTH)
) dut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

initial begin
    #5; // Set up initial conditions
    clk = 0;
    repeat (10) #10 ~clk = ~clk; // Clock toggle

    // Test read operation
    addr = 0;
    data_in = 0;
    we = 0;
    #20;
    $display($time, "Read: %h", data_out); // Observe initial value

    // Write and read operations
    addr = 1;
    data_in = 16#FF;
    we = 1;
    #10;
    we = 0;
    addr = 1;
    #10;
    $display($time, "Write and Read: %h", data_out); // Observe written value

    // Edge case: write before read
    addr = 2;
    data_in = 16#AA;
    we = 1;
    #10;
    we = 0;
    addr = 2;
    #10;
    $display($time, "Write Before Read: %h", data_out); // Observe written value

    // Corner case: read after reset
    #50; // Allow clock toggling for some time
    clk = 0;
    #10;
    clk = 1;
    addr = 3;
    #10;
    $display($time, "Read After Reset: %h", data_out); // Observe default value

    // Test multiple writes and reads
    repeat (5) begin
        addr = i;
        data_in = i;
        we = 1;
        #10;
        we = 0;
        addr = i;
        #10;
        $display($time, "Write and Read Multiple: %h", data_out); // Observe written values
        i = i + 1;
    end
end

always #5 clk = ~clk; // Clock toggle

endmodule