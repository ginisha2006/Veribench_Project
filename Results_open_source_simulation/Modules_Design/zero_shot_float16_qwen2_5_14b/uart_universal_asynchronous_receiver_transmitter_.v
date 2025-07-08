module uart_module #(
    parameter BAUD_RATE = 9600
)(
    input clk,
    input rst,
    input rx,
    output reg tx,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg [31:0] baud_counter;
reg [7:0] shift_reg;
reg [2:0] bit_count;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        baud_counter <= 0;
        shift_reg <= 8'b0;
        bit_count <= 3'd0;
        tx <= 1'b1; // Idle state is high
    end
    else
    begin
        if(baud_counter == ((50_000_000/BAUD_RATE)-1)) // Assuming 50MHz clock
        begin
            baud_counter <= 0;
            if(bit_count == 3'd8 && tx == 1'b0)
                tx <= 1'b1; // Stop bit
            else if(bit_count < 3'd8)
                bit_count <= bit_count + 1;
            else if(tx == 1'b1 && rx == 1'b0)
            begin
                bit_count <= 3'd0;
                shift_reg <= {shift_reg[6:0],rx};
                if(bit_count == 3'd8)
                    data_out <= shift_reg;
            end
            else if(data_in != 8'hFF && tx == 1'b1)
            begin
                tx <= 1'b0; // Start bit
                shift_reg <= data_in;
                bit_count <= 3'd0;
            end
        end
        else
            baud_counter <= baud_counter + 1;
    end
end

endmodule