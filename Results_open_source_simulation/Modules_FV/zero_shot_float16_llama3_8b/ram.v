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

property p_write_correctness;
    @(posedge clk) disable iff (!we) ((dut.data_out == dut.mem[dut.addr]) && (dut.mem[dut.addr] == data_in));
endproperty

property p_read_correctness;
    @(posedge clk) disable iff (we) (dut.data_out == dut.mem[dut.addr]);
endproperty

property p_overflow_underflow;
    @(posedge clk) ($rose(dut.addr) |=> $distinct(dut.addr, {ADDR_WIDTH{1'b0}}));
    @(posedge clk) ($fell(dut.addr) |=> $distinct(dut.addr, {(1<<ADDR_WIDTH)-1'd1}));
endproperty

property p_edge_cases;
    @(posedge clk) disable iff (!we) (dut.data_out === dut.data_in);
    @(negedge clk) disable iff (!we) (dut.data_out === dut.data_in);
endproperty

assert property (p_write_correctness);
assert property (p_read_correctness);
assert property (p_overflow_underflow);
assert property (p_edge_cases);

always #5 clk = ~clk; // Clock generation

initial begin
    clk = 0;
    repeat (100) @(posedge clk); // Run for some time
end

endmodule