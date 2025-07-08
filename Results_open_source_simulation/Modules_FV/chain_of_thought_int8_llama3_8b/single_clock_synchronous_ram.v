module tb_ram_infer;

parameter TIMEUNIT = 10ns;

reg clk;
reg [7:0] data;
reg [5:0] read_addr, write_addr;
reg we;

wire [7:0] q;

ram_infer dut (
   .data(data),
   .read_addr(read_addr),
   .write_addr(write_addr),
   .we(we),
   .clk(clk),
   .q(q)
);

property p_write_enable;
    @(posedge clk) disable iff (!we) ($rose(we));
endproperty

property p_read_enable;
    @(posedge clk) disable iff (!we) ($fell(read_addr));
endproperty

property p_write_data;
    @(posedge clk) disable iff (!we) ($rose(data));
endproperty

property p_read_data;
    @(posedge clk) disable iff (!we) ($stable(q));
endproperty

property p_write_address;
    @(posedge clk) disable iff (!we) ($rose(write_addr));
endproperty

property p_read_address;
    @(posedge clk) disable iff (!we) ($stable(read_addr));
endproperty

property p_overflow;
    @(posedge clk) disable iff (!we) ((write_addr > 63) | (read_addr > 63));
endproperty

property p_underflow;
    @(posedge clk) disable iff (!we) ((write_addr < 0) | (read_addr < 0));
endproperty

property p_illegal_transition;
    @(posedge clk) disable iff (!we) ((write_addr == read_addr) & (we));
endproperty

assert property (p_write_enable);
assert property (p_read_enable);
assert property (p_write_data);
assert property (p_read_data);
assert property (p_write_address);
assert property (p_read_address);
assert property (p_overflow);
assert property (p_underflow);
assert property (p_illegal_transition);

always #TIMEUNIT clk = ~clk;

initial begin
    clk <= 0;
    repeat (100) @(posedge clk);
    $finish;
end

endmodule