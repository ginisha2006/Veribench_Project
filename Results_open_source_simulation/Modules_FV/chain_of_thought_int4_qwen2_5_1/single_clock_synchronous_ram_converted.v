module tb_ram_infer (
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    input clk,
    output reg [7:0] q
);
    
wire [7:0] ram[63:0];

always begin
    clk = ~clk; #5;
end

assert (@(posedge clk) disable iff (!we)
        q == ram[read_addr]);

assert (@(posedge clk) disable iff (!we)
        read_addr != write_addr);

assert (@(posedge clk) disable iff (!we)
        write_addr inside {[0:63]});

assert (@(posedge clk) disable iff (!we)
        $stable(data) |-> q == ram[read_addr]);

assert (@(posedge clk) disable iff (!we)
        $stable(read_addr) |-> q == ram[read_addr]);

assert (@(posedge clk) disable iff (!we)
        $stable(write_addr) |-> ram[write_addr] == data);

assert (@(posedge clk) disable iff (!we)
        $stable(we) |-> ram[write_addr] == data);

endmodule