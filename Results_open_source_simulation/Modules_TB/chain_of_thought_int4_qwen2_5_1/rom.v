module tb_rom_simple;
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;

    reg [ADDR_WIDTH-1:0] addr;
    wire [DATA_WIDTH-1:0] data_out;

    rom_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) uut (
        .addr(addr),
        .data_out(data_out)
    );

    integer i;
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_rom_simple);

        // Initialize signals
        addr <= 0;

        // Stimulus process
        fork
            begin
                for (i=0; i<(1<<ADDR_WIDTH); i=i+1) begin
                    #5 addr <= i;
                end
                #5 $finish;
            end
        join

        // Monitor outputs
        $monitor($time, " ns: addr=%b, data_out=%b\n", addr, data_out);
    end

endmodule