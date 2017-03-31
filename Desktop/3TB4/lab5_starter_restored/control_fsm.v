module control_fsm (
	input clk, reset_n,
	// Status inputs
	input br, brz, addi, subi, sr0, srh0, clr, mov, mova, movr, movrhs, pause,
	input delay_done,
	input temp_is_positive, temp_is_negative, temp_is_zero,
	input register0_is_zero,
	// Control signal outputs
	output reg write_reg_file,
	output reg result_mux_select,
	output reg [1:0] op1_mux_select, op2_mux_select,
	output reg start_delay_counter, enable_delay_counter,
	output reg commit_branch, increment_pc,
	output reg alu_add_sub, alu_set_low, alu_set_high,
	output reg load_temp_register, increment_temp_register, decrement_temp_register,
	output reg [1:0] select_immediate,
	output reg [1:0] select_write_address
	
);
parameter RESET=5'b00000, FETCH=5'b00001, DECODE=5'b00010,
			BR=5'b00011, BRZ=5'b00100, ADDI=5'b00101, SUBI=5'b00110, SR0=5'b00111,
			SRH0=5'b01000, CLR=5'b01001, MOV=5'b01010, MOVA=5'b01011,
			MOVR=5'b01100, MOVRHS=5'b01101, PAUSE=5'b01110, MOVR_STAGE2=5'b01111,
			MOVR_DELAY=5'b10000, MOVRHS_STAGE2=5'b10001, MOVRHS_DELAY=5'b10010,
			PAUSE_DELAY=5'b10011;

reg [5:0] state;
reg [5:0] next_state_logic; // NOT REALLY A REGISTER!!!

always @(posedge clk) begin
	if (reset_n == 1'b0)
		state <= 5'b00000;
	else
		state <= next_state_logic;
end

// Output logic

assign data_lo_ld = (state == 5'b00001);
assign data_hi_ld = (state == 5'b10000);
assign data_out_ld = (state == 3'b110);
assign rdy_out = (state == 3'b110);

// Next state logic

always @(*) begin

	case (state)
		//RESET
		5'b00000:
		
		//FETCH
		5'b00001:
		
		//DECODE AND FETCH
		5'b00010:
		
		//ADDI
		5'b00011:
		
		//SUBI
		5'b00100:
		
		//MOV
		5'b00101:
		
		//SR0
		5'b00111:
		
		//SRH0
		5'b01000:
		
		//CLR
		5'b01001:
		
		//BR
		5'b01010:
		
		//BRZ
		5'b01011:
		
		//MOVR STAGE 2
		5'b01100:
		
		//MOVRHS STAGE 2
		5'b01101:
		
		//MOVR DELAY
		5'b01111:
		
		//MOVRHS DELAY
		5'b10000:
		
		//MOVRHS
		5'b10001:
		
		//MOVR
		5'b10010:
		
		//PAUSE DELAY
		5'b10011:
		
		//PAUSE
		5'b10100:
		
	
	// default not needed, because all the cases are specified
	endcase	
end


// Next state logic


// State register


// Output logic


endmodule
