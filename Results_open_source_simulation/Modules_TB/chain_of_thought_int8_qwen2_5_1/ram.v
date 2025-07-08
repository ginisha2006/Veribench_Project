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
        we = 0;
        addr = 0;
        data_in = 0;
        #10;
        
        // Test case 1: Write and read back at address 0
        we = 1; addr = 0; data_in = 8'hAA; #10;
        we = 0; addr = 0; #10;
        
        // Test case 2: Write and read back at max address
        we = 1; addr = 7'd255; data_in = 8'hBB; #10;
        we = 0; addr = 7'd255; #10;
        
        // Test case 3: Write and read back at middle address
        we = 1; addr = 7'd127; data_in = 8'hCC; #10;
        we = 0; addr = 7'd127; #10;
        
        // Test case 4: Edge case - write then read immediately after
        we = 1; addr = 7'd64; data_in = 8'hDD; #10;
        we = 0; addr = 7'd64; #10;
        
        // Test case 5: Corner case - multiple writes followed by reads
        we = 1; addr = 7'd10; data_in = 8'hEE; #10;
        we = 1; addr = 7'd20; data_in = 8'hFF; #10;
        we = 0; addr = 7'd10; #10;
        we = 0; addr = 7'd20; #10;
        
        $finish;
    end

    initial begin
        $monitor($time," ns: CLK=%b WE=%b ADDR=%d DATA_IN=%h DATA_OUT=%h", clk, we, addr, data_in, data_out);
    end

    ram_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );
endmodule