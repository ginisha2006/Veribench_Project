module tb_ram_simple;
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;

    reg clk;
    reg we;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize inputs
        we = 0;
        addr = 0;
        data_in = 0;

        // Wait for some time before starting tests
        #20;

        // Test case 1: Write and read back single value
        we = 1; addr = 3; data_in = 8'hAA; #10;
        we = 0; addr = 3; #10;
        
        // Test case 2: Edge case - write beyond address range
        we = 1; addr = 7'd256; data_in = 8'hFF; #10;
        we = 0; addr = 7'd256; #10;
        
        // Test case 3: Read from un-written location
        we = 0; addr = 4; #10;
        
        // Test case 4: Continuous writes followed by reads
        we = 1; addr = 0; data_in = 8'h01; #10;
        we = 1; addr = 1; data_in = 8'h02; #10;
        we = 1; addr = 2; data_in = 8'h03; #10;
        we = 0; addr = 0; #10;
        we = 0; addr = 1; #10;
        we = 0; addr = 2; #10;
        
        // Test case 5: Corner case - simultaneous write and read at same address
        we = 1; addr = 5; data_in = 8'hAB; #10;
        we = 0; addr = 5; #10;
        
        // End simulation after all tests
        $finish;
    end

    initial begin
        $dumpfile("tb_ram_simple.vcd");
        $dumpvars(0, tb_ram_simple);
    end

    initial begin
        $monitor($time, " ns: CLK=%b WE=%b ADDR=%d DIN=%h DOUT=%h", clk, we, addr, data_in, data_out);
    end

    ram_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );
endmodule