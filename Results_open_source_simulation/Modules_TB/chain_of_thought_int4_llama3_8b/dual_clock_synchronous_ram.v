module tb_ram_dual;

parameter CLOCK_PERIOD = 10; // in ns
reg clk_write, clk_read;
reg [7:0] data_in;
reg [5:0] addr_write, addr_read;
wire [7:0] q_out;

ram_dual #(.CLOCK_PERIOD(CLOCK_PERIOD)) dut (
   .data(data_in),
   .read_addr(addr_read),
   .write_addr(addr_write),
   .we(we),
   .read_clock(clk_read),
   .write_clock(clk_write),
   .q(q_out)
);

initial begin
    #500 $display("RAM Dual Testbench");
    // Initialize clock signals
    clk_write = 0;
    clk_read = 0;
    forever begin
        #CLOCK_PERIOD clk_write = ~clk_write;
        #CLOCK_PERIOD clk_read = ~clk_read;
    end

    // Write some data
    data_in = 8'h12;
    addr_write = 6'h00;
    we = 1;
    @(posedge clk_write);
    data_in = 8'h34;
    addr_write = 6'h01;
    we = 1;
    @(posedge clk_write);
    data_in = 8'h56;
    addr_write = 6'h02;
    we = 1;
    @(posedge clk_write);

    // Read some data
    addr_read = 6'h00;
    @(posedge clk_read);
    $display("Read value at address %h%b is %h", addr_read, q_out);

    addr_read = 6'h01;
    @(posedge clk_read);
    $display("Read value at address %h%b is %h", addr_read, q_out);

    addr_read = 6'h02;
    @(posedge clk_read);
    $display("Read value at address %h%b is %h", addr_read, q_out);

    // Check for invalid reads
    addr_read = 6'h03;
    @(posedge clk_read);
    $display("Invalid read at address %h%b returns %h", addr_read, q_out);

    addr_read = 6'h07;
    @(posedge clk_read);
    $display("Invalid read at address %h%b returns %h", addr_read, q_out);

    #1000 $finish;
end

endmodule