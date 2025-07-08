module tb_ram_dual;

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

always @(*) begin assert (@(posedge write_clock) disable iff (!we) |-> ram[write_addr] == 8'h00); end
always @(*) begin assert (@(posedge read_clock) |=> q == ram[read_addr]); end
always @(*) begin assert (!(|write_addr > 63)); end
always @(*) begin assert (!(|read_addr > 63)); end
always @(*) begin assert (@(posedge write_clock) |-> we); end
always @(*) begin assert (@(posedge write_clock) |->!we); end
always @(*) begin assert (@(posedge read_clock) |-> 1'b1); end
always @(*) begin assert (@(posedge write_clock) |-> 1'b1); end

endmodule