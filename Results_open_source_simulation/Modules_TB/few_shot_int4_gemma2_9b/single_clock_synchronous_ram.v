module tb_ram_infer;
reg clk;
reg we;
reg [5:0] read_addr;
reg [5:0] write_addr;
reg [7:0] data;
wire [7:0] q;

ram_infer dut (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .we(we),
    .clk(clk),
    .q(q)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // Initialize write addresses and data
    write_addr = 0;
    data = 8'hAA;
    we = 1;
    #10;
    // Read from the same address
    read_addr = write_addr;
    we = 0;
    #10;
    // Write different data
    data = 8'hBB;
    #10;
    // Read the updated value
    read_addr = write_addr;
    #10;
    // Write to a different address
    write_addr = 1;
    data = 8'hCC;
    we = 1;
    #10;
    // Read from the new address
    read_addr = write_addr;
    we = 0;
    #10;
    $finish;
end

endmodule