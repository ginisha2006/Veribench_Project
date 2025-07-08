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

property correct_read;
    @(posedge clk) disable iff (!we)
        q == ram[read_addr];
endproperty

assert property(correct_read);

property no_overlapping_write_read;
    @(posedge clk) disable iff (!we)
        read_addr != write_addr;
endproperty

assert property(no_overlapping_write_read);

property no_overflow_underflow;
    @(posedge clk) disable iff (!we)
        write_addr inside {[0:63]};
endproperty

assert property(no_overflow_underflow);

property stable_data_during_read;
    @(posedge clk) disable iff (!we)
        $stable(data) |-> q == ram[read_addr];
endproperty

assert property(stable_data_during_read);

property stable_address_during_read;
    @(posedge clk) disable iff (!we)
        $stable(read_addr) |-> q == ram[read_addr];
endproperty

assert property(stable_address_during_read);

property stable_address_during_write;
    @(posedge clk) disable iff (!we)
        $stable(write_addr) |-> ram[write_addr] == data;
endproperty

assert property(stable_address_during_write);

property stable_we_signal;
    @(posedge clk) disable iff (!we)
        $stable(we) |-> ram[write_addr] == data;
endproperty

assert property(stable_we_signal);

endmodule