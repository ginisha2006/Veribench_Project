module tb_rom_simple;
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;
    reg clk;
    reg rst_n;
    wire [ADDR_WIDTH-1:0] addr;
    wire [DATA_WIDTH-1:0] data_out;
    integer i;

    // Clock and reset generation
    always #5 clk = ~clk;
    initial begin
        clk = 1'b0;
        rst_n = 1'b1;
    end

    // Testbench stimulus
    initial begin
        #10; // Wait for clock stabilization
        rst_n = 1'b0;
        #10; // Deassert reset
        rst_n = 1'b1;

        // Read from ROM at different addresses
        for (i = 0; i < (1 << ADDR_WIDTH); i++) begin
            addr = i;
            #20;
            $display($sformatf("Address %d: Data Out = %h", i, data_out));
        end

        // Check for invalid address access
        addr = (1 << ADDR_WIDTH) - 1;
        #20;
        $display("Invalid Address Access: Data Out = %h", data_out);

        // Check for read operation after reset
        rst_n = 1'b0;
        addr = 0;
        #20;
        $display("Read After Reset: Data Out = %h", data_out);

        #100; // Run for some time before stopping
        $finish;
    end

    // Connect DUT
    rom_simple uut (
       .addr(addr),
       .data_out(data_out)
    );

    // Monitor signals
    $monitor ($time, "addr=%b, data_out=%h", addr, data_out);
endmodule