//Accumalator

module ac(	input clock,
				input write_en,
				input [15:0] datain,
				output reg [15:0] dataout = 16'd0,
				input [15:0] alu_out,
				input alu_to_ac,
				input inc_en); 
				 
always @(posedge clock) 
		begin 
		if (inc_en == 1) 
				dataout <= dataout + 16'd1; 
				if (write_en == 1) 
						dataout <= datain; 
						if (alu_to_ac == 1) 
								dataout <= alu_out; 
		end 

endmodule