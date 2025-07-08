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
    
    property p_clk_non_zero;
        @(posedge clk_wire) disable iff (!reset) clk_wire !== 0;
    endproperty
    
    assert property(p_clk_non_zero); 
    
    property p_write_correctness;
        @(posedge clk_wire) disable iff (!reset) (we && ##1 !we) |-> q == data;
    endproperty
    
    assert property(p_write_correctness);
    
    property p_read_correctness;
        @(posedge clk_wire) disable iff (!reset) (!we && ##1 !we) |-> q == ram[addr_reg];
    endproperty
    
    assert property(p_read_correctness);
    
    // Assuming reset is not provided, this part needs to be adjusted based on actual design
    // For simplicity, assuming no explicit reset signal handling here
    
    // Address range check
    property p_addr_range;
        @(posedge clk_wire) disable iff (!reset) addr inside {[0:63]};
    endproperty
    
    assert property(p_addr_range);
    
    // Overwrite check
    property p_overwrite_check;
        @(posedge clk_wire) disable iff (!reset) (we && ##2 we) |-> ram[addr] matches {default : wildcard, addr};
    endproperty
    
    assert property(p_overwrite_check);
    
    // Illegal transition check
    property p_illegal_transition;
        @(posedge clk_wire) disable iff (!reset) !(we && ##1 we);
    endproperty
    
    assert property(p_illegal_transition);
    
endmodule