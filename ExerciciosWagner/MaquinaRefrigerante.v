
//questão da máquina de refrigerantes que ao inserir 3 moedas ele retorna o troco.
//atualmente a parte do troco está sendo implementada de forma errada e por algum motivo ele nunca seta como 1.
module MaquinaRefrigerantes(moeda, desiste, troco, refri, reset, clock, estadoa, estadob, estadoc);
input moeda, desiste, reset, clock;
output troco, refri, estadoa, estadob, estadoc;
reg troco, refri;
reg [1:0] estadoAtual, estadoFuturo;

parameter estadoInicial = 2'b00,
	  estado1 = 2'b01, 
	  estado2 = 2'b10;

//forma de monitorar no waveform qual o estado atual
assign estadoa = estadoAtual == estadoInicial;
assign estadob = estadoAtual == estado1;
assign estadoc = estadoAtual == estado2;

always @ (estadoAtual or moeda or desiste)
begin
troco = 1'b0;
refri = 1'b0;
case (estadoAtual)
	estadoInicial : 
		begin 
		if (moeda) estadoFuturo = estado1;
		else estadoFuturo = estadoInicial;
		end
	estado1 : 
		begin
		if (moeda) estadoFuturo = estado2;
		else if (desiste) 
		begin
		troco = 1;
		estadoFuturo = estadoInicial;
		end
		else estadoFuturo = estado1;
		end
	estado2 : 
		begin
		if (moeda) 
			begin
			refri = 1;
			estadoFuturo = estadoInicial;			
			end
		else if (desiste)
			begin 
			troco = 1;
			estadoFuturo = estadoInicial;
			end
		else
		estadoFuturo = estado2;
		end
	default : estadoFuturo = estadoInicial;
endcase
end

always @ (posedge clock or negedge reset) 
begin
	if (!reset)
		estadoAtual <= estadoInicial;
	else
		estadoAtual <= estadoFuturo;
end
endmodule


module Refrigerantes_test_bench();

reg moeda, desiste, reset, clock;
wire troco, refri, estado1, estado2, estado3;

MaquinaRefrigerantes inversor(moeda, desiste, troco, refri, reset, clock, estado1, estado2, estado3);

initial begin

$monitor("value of Moeda=%b, Desiste=%b, Reset = %b, Clock = %b", moeda, desiste, reset, clock);

moeda = 0;
desiste = 0;
reset = 1;
clock = 0;
#50 moeda = 1;
#50 clock = 1;
#50 clock = 0;
#50 moeda = 0 ; desiste = 1;
#50 clock = 1;
#50 clock = 0; 
#50 desiste = 0;
//#50 moeda = 1;
#50 clock = 1;
#50 clock = 0;
#50 moeda = 1;
#50 clock = 1;
#50 clock = 0;
#50 moeda = 1;
#50 clock = 1;
#50 clock = 0;
end
endmodule
 