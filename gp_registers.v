// General Purpose Register Block

module gp_registers(	input clock,
							input reset, // Active-low synchronous reset
							input read_data, // Flag telling us whether or not to load a register value from the data bus (active high)
							input write_data, // Flag telling us whether or not to write a register to the data bus (active high)
							input [2:0] input_select, // Register to put the input value into
							input [2:0] output_select, // Index of the register we want to put on the data bus output
							input [2:0] alu_output_select, // Index of the register we want to put on the ALU output
							input [7:0] data_bus, // Contains the input value to store, or the ouput we write
							output [7:0] alu_output_value // Output bus to the ALU
							);
reg [7:0] register_data [7:0]; // Data array, 8 bits x 8 registers
wire [7:0] output_value; // Temporary latch, because the data_bus is a wire and not a reg
integer i; // Used for iterating through the registers when resetting them

always@(posedge clock) 
	begin
		if(reset == 1’b0)
			// This code produces hardware, and all of the registers will be reset simultaneously
			for(i = 0; i < 8; i = i+1)
				register_data[i] <= 8’d0;
			end
		end
		if(read_data == 1’b1)
			register_data[input_select] <= data_bus;
		end
	end
	
	// Combinational logic to interface with the data bus
	assign output_value = register_data[output_select];
	assign data_bus = write_data ? output_value : 8’hzz;
	assign alu_output_value = register_data[alu_output_select];
	
endmodule
