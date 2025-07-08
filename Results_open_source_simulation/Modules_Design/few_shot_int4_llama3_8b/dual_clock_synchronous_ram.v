module ram_dual (
    input [7:0] data,
    input [5:0] read_addr, write_addr,
    input we, read_clock, write_clock,
    output [7:0] q
);
    reg [7:0] mem [0:(1<<6)-1];
    
    always @(posedge read_clock)
        q <= mem[read_addr];
    
    always @(posedge write_clock)
        if (we) mem[write_addr] <= data;
endmodule