module adder(par_sum, mult_prod, sum_out);

//--------------------------
// PARAMETERS
parameter DATA_WIDTH = 16;
parameter EXPONENT = 5;
parameter MANTISSA = 10;
//--------------------------
// INPUTS
input [DATA_WIDTH-1:0] par_sum;
input [DATA_WIDTH-1:0] mult_prod;
//--------------------------
// OUTPUTS
output [DATA_WIDTH-1:0] sum_out;
//--------------------------
// WIRES
wire exp_exception;
wire zero_exception;
wire sign_check;
wire addsub;
wire swap;
wire [DATA_WIDTH-1:0] a;
wire [DATA_WIDTH-1:0] b;
wire [DATA_WIDTH-1:0] sum;
wire [EXPONENT-1:0] exp_a;
wire [EXPONENT-1:0] exp_b;
wire [EXPONENT-1:0] exp_diff;
wire [MANTISSA:0] mantissa_a;
wire [MANTISSA:0] mantissa_b;
wire [MANTISSA:0] mantissa_align;
wire [MANTISSA:0] twos_comp;
wire [MANTISSA+2:0] mantissa_add;
wire [MANTISSA+1:0] mantissa_sub;
wire [DATA_WIDTH-2:0] normalized;
//--------------------------
// REGISTERS
reg [DATA_WIDTH-1:0] sum_out;
//--------------------------
// INSTANCES
normalizer norm_add({exp_a, mantissa_sub}, normalized);
//--------------------------


// checks if a or b exponent is 31
assign exp_exception = (&par_sum[14:10]) | (&mult_prod[14:10]);


//----------Setup for adding----------
assign {swap, a, b} = (par_sum[14:0] < mult_prod[14:0]) ? {1'b1, mult_prod, par_sum} : {1'b0, par_sum, mult_prod};
assign sign_check = (a[15] ^ b[15]) ? 1'b1 : 1'b0;
assign zero_exception = sign_check ? (a[14:0] == b[14:0] ? 1'b1 : 1'b0) : 1'b0;
assign addsub = sign_check ? 1'b1 : 1'b0;
assign sum[15] = addsub ? (swap ? ~b[15] : a[15]) : a[15];
assign exp_a = a[14:10];
assign exp_b = b[14:10];
// if the exponent is == 0, implicit 1 will be 0 instead.
// else implicit bit is 1
assign mantissa_a = (|a[14:10]) ? {1'b1, a[9:0]} : {1'b0, a[9:0]};
assign mantissa_b = (|b[14:10]) ? {1'b1, b[9:0]} : {1'b0, b[9:0]};
assign exp_diff = exp_a - exp_b;
assign mantissa_align = mantissa_b >> exp_diff;

//----------Add mantissas if operands have the same sign----------
assign mantissa_add = addsub ? 12'b0 : (mantissa_a + mantissa_align);
assign sum[14:10] = mantissa_add[11] ? (1'b1 + exp_a) : exp_a;
assign sum[9:0] = mantissa_add[11] ? mantissa_add[10:1] : mantissa_add[9:0];


//----------Subtract mantissas if operands are have different signs----------
assign twos_comp = addsub ? ~(mantissa_align) + 11'b00000000001 : 11'b0;
assign mantissa_sub = addsub ? (mantissa_a + twos_comp) : 12'b0;
// this result is sent to the normalizer instance

assign sum_out = (exp_exception | zero_exception) ? 16'b0 : (addsub ? {sum[15], normalized} : sum);

endmodule