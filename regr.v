//General purpose register without increment

module regr(input clock,
				input write_en,
				input [15:0] datain, 
				output reg [15:0] dataout );
				
always @(posedge clock) 
begin 
if (write_en == 1) 
		dataout <= datain; 
end 

endmodule 