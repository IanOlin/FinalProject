`include "fpu.v"

module testFpu();
	wire[63:0] z;
	reg[63:0] x,y;

	fpu fpu0(z, x, y);

	initial begin
		//display math as a human readable
		$display("x         y           z");
		x = $realtobits(7);
		y = $realtobits(13);
		#100000
		$display("%f  %f   %f, %b", $bitstoreal(x), $bitstoreal(y), $bitstoreal(z), z);
	end
endmodule