//bus

module bus(	input clock,
				input [3:0] read_en,
				input [15:0] r1,
				input [15:0] r2,
				input [15:0] r3,
				input [15:0] r4,
				input [15:0] r5,
				input [15:0] r,
				input [15:0] dar,
				input [15:0] ir,
				input [15:0] pc,
				input [15:0] ac,
				input [7:0] dm,
				input [15:0] im,
				output reg [15:0] busout ) ;
always @(r1 or r2 or r3 or r4 or r5 or r or dar or ir or pc or ac or im or read_en or dm)

begin 
		case(read_en)
					4'd1: busout <= pc; 
					4'd2: busout <= dar; //4'd3: busout <= dr; 
					4'd4: busout <= ir; 
					4'd5: busout <= ac; 
					4'd6: busout <= r; 
					4'd7: busout <= r1; 
					4'd8: busout <= r2; 
					4'd9: busout <= r3; 
					4'd10: busout <= r4; 
					4'd11: busout <= r5; 
					4'd12: busout <= dm + 16'd0; 
					4'd13: busout <= im ; 
					default: busout <= 16'd0;
		endcase
end
endmodule

		