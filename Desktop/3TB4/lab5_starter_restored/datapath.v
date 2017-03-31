module datapath (input clk, reset_n,
				// Control signals
				input write_reg_file, result_mux_select,
				input [1:0] op1_mux_select, op2_mux_select,
				input start_delay_counter, enable_delay_counter,
				input commit_branch, increment_pc,
				input alu_add_sub, alu_set_low, alu_set_high,
				input load_temp, increment_temp, decrement_temp,
				input [1:0] select_immediate,
				input [1:0] select_write_address,
				// Status outputs
				output br, brz, addi, subi, sr0, srh0, clr, mov, mova, movr, movrhs, pause,
				output delay_done,
				output temp_is_positive, temp_is_negative, temp_is_zero,
				output register0_is_zero,
				// Motor control outputs
				output [3:0] stepper_signals
);
// The comment /*synthesis keep*/ after the declaration of a wire
// prevents Quartus from optimizing it, so that it can be observed in simulation
// It is important that the comment appear before the semicolon
wire [7:0] position /*synthesis keep*/;
wire [7:0] delay /*synthesis keep*/;
wire [7:0] register0 /*synthesis keep*/;

wire [7:0] Q, prognew, progcount, operanda, selected0, immediate, operandb, result /*synthesis keep*/;
wire [1:0] write;
decoder the_decoder (
	// Inputs
	.instruction (Q[7:2]),
	// Outputs
	.br (br),
	.brz (brz),
	.addi (addi),
	.subi (subi),
	.sr0 (sr0),
	.srh0 (srh0),
	.clr (clr),
	.mov (mov),
	.mova (mova),
	.movr (movr),
	.movrhs (movrhs),
	.pause (pause)
);
regfile the_regfile(
	// Inputs
	.clk (clk),
	.reset_n (reset_n),
	.write (write_reg_file),
	.data (result), 
	.select0 (Q[1:0]),
	.select1 (Q[3:2]),
	.wr_select (write),
	// Outputs
	.selected0 (selected0),
	.selected1 (selected1),
	.delay (delay),
	.position (position),
	.register0 (register0)
);

op1_mux the_op1_mux(
	// Inputs
	.select (op1_mux_select),
	.pc (progcounter),
	.register (selected0),
	.register0 (register0),
	.position (position),
	// Outputs
	.result(operanda)
);

op2_mux the_op2_mux(
	// Inputs
	.select (op2_mux_select),
	.register (selected1),
	.immediate (immediate),
	// Outputs
	.result (operandb)
);

delay_counter the_delay_counter(
	// Inputs
	.clk(clk),
	.reset_n (reset_n),
	.start (start_delay_counter),
	.enable (enable_delay_counter),
	.delay (delay),
	// Outputs
	.done (delay_done)
);

stepper_rom the_stepper_rom(
	// Inputs
	.address (position[2:0]),
	.clock (clk),
	// Outputs
	.q (stepper_signals)
);

pc the_pc(
	// Inputs
	.clk (clk),
	.reset_n (reset_n),
	.branch (commit_branch),
	.increment (increment_pc),
	.newpc (prognew),
	// Outputs
	.pc (progcount)
);

instruction_rom the_instruction_rom(
	// Inputs
	.address (progcount),
	.clock (clk),
	// Outputs
	.q (Q)
);

alu the_alu(
	// Inputs
	.add_sub (alu_add_sub),
	.set_low (alu_set_low),
	.set_high (alu_set_high),
	.operanda (operanda),
	.operandb (operandb),
	// Outputs
	.result (prognew)
);

temp_register the_temp_register(
	// Inputs
	.clk (clk),
	.reset_n (reset_n),
	.load (load_temp),
	.increment (increment_temp),
	.decrement (decrement_temp),
	.data (selected0),
	// Outputs
	.negative (temp_is_negative),
	.positive (temp_is_positive),
	.zero (temp_is_zero)
);

immediate_extractor the_immediate_extractor(
	// Inputs
	.instruction (Q[5:0]),
	.select (select_immediate),
	// Outputs
	.immediate (immediate)
);

write_address_select the_write_address_select(
	// Inputs
	.select (select_write_address),
	.reg_field0 (Q[1:0]),
	.reg_field1 (Q[3:2]),
	// Outputs
	.write_address(write)
);

result_mux the_result_mux (
	.select_result (result_mux_select),
	.alu_result (prognew),
	.result (result)
);

branch_logic the_branch_logic(
	// Inputs
	.register0 (register0),
	// Outputs
	.branch (register0_is_0)
);

endmodule
