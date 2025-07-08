module tb_single_port_ram (
    input [7:0] data,
    input [5:0] addr,
    input we,
    input clk,
    output [7:0] q
);
    
    wire clk_wire;
    reg clk_gen;
    
    always #10 clk_gen = ~clk_gen;
    assign clk_wire = clk ? clk : clk_gen;
    
    single_port_ram dut (
        .data(data),
        .addr(addr),
        .we(we),
        .clk(clk_wire),
        .q(q)
    );
    
    always @(*) begin assert (@(posedge clk_wire) disable iff (!reset) clk_wire !== 0); end 
    
    always @(*) begin assert (@(posedge clk_wire) disable iff (!reset) (we && ##1 !we) |-> q == data); end
    
    always @(*) begin assert (@(posedge clk_wire) disable iff (!reset) (!we && ##1 !we) |-> q == ram[addr_reg]); end
    
    // Assuming reset is not provided, this part needs to be adjusted based on actual design
    // For simplicity, assuming no explicit reset signal handling here
    
    // Address range check
    always @(*) begin assert (@(posedge clk_wire) disable iff (!reset) addr inside {[0:63]}); end
    
    // Overwrite check
    always @(*) begin assert (@(posedge clk_wire) disable iff (!reset) (we && ##2 we) |-> ram[addr] matches {default : wildcard, addr}); end
    
    // Illegal transition check
    always @(*) begin assert (@(posedge clk_wire) disable iff (!reset) !(we && ##1 we)); end
    
endmodule