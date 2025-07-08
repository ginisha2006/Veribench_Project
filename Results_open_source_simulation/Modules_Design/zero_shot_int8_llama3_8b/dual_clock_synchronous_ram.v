module ram_dual (
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    input read_clock,
    input write_clock,
    output [7:0] q
);

reg [7:0] mem [2**6-1:0];

always @(posedge read_clock) begin
    if (we && (write_addr == read_addr)) begin
        mem[read_addr] <= data;
    end
end

always @(posedge read_clock) begin
    q <= mem[read_addr];
end

always @(posedge write_clock) begin
    if (we) begin
        mem[write_addr] <= data;
    end
end

endmodule