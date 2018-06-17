

// Inversor criado por Pedro Augusto para aprender a usar o ModelSim

module MyInverter (
	MyInput,
	MyOutput
);

	input MyInput;
	output MyOutput;

	assign MyOutput = ~ MyInput;
	// se a entrada eh 1, a saida eh 0
	// se a entrada eh 0, a saida eh 1

endmodule

module MyInverter_test_bench();

reg MyInput;
wire MyOutput;

MyInverter inversor(MyInput, MyOutput);

initial begin

$monitor("value of MyInput=%b, MyOutput=%b", MyInput, MyOutput);

MyInput = 0;
#50 MyInput = 1 ;
#50 MyInput = 0 ;
#50 MyInput = 1 ;
#50 MyInput = 1 ;
#50 MyInput = 0 ;
#50 MyInput = 1 ;
#50 MyInput = 1 ;
#50 MyInput = 0 ;
#50 MyInput = 1 ;
#50 MyInput = 1 ;
#50 MyInput = 0 ;
#50 MyInput = 1 ;
end
endmodule