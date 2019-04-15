//Selector

module selector( 	input clock, 
						input [1:0] status, //from procesor 
						input [15:0] bus_out, 
						input dm_en, 
						input [15:0] dar_out, 
						input [15:0] data_out_com, 
						input en_com, 
						input [15:0] addr_com, 
						output reg [15:0] datain, 
						output reg data_write_en, 
						output reg [15:0] data_addr, 
						output reg [7:0] data_in_com); 

always @(posedge clock) 
case (status) 
		2'b00:begin // write to memory from pc 
		datain <= data_out_com; //8'b10101010; 
		data_write_en <= en_com; 
		data_addr <= addr_com; 
		end 
		
		2'b01:begin // processing 
		datain <= bus_out; 
		data_write_en <=dm_en; 
		data_addr <= dar_out; 
		end 
		
		2'b10:begin // write from memory to pc 
		data_in_com <= bus_out[7:0]; 
		data_write_en <= en_com; 
		data_addr <= addr_com; 
		end 
endcase 

endmodule