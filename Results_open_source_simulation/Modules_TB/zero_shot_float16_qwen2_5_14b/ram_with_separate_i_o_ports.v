module tb_ram_separate_io;

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
        we = 0; addr = 0; data_in = 0;
        #10 we = 1; addr = 4'h0; data_in = 8'hAA;
        #10 we = 1; addr = 4'h1; data_in = 8'hBB;
        #10 we = 1; addr = 4'h2; data_in = 8'hCC;
        #10 we = 1; addr = 4'h3; data_in = 8'hDD;
        
        #10 we = 0; addr = 4'h0; data_in = 8'hFF;
        #10 we = 0; addr = 4'h1; data_in = 8'hEE;
        #10 we = 0; addr = 4'h2; data_in = 8'hFF;
        #10 we = 0; addr = 4'h3; data_in = 8'hGG;
        
        #10 we = 1; addr = 4'h0; data_in = 8'hZZ;
        #10 we = 1; addr = 4'h1; data_in = 8'hYY;
        #10 we = 1; addr = 4'h2; data_in = 8'hXX;
        #10 we = 1; addr = 4'h3; data_in = 8'hWW;
        
        #10 $finish;
    end

    initial begin
        $dumpfile("tb_ram_separate_io.vcd");
        $dumpvars(0, tb_ram_separate_io);
    end
    
    initial begin
        $monitor($time," ns: CLK=%b WE=%b ADDR=%h DIN=%h DOUT=%h", clk, we, addr, data_in, data_out);
    end

    ram_separate_io #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

endmodule