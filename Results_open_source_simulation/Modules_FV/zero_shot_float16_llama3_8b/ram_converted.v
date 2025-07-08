module tb_ram_simple;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

logic clk;
logic we;
logic [ADDR_WIDTH-1:0] addr;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] data_out;

ram_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) dut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

always @(*) begin assert (@(posedge clk) disable iff (!we) ((dut.data_out == dut.mem[dut.addr]) && (dut.mem[dut.addr] == data_in))); end
always @(*) begin assert (@(posedge clk) disable iff (we) (dut.data_out == dut.mem[dut.addr])); end
always @(*) begin assert (@(posedge clk) ($rose(dut.addr) |=> $distinct(dut.addr, {ADDR_WIDTH{1'b0}})); end
    @(posedge clk) ($fell(dut.addr) |=> $distinct(dut.addr, {(1<<ADDR_WIDTH)-1'd1})));
always @(*) begin assert (@(posedge clk) disable iff (!we) (dut.data_out === dut.data_in); end
    @(negedge clk) disable iff (!we) (dut.data_out === dut.data_in));

always #5 clk = ~clk; // Clock generation

initial begin
    clk = 0;
    repeat (100) @(posedge clk); // Run for some time
end

endmodule