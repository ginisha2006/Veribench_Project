module tb_rom_simple;

reg [7:0] addr;
wire [7:0] data_out;

rom_simple #(.DATA_WIDTH(8),.ADDR_WIDTH(8)) uut (
   .addr(addr),
   .data_out(data_out)
);

initial begin
    $monitor($time, "addr: %b, data_out: %b", addr, data_out);

    // Initialize address counter
    addr = 0;

    // Test all addresses (0 to 255)
    for (int i = 0; i < 256; i++) begin
        addr = i;
        #100;
    end

    // Test some specific addresses
    addr = 12;
    #100;
    addr = 127;
    #100;
    addr = 200;
    #100;

    #10000 $finish;
end

endmodule