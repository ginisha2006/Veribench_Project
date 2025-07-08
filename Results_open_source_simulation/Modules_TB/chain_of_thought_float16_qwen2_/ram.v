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
        forever #5 clk = ~clk; // Clock generation
    end
    
    initial begin
        we = 0;
        addr = 0;
        data_in = 0;
        
        #10 we = 1;
        for(int i=0; i<(1<<ADDR_WIDTH); i=i+1) begin
            addr = i;
            data_in = i;
            #10;
        end
        
        #10 we = 0;
        for(int i=0; i<(1<<ADDR_WIDTH); i=i+1) begin
            addr = i;
            #10;
        end
        
        #10 $finish;
    end
    
    initial begin
        $dumpfile("tb_ram_simple.vcd");
        $dumpvars(0, tb_ram_simple);
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