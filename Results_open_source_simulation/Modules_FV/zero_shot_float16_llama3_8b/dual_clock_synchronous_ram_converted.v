module tb_ram_dual;

parameter CLOCK_PERIOD = 10; // adjust this value as per your requirement

logic [7:0] data;
logic [5:0] read_addr, write_addr;
logic we, read_clock, write_clock;
logic [7:0] q;

ram_dual dut (
   .data(data),
   .read_addr(read_addr),
   .write_addr(write_addr),
   .we(we),
   .read_clock(read_clock),
   .write_clock(write_clock),
   .q(q)
);

always @(*) begin assert (@(posedge write_clock) disable iff (!we) ($rose(we) && $distinct(data, 8'h00))); end
always @(*) begin assert (@(posedge read_clock) ($rose(read_clock) && $distinct(q, 8'hzz))); end
always @(*) begin assert (@(posedge write_clock) disable iff (!we) ($onehot(read_addr) && $onehot(write_addr))); end
always @(*) begin assert (@(posedge write_clock) disable iff (!we) ($onehot(read_addr) && $onehot(write_addr))); end
always @(*) begin assert (@(posedge write_clock) ($stable(read_clock))); end
always @(*) begin assert (@(posedge read_clock) ($stable(write_clock))); end

always #CLOCK_PERIOD read_clock = ~read_clock;
always #CLOCK_PERIOD write_clock = ~write_clock;

endmodule