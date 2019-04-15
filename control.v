//Control unit

module control(input clock, 
					input [15:0] z, 
					input [15:0] instruction,
					output reg [2:0] alu_op, 
					output reg [15:0] write_en, 
					output reg [15:0] inc_en, 
					output reg [3:0] read_en,
					output reg end_process, 
					input [1:0] status ); 
					 
reg [5:0] present = 6'd0; 
reg [5:0] next = 6'd0; 

parameter 
fetch1 = 6'd1, 
fetch2 = 6'd2, 
loadac1 = 6'd3, 
loadac2 = 6'd4, 
loadac1x = 6'd50, 
loadac2x = 6'd51, 
movacr = 6'd5, 
movacr1 = 6'd6, 
movacr2 = 6'd7, 
movacr3 = 6'd8, 
movacr4 = 6'd9, 
movacr5 = 6'd10, 
movacdar = 6'd11, 
movrac = 6'd12, 
movr1ac = 6'd13, 
movr2ac = 6'd14, 
movr3ac = 6'd15, 
movr4ac = 6'd16, 
movr5ac = 6'd17, 
movdarac = 6'd18, 
stac = 6'd19, 
stacx = 6'd49, 
stacy = 6'd52, 
add1 = 6'd20, 
add2 = 6'd21, 
sub1 = 6'd22, 
sub2 = 6'd23, 
lshift1 = 6'd24, 
lshift2 = 6'd25, 
rshift1 = 6'd26,
rshift2 = 6'd27, 
incac = 6'd28, 
incdar = 6'd29, 
incr1 = 6'd30, 
incr2 = 6'd31, 
incr3 = 6'd32, 
loadim1 = 6'd33, 
loadim2 = 6'd34, 
loadimx = 6'd45, 
jumpz1 = 6'd35, 
jumpz2 = 6'd36, 
jumpz3 = 6'd37, 
jumpz4 = 6'd38, 
jumpz2x = 6'd46, 
jumpz3x = 6'd47, 
jumpz4x = 6'd48, 
jumpnz1 = 6'd39, 
jump1 = 6'd40, 
nop = 6'd41, 
endop = 6'd42, 
fetchx = 6'd44, 
stac2 = 6'd43, 
idle = 6'd0; 

always @(posedge clock) 
		present <= next; 
		
always @(posedge clock) 
		begin 
				if (present == endop) 
						end_process <= 1'd1; 
				else 
						end_process <= 1'd0; 
		end 

