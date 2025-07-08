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

always @(*) begin assert (@(posedge read_clock) disable iff (!we); end
    q == dut.ram[read_addr]);
always @(*) begin assert (@(posedge write_clock) disable iff (!we); end
    dut.ram[write_addr] == data);
always @(*) begin assert (($onehot(read_addr) && $onehot(write_addr)) |-> (read_addr!= write_addr)); end
always @(*) begin assert (@(posedge read_clock) disable iff (!we); end
   !we |=> (q === 8'h0);
    @(posedge write_clock) disable iff (!we);
   !we |=> (dut.ram[write_addr] === 8'h0));
always @(*) begin assert (@(posedge read_clock) disable iff (!we); end
    read_clock ##1 write_clock |=> (read_addr == write_addr));

endmodule