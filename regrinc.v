//General purpose register with increment

module regrinc(input clock,
					input write_en,
					input [15:0] datain, 
					output reg [15:0] dataout = 16'd0, 
					input inc_en); 
					

always @(posedge clock) 
begin 
if (write_en == 1) 
		dataout <= datain; 
		if (inc_en == 1) 
				dataout <= dataout + 16'd1; 
end 

endmodule