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

wire [7:0] addr /*synthesis keep*/;
//regfile	
wire [2:0] select0 /*synthesis keep*/;
wire [2:0] select1 /*synthesis keep*/;
wire [7:0] selected0 /*synthesis keep*/;
wire [7:0] selected1 /*synthesis keep*/;
wire [2:0] write_select /*synthesis keep*/;
wire [7:0] data /*synthesis keep*/;
wire [7:0] position /*synthesis keep*/;
wire [7:0] delay /*synthesis keep*/;
wire [7:0] register0 /*synthesis keep*/;
	
//decoder
wire [7:0] intruction /*synthesis keep*/;
	
//mux
wire [7:0] pc /*synthesis keep*/;
wire [7:0] operanda /*synthesis keep*/;
wire [7:0] operandb /*synthesis keep*/;
wire [7:0] immediate /*synthesis keep*/;
	
//PC
wire [7:0] newpc /*synthesis keep*/;
wire [7:0] pc /*synthesis keep*/;
	
decoder the_decoder (
	// Inputs
	.instruction (intruction[7:2]),
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
	.movrhs (morhs),
	.pause (pause)
);
regfile the_regfile(
	// Inputs
	.clk (clk),
	.reset_n (reset_n),
	.write (write_reg_file),
	.data (data), 
	.select0 (select0),
	.select1 (select0),
	.wr_select (write_select),
	// Outputs
	.selected0 (selecetd0),
	.selected1 (selected1),
	.delay (delay),
	.position (position),
	.register0 (register0)
);

op1_mux the_op1_mux(
	// Inputs
	.select (op1_mux_select),
	.pc (pc),
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
	.address (position [2:0]),
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
	.newpc (newpc),
	// Outputs
	.pc (pc)
);

instruction_rom the_instruction_rom(
	// Inputs
	.address (),
	.clock (),
	// Outputs
	.q ()
);

alu the_alu(
	// Inputs
	.add_sub (),
	.set_low (),
	.set_high (),
	.operanda (),
	.operandb (),
	// Outputs
	.result ()
);

temp_register the_temp_register(
	// Inputs
	.clk (),
	.reset_n (),
	.load (),
	.increment (),
	.decrement (),
	.data (),
	// Outputs
	.negative (),
	.positive (),
	.zero ()
);

immediate_extractor the_immediate_extractor(
	// Inputs
	.instruction (),
	.select (),
	// Outputs
	.immediate ()
);

write_address_select the_write_address_select(
	// Inputs
	.select (),
	.reg_field0 (),
	.reg_field1 (),
	// Outputs
	.write_address()
);

result_mux the_result_mux (
	.select_result (),
	.alu_result (),
	.result ()
);

branch_logic the_branch_logic(
	// Inputs
	.register0 (register0),
	// Outputs
	.branch ()
);

endmodule
