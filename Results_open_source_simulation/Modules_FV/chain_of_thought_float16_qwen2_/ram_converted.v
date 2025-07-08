module tb_ram_simple (
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
);

wire clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

always #5 clk =~clk;

always @(*) begin assert (@(posedge clk) disable iff (!we) data_out == mem[addr]); end

always @(*) begin assert (@(negedge clk) disable iff (!we) mem[addr] ##1 data_out); end

always @(*) begin assert (@(posedge clk) disable iff (!we) mem[addr] inside {[0:(1<<(ADDR_WIDTH))-1]}); end

always @(*) begin assert (@(posedge clk) disable iff (!we) addr < (1<<ADDR_WIDTH)); end

always @(*) begin assert (@(posedge clk) disable iff (!we) !($isunknown(mem[addr]))); end

endmodule