module tb_ram_dual;

reg [7:0] data_in;
reg [5:0] read_address, write_address;
reg write_enable, read_clk, write_clk;
wire [7:0] q_out;

ram_dual uut (
.data(data_in),
.read_addr(read_address),
.write_addr(write_address),
.we(write_enable),
.read_clock(read_clk),
.write_clock(write_clk),
.q(q_out)
);

initial begin
    // Initialize signals
    data_in = 8'b0;
    read_address = 6'b0;
    write_address = 6'b0;
    write_enable = 0;
    read_clk = 0;
    write_clk = 0;

    #10; // Wait for initial setup

    // Test case 1: Write operation
    data_in = 8'hAA;
    write_address = 6'b000000;
    write_enable = 1;
    write_clk = 1;
    #10;
    write_clk = 0;
    #10;
    
    // Read back written value
    read_address = 6'b000000;
    read_clk = 1;
    #10;
    read_clk = 0;
    #10;

    // Test case 2: Overwrite existing value with new data
    data_in = 8'hBB;
    write_address = 6'b000000;
    write_enable = 1;
    write_clk = 1;
    #10;
    write_clk = 0;
    #10;

    // Read back overwritten value
    read_address = 6'b000000;
    read_clk = 1;
    #10;
    read_clk = 0;
    #10;

    // Test case 3: Write different address
    data_in = 8'hCC;
    write_address = 6'b000001;
    write_enable = 1;
    write_clk = 1;
    #10;
    write_clk = 0;
    #10;

    // Read back written value at different address
    read_address = 6'b000001;
    read_clk = 1;
    #10;
    read_clk = 0;
    #10;

    // Edge case: simultaneous read/write on same address
    data_in = 8'hDD;
    read_address = 6'b000000;
    write_address = 6'b000000;
    write_enable = 1;
    write_clk = 1;
    read_clk = 1;
    #10;
    write_clk = 0;
    read_clk = 0;
    #10;

    // Final check after edge case
    read_address = 6'b000000;
    read_clk = 1;
    #10;
    read_clk = 0;
    #10;

    // Corner case: multiple writes followed by reads
    data_in = 8'hEE;
    write_address = 6'b000010;
    write_enable = 1;
    write_clk = 1;
    #10;
    write_clk = 0;
    #10;
    data_in = 8'hFF;
    write_address = 6'b000011;
    write_clk = 1;
    #10;
    write_clk = 0;
    #10;

    read_address = 6'b000010;
    read_clk = 1;
    #10;
    read_clk = 0;
    #10;
    read_address = 6'b000011;
    read_clk = 1;
    #10;
    read_clk = 0;
    #10;

    // Monitor output
    $monitor($time, " ns: q_out = %b", q_out);
end

endmodule