module proc_elem_end(out_down, in_top, in_left, weight_WE, 
                     mux_ctrl, clk, reset);
//--------------------------
// PARAMETERS
parameter DATA_WIDTH = 16;
// INPUTS
input clk;
input reset;
input [DATA_WIDTH-1:0] in_top;
input [DATA_WIDTH-1:0] in_left;
input weight_WE;
input mux_ctrl;
//--------------------------
// OUTPUTS
output [DATA_WIDTH-1:0] out_down;
//--------------------------

// WIRES
wire [DATA_WIDTH-1:0] weight_out;
wire [DATA_WIDTH-1:0] product;
wire [DATA_WIDTH-1:0] adder_sum;
wire [DATA_WIDTH-1:0] mux_out;
//--------------------------
// REGISTERS
//--------------------------
// INSTANCES
reg_file weight(weight_WE, clk, reset, in_top, weight_out);
adder add(in_top, product, adder_sum);
multiplier mult(weight_out, in_left, product);
mux2 m2(adder_sum, in_top, mux_ctrl, mux_out);
flop_reg par_sum(mux_out, clk, reset, out_down);
//--------------------------


endmodule