always @(present or z or instruction or status) 
		case(present) 
				idle: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				if (status == 2'b01) 
						next <= fetch1; 
				else
						next <= idle; 
				end 
				
				fetch1: begin 
				read_en <= 4'd13; 
				write_en <= 16'b0000000000010000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= fetchx; 
				end 
				
				fetchx: begin 
				read_en <= 4'd13; 
				write_en <= 16'b0000000000010000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= fetch2; 
				end 
				
				fetch2: begin 
				read_en <= 4'd13; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= instruction[5:0]; 
				end 
				
				loadac1: begin // ac to bus bus to dar 
				read_en <= 4'd5; 
				write_en <= 16'b0000000000000100; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= loadac1x; 
				end 
				
				/*loadac2: begin // ac to bus bus to dar 
				read_en <= 4'd5; 
				write_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= loadac3; 
				end*/ 
				
				/*loadac3: begin 
				read_en <= 4'd12; 
				write_en <= 16'b0000000000100000; // d mem to bus bus to ac 
				alu_op <= 3'd0; 
				next <= loadac4; 
				end*/ 
				
				loadac1x: begin // ac to bus bus to dar 
				read_en <= 4'd5; 
				write_en <= 16'b0000000000000100; 
				inc_en <= 16'b0000000000000000;
				alu_op <= 3'd0; 
				next <= loadac2x; 
				end 
				
				loadac2x: begin 
				read_en <= 4'd12; 
				write_en <= 16'b0000000000100000; // d mem to bus bus to ac 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= loadac2; 
				end 
				
				loadac2: begin 
				read_en <= 4'd12; 
				write_en <= 16'b0000000000100000; // d mem to bus bus to ac 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				movacr: begin 
				read_en <= 4'd5; 
				write_en <= 16'b0000000001000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				movacr1: begin 
				read_en <= 4'd5; 
				write_en <= 16'b0000000010000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				movacr2: begin 
				read_en <= 4'd5; 
				write_en <= 16'b0000000100000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				movacr3: begin 
				read_en <= 4'd5; 
				write_en <= 16'b0000001000000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				movacr4: begin 
				read_en <= 4'd5; 
				write_en <= 16'b0000010000000000;
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				movacr5: begin 
				read_en <= 4'd5; 
				write_en <= 16'b0000100000000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				movacdar: begin 
				read_en <= 4'd5; 
				write_en <= 16'b0000000000000100; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				movrac: begin 
				read_en <= 4'd6; 
				write_en <= 16'b0000000000100000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				movr1ac: begin 
				read_en <= 4'd7; 
				write_en <= 16'b0000000000100000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				movr2ac: begin 
				read_en <= 4'd8; 
				write_en <= 16'b0000000000100000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				movr3ac: begin 
				read_en <= 4'd9; 
				write_en <= 16'b0000000000100000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				movr4ac: begin 
				read_en <= 4'd10; 
				write_en <= 16'b0000000000100000; 
				inc_en <= 16'b0000000000000010;
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				movr5ac: begin 
				read_en <= 4'd11; 
				write_en <= 16'b0000000000100000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				movdarac: begin 
				read_en <= 4'd2; 
				write_en <= 16'b0000000000100000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				stac: begin 
				read_en <= 4'd5; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= stac2; 
				end 
				
				stac2: begin 
				read_en <= 4'd5; 
				write_en <= 16'b0001000000000000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= stacx; 
				end 
				
				stacx: begin 
				read_en <= 4'd5; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				add1: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd1; 
				next <= add2; 
				end 
				
				add2: begin 
				read_en <= 4'd0; 
				write_en <= 16'b1100000000000000; 
				inc_en <= 16'b0000000000000010;
				alu_op <= 3'd1; 
				next <= fetch1; 
				end 
				
				sub1: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd2; 
				next <= sub2; 
				end 
				
				sub2: begin 
				read_en <= 4'd0; 
				write_en <= 16'b1100000000000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd2; 
				next <= fetch1; 
				end 
				
				lshift1: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd3; 
				next <= lshift2; 
				end 
				
				lshift2: begin 
				read_en <= 4'd0; 
				write_en <= 16'b1100000000000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd3; 
				next <= fetch1; 
				end 
				
				rshift1: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd4; 
				next <= rshift2; 
				end 
				
				rshift2: begin 
				read_en <= 4'd0; 
				write_en <= 16'b1100000000000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd4; 
				next <= fetch1; 
				end 
				
				incac: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000110; 
				alu_op <= 3'd0;
				next <= fetch1; 
				end 
				
				incdar: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000001010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				incr1: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000010010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				incr2: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000100010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				incr3: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000001000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				loadim1: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= loadimx; 
				end 
				
				loadimx: begin 
				read_en <= 4'd13; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= loadim2; 
				end 
				
				loadim2: begin 
				read_en <= 4'd13; 
				write_en <= 16'b0000000000100000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1;
				end 
				
				jump1: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= jumpz2x; 
				end 
				
				jumpz1: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				if (z == 1) 
						next <= jumpz2x; 
				else 
						next <= jumpz4x; 
				end 
				
				jumpnz1: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				if (z == 0 ) 
						next <= jumpz2; 
				else 
						next <= jumpz4; 
				end 
				
				jumpz2x: begin 
				read_en <= 4'd13; 
				write_en <= 16'b0000000000000010; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= jumpz2; 
				end 
				
				jumpz2: begin 
				read_en <= 4'd13; 
				write_en <= 16'b0000000000000010; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= jumpz3x; 
				end 
				
				jumpz3x: begin 
				read_en <= 4'd13; 
				write_en <= 16'b0000000000010000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= jumpz3; 
				end
				
				jumpz3: begin 
				read_en <= 4'd13; 
				write_en <= 16'b0000000000010000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= fetch2; 
				end 
				
				jumpz4x: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= jumpz4; 
				end 
				
				jumpz4: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= jumpz3x; 
				end 
				
				nop: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000010; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
				
				endop: begin 
				read_en <= 4'd12; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= endop; 
				end 
				
				default: begin 
				read_en <= 4'd0; 
				write_en <= 16'b0000000000000000; 
				inc_en <= 16'b0000000000000000; 
				alu_op <= 3'd0; 
				next <= fetch1; 
				end 
		endcase 

endmodule