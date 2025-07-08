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
reg [7:0] shift_reg_rx;
reg [7:0] shift_reg_tx;
reg [2:0] state;

localparam IDLE = 3'b000;
localparam START_RX = 3'b001;
localparam RECEIVE_DATA_RX = 3'b010;
localparam STOP_BIT_RX = 3'b011;
localparam START_TX = 3'b100;
localparam SEND_DATA_TX = 3'b101;
localparam STOP_BIT_TX = 3'b110;

always @(posedge clk or posedge rst)
begin
    if(rst)
        state <= IDLE;
    else
    begin
        case(state)
            IDLE: 
                if(~rx)
                    state <= START_RX;
                else
                    state <= IDLE;
            
            START_RX: 
                if(baud_counter == 0)
                    state <= RECEIVE_DATA_RX;
                else
                    state <= START_RX;
            
            RECEIVE_DATA_RX: 
                if(baud_counter == 0)
                    state <= STOP_BIT_RX;
                else
                    state <= RECEIVE_DATA_RX;
            
            STOP_BIT_RX: 
                if(baud_counter == 0)
                    state <= IDLE;
                else
                    state <= STOP_BIT_RX;
            
            default: state <= IDLE;
        endcase
        
        if(!baud_counter)
            baud_counter <= {BAUD_RATE{1'b1}};
        else
            baud_counter <= baud_counter - 1;
        
        case(state)
            START_RX: 
                shift_reg_rx <= 8'b0;
            
            RECEIVE_DATA_RX: 
                shift_reg_rx <= {shift_reg_rx[6:0], rx};
            
            STOP_BIT_RX: 
                data_out <= shift_reg_rx;
            
            START_TX: 
                shift_reg_tx <= data_in;
                tx <= ~data_in[0];
            
            SEND_DATA_TX: 
                shift_reg_tx <= {shift_reg_tx[6:0], 1'b0};
                tx <= ~shift_reg_tx[0];
            
            STOP_BIT_TX: 
                tx <= 1'b1;
            
            default: tx <= 1'bZ;
        endcase
    end
end

endmodule