//data memory

module datamemory(input clock,
						input write_en,		
						input [15:0] addr, // memory has 2^4 = 16 locations 
						input [15:0] datain, // size of one location is 8 bits 
						output reg [7:0] dataout ); 
 
reg [7:0] ram [9:0]; 

always @(posedge clock) 
begin 
if (write_en == 1) 
		ram[addr] <= datain[7:0]; 
else 
		dataout <= ram[addr]; 
end 

endmodule