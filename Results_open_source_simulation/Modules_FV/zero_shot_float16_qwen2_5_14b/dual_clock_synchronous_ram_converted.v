module tb_ram_dual (
    input clk_read,
    input clk_write,
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    output reg [7:0] q
);
    
    wire [7:0] data_wire = data;
    wire [5:0] read_addr_wire = read_addr;
    wire [5:0] write_addr_wire = write_addr;
    wire we_wire = we;

    ram_dual dut (
        .data(data_wire),
        .read_addr(read_addr_wire),
        .write_addr(write_addr_wire),
        .we(we_wire),
        .read_clock(clk_read),
        .write_clock(clk_write),
        .q(q)
    );

    // Clock generation
    always begin
        clk_read = 0; #5; clk_read = 1; #5;
    end
    
    always begin
        clk_write = 0; #2.5; clk_write = 1; #2.5;
    end

    // Functional correctness
    assert (@(posedge clk_read) disable iff (!we)
            ($past($fell(write_clock)) && $past(write_addr == read_addr))
                |-> q == $past(data)); 

    // Edge case - Write address out of bounds
    assert (@(posedge clk_write) disable iff (!we)
            (write_addr > 63 || write_addr < 0) |->
            $fatal("Write address is out of bounds"));

    // Edge case - Read address out of bounds
    assert (@(posedge clk_read)
            (read_addr > 63 || read_addr < 0) |->
            $fatal("Read address is out of bounds"));

    // Illegal transition - We should not have simultaneous writes on both clocks
    assert (@(posedge clk_write) disable iff (!we)
            $rose(clk_read) && we |->
            !we);

endmodule