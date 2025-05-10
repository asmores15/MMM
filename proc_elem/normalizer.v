module normalizer(unnorm, norm);

// PARAMETERS
parameter DATA_WIDTH = 16;
parameter EXP_WIDTH = 5;
parameter MANT_WIDTH = 10;
//--------------------------
// INPUTS
input [DATA_WIDTH:0] unnorm;
//--------------------------
// OUTPUTS
output [DATA_WIDTH-2:0] norm;
//--------------------------
// WIRES
wire [EXP_WIDTH-1:0] exp;
reg [EXP_WIDTH-1:0] exp_inc;
wire [MANT_WIDTH+1:0] mantissa;
reg [MANT_WIDTH+1:0] mantissa_shift;
//--------------------------
// REGISTERS
reg [DATA_WIDTH-2:0] norm;
//--------------------------

assign exp = unnorm[16:12];
assign mantissa = unnorm[11:0];

always @ (*)
begin
  casex (mantissa)
    13'b1_1xxxxxxxxxxx: 
	 begin
	   mantissa_shift = mantissa;
		exp_inc = exp;
	 end
	 12'b1_01xxxxxxxxx:
	 begin
	   mantissa_shift = mantissa << 1;
		exp_inc = exp - 1;
	 end
	 12'b1_001xxxxxxxx:
	 begin
	   mantissa_shift = mantissa << 2;
		exp_inc = exp - 2;
	 end
	 12'b1_0001xxxxxxx:
	 begin
	   mantissa_shift = mantissa << 3;
		exp_inc = exp - 3;
	 end
	 12'b1_00001xxxxxx:
	 begin
	   mantissa_shift = mantissa << 4;
		exp_inc = exp - 4;
	 end
	 12'b1_000001xxxxx:
	 begin
	   mantissa_shift = mantissa << 5;
		exp_inc = exp - 5;
	 end
	 12'b1_0000001xxxx:
	 begin
	   mantissa_shift = mantissa << 6;
		exp_inc = exp - 6;
	 end
	 12'b1_00000001xxx:
	 begin
	   mantissa_shift = mantissa << 7;
		exp_inc = exp - 7;
	 end
	 12'b1_000000001xx:
	 begin
	   mantissa_shift = mantissa << 8;
		exp_inc = exp - 8;
	 end
	 12'b1_0000000001x:
	 begin
	   mantissa_shift = mantissa << 9;
		exp_inc = exp - 9;
	 end
	 12'b1_00000000001:
	 begin
	   mantissa_shift = mantissa << 10;
		exp_inc = exp - 10;
	 end
	 default: 
	 begin
	   mantissa_shift = mantissa;  
		exp_inc = exp;
    end
  endcase
  {norm[14:10], norm[9:0]} = {exp_inc, mantissa_shift[9:0]};
end

endmodule