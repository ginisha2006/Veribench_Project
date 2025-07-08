module tb_single_port_ram;

parameter CLOCK_PERIOD = 10; // adjust this value as per your requirement

logic [7:0] data;
logic [5:0] addr;
logic we;
logic clk;
logic [7:0] q;

single_port_ram dut (
   .data(data),
   .addr(addr),
   .we(we),
   .clk(clk),
   .q(q)
);

always @(*) begin assert (@(posedge clk) disable iff (!we) => ($rose(we) |=> ram[$signed(addr)] == data)); end
always @(*) begin assert (@(posedge clk) disable iff (!we) => (we |=> q == ram[$signed(addr)])); end
always @(*) begin assert ($distinctive(addr) && ($onehot(addr))); end
always @(*) begin assert (!($onehot(addr)) |-> $stable(ram[addr])); end
always @(*) begin assert (@(posedge clk) disable iff (!we) => (!we |=>!we)); end
always @(*) begin assert (@(posedge clk) disable iff (!we) => (we |=>!we)); end

endmodule