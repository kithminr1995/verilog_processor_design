// 4 bit wire data bus with 16 blocks

module array(A, B, R)

input [3:0] A;
input [3:0] B;
output [3:0] R;
wire [15:0] Rin;
wire [15:0] Rout; 

assign Rin[3:0] = 4’b0000;  // assign for zeros for Rin in the beginning
assign Rin[15:4] = Rout[11:0]; //

// make it as 1 bit data to 1 bit block

row array_row [3:0] (A, B, Rin, Rout);

assign R = Rout[15:12]; // final values of Rout

endmodule
