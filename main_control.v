//main controller

module main_control( input clock, 
							input end_receiving, 
							input end_process, 
							input end_transmitting, 
							input begin_process, 
							input begin_transmit, 
							output reg [1:0] status, 
							output reg l0, 
							output reg l1, 
							output reg l2, 
							output reg l3, 
							output reg g1, 
							output reg g2, 
							output reg g3); 
							
reg [1:0] present = 2'b00; 
reg [1:0] next = 2'b00; 

parameter 
receive = 2'b00, 
process = 2'b01, 
transmit = 2'b10, 
alldone = 2'b11; 

always @(posedge clock) 
		begin 
		if (begin_process) 
		begin 
		g1 <= 1; 
		end 
		if (begin_transmit) 
				begin 
				g2 <= 1;
				end 
				if (end_receiving) 
						begin 
						g3 <= 1; 
						end 
		end 

initial 
		begin 
		g1 <= 0; 
		g2 <= 0; 
		l0 <= 0; 
		l1 <= 0; 
		l2 <= 0; 
		l3 <= 0; 
		g3 <= 0; 
		end 
		
always @(posedge clock) 
		present <= next; 
		
always @(present or begin_transmit or begin_process or end_receiving or end_process or end_transmitting) 
		case(present) 
				receive: begin 
				status <= 2'b00; 
				l0 <=1; 
				l1 <=0; 
				l2 <=0; 
				l3 <=0; 
				
				if (end_receiving && !end_process && !end_transmitting)
						next<=process; 
				else 
						next<=receive; 
				end 
				
				process: begin 
				status <= 2'b01; 
				l0 <=1; 
				l1 <=1; 
				l2 <=0; 
				l3 <=0; 
				
				if (end_receiving && end_process && !end_transmitting && begin_transmit) 
						next<=transmit; 
				else
						next<=process; 
				end 
				
				transmit: begin 
				status <= 2'b10; 
				l0 <=1; 
				l1 <=1; 
				l2 <=1; 
				l3 <=0; 
				
				if (end_receiving && end_process && end_transmitting) 
						next<=alldone; 
				else 
						next<=transmit; 
				end 
				
				alldone: begin 
				status <= 2'b11; 
				l0 <=1; 
				l1 <=1; 
				l2 <=1; 
				l3 <=1; 
				next<=alldone; 
				end 
		endcase 
		
endmodule