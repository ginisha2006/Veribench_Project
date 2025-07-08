module tb_rom_simple;
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;
    reg clk;
    reg rst_n;
    wire [ADDR_WIDTH-1:0] addr;
    wire [DATA_WIDTH-1:0] data_out;
    integer i;

    // Clock and reset generation
    always #5 ~clk = ~clk; // Non-inverting clock
    initial begin
        clk = 1'b0;
        rst_n = 1'b1;
        #10 rst_n = 1'b0;
        #20 rst_n = 1'b1;
    end

    // Testbench instance
    rom_simple uut (
       .addr(addr),
       .data_out(data_out)
    );

    // Stimulus
    initial begin
        for (i = 0; i < (1 << ADDR_WIDTH); i++) begin
            addr <= i;
            #10;
        end
    end

    // Observation
    $monitor ($time, "addr: %b, data_out: %h", addr, data_out);

endmodule