module multiplier(weight, multiplicand, product);

//--------------------------
// PARAMETERS
parameter DATA_WIDTH = 16;
parameter EXPONENT = 5;
parameter MANTISSA = 10;
//--------------------------
// INPUTS
input [DATA_WIDTH-1:0] weight;
input [DATA_WIDTH-1:0] multiplicand;
//--------------------------
// OUTPUTS
output [DATA_WIDTH-1:0] product;
//--------------------------
// WIRES
wire sign;
wire normalized;
wire mantissa_round;
wire [DATA_WIDTH-1:0] a;
wire [DATA_WIDTH-1:0] b;
wire [EXPONENT-1:0] exp_a;
wire [EXPONENT-1:0] exp_b;
wire [EXPONENT:0] exp_add;
wire [EXPONENT:0] exp_unbias;
wire [MANTISSA:0] mantissa_a;
wire [MANTISSA:0] mantissa_b;
wire [21:0] mantissa_norm;
wire [21:0] mantissa_mult;
wire [MANTISSA-1:0] prod_final;
//--------------------------
// REGISTERS
reg [DATA_WIDTH-1:0] product;
//--------------------------

assign {a, b} = {weight, multiplicand};
assign sign = (weight[15] ^ multiplicand[15]);
assign {exp_a, exp_b} = {weight[14:10], multiplicand[14:10]};
// if the exponent is == 0, implicit 1 will be 0 instead.
// else implicit bit is 1
assign mantissa_a = (|a[14:10]) ? {1'b1, a[9:0]} : {1'b0, a[9:0]};
assign mantissa_b = (|b[14:10]) ? {1'b1, b[9:0]} : {1'b0, b[9:0]};

// add exponents
assign exp_add = exp_a + exp_b;
assign exp_unbias = exp_add - 6'b001111 + normalized;
// multiply mantissas
assign mantissa_mult = mantissa_a * mantissa_b;
assign mantissa_round = (|mantissa_mult[9:0]);
assign normalized = mantissa_mult[21] ? 1'b1 : 1'b0;
assign mantissa_norm = normalized ? mantissa_mult : mantissa_mult << 1;

assign prod_final = mantissa_norm[20:11] + (mantissa_norm[10] & mantissa_round);
assign product = {sign, exp_unbias[4:0], prod_final};

endmodule




