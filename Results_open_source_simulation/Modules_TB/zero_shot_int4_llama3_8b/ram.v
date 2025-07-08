module tb_ram_simple;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_simple #(
   .DATA_WIDTH(DATA_WIDTH),
   .ADDR_WIDTH(ADDR_WIDTH)
) dut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

initial begin
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;

    // Initialize memory
    for (int i = 0; i < (1 << ADDR_WIDTH); i++) begin
        ram_simple__mem[i] = 0;
    end

    // Test read and write operations
    #20;
    addr = 0;
    data_in = 8'h12;
    we = 1;
    #10;
    we = 0;
    #10;
    addr = 1;
    data_in = 8'h34;
    we = 1;
    #10;
    we = 0;
    #10;
    addr = 0;
    #10;
    $display("Expected data out: %h", ram_simple__mem[0]);
    $display("Actual data out: %h", data_out);
    assert(data_out == 8'h12);

    // Test read operation with invalid address
    addr = 2;
    #10;
    $display("Expected data out: x", data_out);
    $display("Actual data out: %h", data_out);
    assert(data_out == 8'bx);

    // Test write operation with invalid address
    addr = 3;
    data_in = 8'h56;
    we = 1;
    #10;
    we = 0;
    #10;
    $display("Expected data out: x", data_out);
    $display("Actual data out: %h", data_out);
    assert(data_out == 8'bx);

    // Test multiple writes and reads
    for (int i = 0; i < 4; i++) begin
        addr = i;
        data_in = 8'h12 + i;
        we = 1;
        #10;
        we = 0;
    end
    for (int i = 0; i < 4; i++) begin
        addr = i;
        #10;
        $display("Expected data out: %h", ram_simple__mem[i]);
        $display("Actual data out: %h", data_out);
        assert(data_out == ram_simple__mem[i]);
    end
end

always @ (posedge clk) begin
    $monitor($time, "clk: %b, addr: %h, data_in: %h, data_out: %h", clk, addr, data_in, data_out);
end

endmodule