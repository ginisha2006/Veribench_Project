module tb_bidir_pin;
    reg [20:0] clk;
    wire [20:0] reset_n;
    reg dir;
    reg [20:0] data_out;
    wire [20:0] data_in;
    wire [20:0] pin;

    bidir_pin #(.WIDTH(21)) uut (
        .pin(pin),
        .dir(dir),
        .data_out(data_out),
        .data_in(data_in)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset_n = 0;
        dir = 0;
        data_out = 21'b0;
        @(posedge clk) reset_n = 1;
        @(posedge clk) dir = 1; data_out = 21'b10101010101010101010101;
        @(posedge clk) dir = 0;
        @(posedge clk) data_out = 21'b11111111111111111111111;
        @(posedge clk) dir = 1; data_out = 21'b00000000000000000000000;
        @(posedge clk) dir = 0;
        repeat (10) @(posedge clk);
        $finish;
    end

    initial begin
        $dumpfile("tb_bidir_pin.vcd");
        $dumpvars(0, tb_bidir_pin);
    end

    initial begin
        $monitor($time, " ns: dir=%b, data_out=%b, data_in=%b", dir, data_out, data_in);
    end

endmodule