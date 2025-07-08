module tb_ram_infer (
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    input clk,
    output reg [7:0] q
);
    
wire clk_wire;

reg [7:0] data_wire;
reg [5:0] read_addr_wire;
reg [5:0] write_addr_wire;
reg we_wire;

assign data_wire = data;
assign read_addr_wire = read_addr;
assign write_addr_wire = write_addr;
assign we_wire = we;

always #10 clk_wire = ~clk_wire;

assert (@(posedge clk_wire) disable iff (!we_wire)
	($past(we_wire)) |-> (q == data_wire[$past(write_addr_wire)]));

assert (@(posedge clk_wire) disable iff (!we_wire)
	(!we_wire) |-> (q != data_wire[write_addr_wire]));

assert property(p_address_bounds |-> $fatal("Address out of bounds"));

assert (@(posedge clk_wire) disable iff (!we_wire)
	($stable(read_addr_wire) && $stable(write_addr_wire) && $stable(data_wire))
	|-> ($stable(q)));

endmodule