//communicate

module communicate(	input clock,
							input [1:0] status,
							input data_from_pc,
							input [7:0] data_in_com,
							
							output reg end_receiving, // value assigned only for testing
							output reg end_transmitting , // value assigned only for testing
							output [15:0] data_out_com,
							output reg [15:0] addr_com,
							output data_to_pc,
							output reg en_com);
							
reg tx_enable; 
wire tx_busy; 
wire rx_ready;

reg [15:0] trans_addr =16'b0;
reg [15:0] receive_addr =16'b0;
reg [15:0] next_trans_addr =16'b0;
reg [15:0] next_receive_addr =16'b0;

reg [3:0] present = 4'b0000;
reg [3:0] next = 4'b0000;

initial begin 
	end_transmitting = 0; 
	end_receiving = 0; 
end


parameter 
txrx_idle = 4'b0000,
tx_send = 4'b0001, 
tx_send_wait = 4'b0010, 
tx_update = 4'b0011, 
tx_end = 4'b0100,

//rx_idle = 3'b100,
rx_start = 4'b0101, 
rx_get = 4'b0110, 
rx_update= 4'b0111, 
rx_end = 4'b1000;

always @(posedge clock) 
begin
		trans_addr <= next_trans_addr;
		receive_addr <= next_receive_addr;
end

always @(posedge clock) begin //present or status or trans_addr or receive_addr or data_from_pc or data_in_com or rx_busy or tx_busy)
	case(next)
			txrx_idle: begin
			tx_enable = 0;
			//end_receiving = 0; //change when implmenting final
			//end_transmitting = 0;
			addr_com <= 16'b0;
			en_com <=0; 
			next_trans_addr <= 16'b0; 
			next_receive_addr <= 16'b0;
			
			if (status == 2'b10) 
			next <= tx_send; 
			else if (status == 2'b00) 
			next<= rx_start; //rx_start; // 
			else 
			next<= txrx_idle; 
			end
			
			tx_send:begin 
						tx_enable = 1;
			
						end_receiving = 0; //change when implmenting final 
						end_transmitting = 0; 
						addr_com <= trans_addr; 
						en_com <=0; 
						next <= tx_send_wait; 
					  end
			
			tx_send_wait:begin 
								if (~tx_busy) begin 
									next <= tx_update; 
							 end 
			
							 end
		
		tx_update:begin	
			
							tx_enable <=0;
							if (trans_addr > 0)begin ////////////////////////
								end_transmitting <= 1;
								next<= tx_end; 
								next_trans_addr <= trans_addr;
								next_receive_addr <= receive_addr; 
								end	
			
			
					else begin 
							end_transmitting <= 0; 
							next<=tx_send; 
							next_trans_addr <= trans_addr + 16'b1; 
							next_receive_addr <= receive_addr; 
							end
							
					end
			
			
			tx_end: begin
			
			tx_enable = 0; 
			end_receiving = 1; //change when implmenting final 
			end_transmitting = 1; 
			addr_com <= 16'b0; 
			en_com <=0; 
			next_trans_addr <= 16'b0; 
			next_receive_addr <= 16'b0; 
			
			next<=tx_end; 
			end
			
			rx_start: begin 
			
			tx_enable = 0; 
			end_receiving = 1; //change when implmenting final 
			end_transmitting = 0; 
			addr_com <= 16'b0; 
			en_com <=0;
			next_trans_addr <= trans_addr; 
			next_receive_addr <= receive_addr;
			
			next<=rx_get; 
			end
			
			
			rx_get:begin
			
			tx_enable = 0; 
			end_receiving = 0; //change when implmenting final 
			end_transmitting = 0; 
			addr_com <= receive_addr;
			if (rx_ready) begin 
				en_com <=1;
				if (receive_addr == 1) begin //last adress to write to 
					end_receiving <= 1; 
					next<= rx_end; 
				end
				else begin 
					next <= rx_update;	
				end 
			end
			else begin 
				next <= rx_get; 
			end
			
			
			end 
			
			rx_update: begin
			
			next_receive_addr <= receive_addr + 16'b1; 
			next_trans_addr <= trans_addr; 
			end_receiving <= 0; 
			next<=rx_get; 
			end
			
			rx_end: begin 
			tx_enable = 0; 
			end_receiving = 1; //change when implmenting final 
			end_transmitting = 0; 
			addr_com <= 16'b0; 
			en_com <=0; 
			next_trans_addr <= 16'b0; 
			next_receive_addr <= 16'b0;
			
			next<=txrx_idle; 
			end
			
			endcase
			
			end
			
			async_transmitter #(12500000,9600) 
			tx(.clk(clock),.TxD_start(tx_enable),.TxD_data(data_in_com),.TxD(data_to_pc),.TxD_busy(tx_busy));
			
			async_receiver #(12500000,9600) 
			rx(.clk(clock),.RxD(data_from_pc),.RxD_data_ready(rx_ready),.RxD_data(data_out_com));
			
endmodule
			