//Instruction memory

module instr_memory(	input clock, 
							input write_en, 
							input [15:0] addr, // memory has 2^4 = 16 locations 
							input [15:0] instr_in, 
							output reg [15:0] instr_out ); 
							

reg [15:0] ram [30:0];

parameter ldac = 8'd3; 
parameter movacr = 8'd5; 
parameter movacr1 = 8'd6; 
parameter movacr2 = 8'd7;
parameter movacr3 = 8'd8; 
parameter movacr4 = 8'd9; 
parameter movacr5 = 8'd10; 
parameter movacdar = 8'd11; 
parameter movrac = 8'd12; 
parameter movr1ac = 8'd13; 
parameter movr2ac = 8'd14; 
parameter movr3ac = 8'd15; 
parameter movr4ac = 8'd16; 
parameter movr5ac = 8'd17; 
parameter movdarac = 8'd18; 
parameter stac = 8'd19;
parameter andd = 8'd20; 
parameter sub = 8'd22;
parameter lshift = 8'd24; 
parameter rshift = 8'd26; 
parameter incac = 8'd28; 
parameter incdar = 8'd29; 
parameter incr1 = 8'd30; 
parameter incr2 = 8'd31;
parameter incr3 = 8'd32; 
parameter loadim = 8'd33; 
parameter jumpz = 8'd35; 
parameter jumpnz = 8'd39; 
parameter jump = 8'd40; 
parameter nop = 8'd41; 
parameter endop = 8'd42; 

initial begin
ram[0] = loadim; 
ram[1] = 8'd5;
ram[2] = movacr; 
ram[3] = loadim; 
ram[4] = 8'd6; 
ram[5] = andd; 
ram[6] = movacr; 
ram[7] = loadim; 
ram[8] = 8'd0; 
ram[9] = movacdar; 
ram[10] = movrac; 
ram[11] = stac; 
ram[12] = endop; 
ram[13] = nop; 
ram[14] = nop; 
ram[15] = nop; 
ram[16] = nop; 
ram[17] = nop; 
ram[18] = nop; 
ram[19] = nop; 
ram[20] = nop; 
end 



always @(posedge clock) begin 
	if (write_en == 1) 
		ram[addr] <= instr_in[7:0]; 
	else 
		instr_out <= ram[addr]; 
	end 

endmodule