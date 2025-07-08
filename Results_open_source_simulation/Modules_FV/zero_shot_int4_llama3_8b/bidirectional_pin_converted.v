module tb_bidir_pin;
import "DPI-C" function void cb_always @(*) begin assert(string s); end
parameter WIDTH = 1;

logic clk;
logic rst_n;
logic dir;
logic [WIDTH-1:0] data_out;
logic [WIDTH-1:0] data_in;
inout [WIDTH-1:0] pin;

bidir_pin dut (
   .pin(pin),
   .dir(dir),
   .data_out(data_out),
   .data_in(data_in)
);

property p_dir_set;
property p_data_out_set;
property p_data_in_set;
property p_overflow;
property p_underflow;

property p_dir_set @(posedge clk) disable iff (!rst_n) |-> dir == 0 |=> pin == {WIDTH{1'bz}};

property p_data_out_set @(posedge clk) disable iff (!rst_n) |-> dir == 1 |=> pin == data_out;

property p_data_in_set @(posedge clk) disable iff (!rst_n) |-> pin == data_in;

property p_overflow @(posedge clk) disable iff (!rst_n) |-> dir == 1 && data_out >= 2**WIDTH - 1 |=> assert false;

property p_underflow @(posedge clk) disable iff (!rst_n) |-> dir == 1 && data_out < 0 |=> assert false;

assert property (p_dir_set);
assert property (p_data_out_set);
assert property (p_data_in_set);
assert property (p_overflow);
assert property (p_underflow);

always #10 clk = ~clk;

initial begin
    clk <= 0;
    rst_n <= 1;
    dir <= 0;
    data_out <= 0;
    repeat (100) @(posedge clk);
    dir <= 1;
    data_out <= 2**WIDTH - 1;
    repeat (100) @(posedge clk);
    dir <= 0;
    data_out <= 0;
    repeat (100) @(posedge clk);
    dir <= 1;
    data_out <= -1;
    repeat (100) @(posedge clk);
    rst_n <= 0;
    repeat (10) @(posedge clk);
    rst_n <= 1;
    repeat (100) @(posedge clk);
end

endmodule