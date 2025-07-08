module tb_ram_separate_io;
// Parameters
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;
// Clock
reg clk;
// Inputs
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
// Outputs
wire [DATA_WIDTH-1:0] data_out;
// Instantiate the RAM
ram_separate_io #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) uut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);
initial begin
    clk = 0; forever #5 clk = ~clk;
end
initial begin
    // Initialize address and data
    addr = 0;
    data_in = 0;
    we = 0;
    #10;
    // Write data to memory locations
    for (int i = 0; i < 256; i++) begin
        addr = i;
        data_in = i;
        we = 1;
        #10;
    end
    we = 0;
    // Read data from memory locations
    $display("Time	Addr	Data In	Data Out");
    for (int i = 0; i < 256; i++) begin
        addr = i;
        #10;
        $display("%0d	%b	%b	%b", $time, addr, data_in, data_out);
    end
    $finish;
end
endmodule