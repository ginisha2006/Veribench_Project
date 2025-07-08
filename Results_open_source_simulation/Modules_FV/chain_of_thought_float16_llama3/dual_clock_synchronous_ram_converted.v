module tb_ram_dual;

logic [7:0] data;
logic [5:0] read_addr, write_addr;
logic we, read_clock, write_clock;
logic [7:0] q;

reg [7:0] ram[63:0];

ram_dual dut (
   .data(data),
   .read_addr(read_addr),
   .write_addr(write_clock),
   .we(we),
   .read_clock(read_clock),
   .write_clock(write_clock),
   .q(q)
);

always @(*) begin assert (@(posedge write_clock) disable iff (!we) ($rose(we) => $distinct(data, ram[write_addr]))); end
always @(*) begin assert (@(posedge read_clock) ($rose(read_clock) => $distinct(q, ram[read_addr]))); end
always @(*) begin assert (@(posedge write_clock) disable iff (!we) ($onehot(write_addr))); end
always @(*) begin assert (@(posedge read_clock) ($onehot(read_addr))); end
always @(*) begin assert (@(posedge write_clock) ($stable(read_clock))); end
always @(*) begin assert (@(posedge read_clock) ($stable(write_clock))); end
always @(*) begin assert (@(posedge read_clock) disable iff (we) (!$we)); end
always @(*) begin assert (@(posedge write_clock) disable iff (read_clock) (!$read_clock)); end
always @(*) begin assert (@(posedge write_clock) disable iff (!we) (write_addr == 6'd62)); end
always @(*) begin assert (@(posedge write_clock) disable iff (!we) (write_addr == 6'd0)); end
always @(*) begin assert (@(posedge read_clock) (read_addr == 6'd62)); end
always @(*) begin assert (@(posedge read_clock) (read_addr == 6'd0)); end

endmodule