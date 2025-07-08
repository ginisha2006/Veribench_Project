module tb_rom_simple;

reg [7:0] addr;
wire [7:0] data_out;

rom_simple #(.DATA_WIDTH(8),.ADDR_WIDTH(8)) uut (
   .addr(addr),
   .data_out(data_out)
);

initial begin
    $monitor($time, "Addr: %b, Data: %b", addr, data_out);

    // Initialize address counter
    addr = 0;

    // Read from ROM
    repeat (256) begin
        #10; // wait for 10 time units
        addr = addr + 1;
    end

    // Check if all addresses have been read
    $display("ROM access completed");
end

initial begin
    #100; // wait for 100 time units
    $finish;
end

endmodule