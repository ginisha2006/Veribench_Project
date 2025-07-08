module tb_ram_simple;
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
ram_simple #(
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
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    // Initialize write sequence
    addr = 0;
    data_in = 8'hAA;
    we = 1;
    #10;
    addr = 1;
    data_in = 8'hBB;
    we = 1;
    #10;
    addr = 2;
    data_in = 8'hCC;
    we = 1;
    #10;
    // Read sequence
    we = 0;
    $display("Address\tData In\tData Out");
    for (int i=0; i<8; i++) begin
        addr = i;
        #10;
        $display("%d\t\t%h\t%h", addr, data_in, data_out);
    end
    $finish;
end
endmodule