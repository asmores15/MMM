module mux2(a, b, ctrl, out);

//--------------------------
// PARAMETERS
parameter DATA_WIDTH = 16;
//--------------------------
// INPUTS
input [DATA_WIDTH-1:0] a;
input [DATA_WIDTH-1:0] b;
input ctrl;
//--------------------------
// OUTPUTS
output [DATA_WIDTH-1:0] out;
//--------------------------

assign out = ctrl ? a : b;

endmodule