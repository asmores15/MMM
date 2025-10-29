module systolic_array(clk, reset, top_1, top_2, left_1, left_2, 
                      WE_1, WE_2, WE_3, WE_4, mux_1, mux_2, mux_3,
							 mux_4, down_1, down_2);
//--------------------------
// PARAMETERS
parameter DATA_WIDTH = 16;
//--------------------------
// INPUTS
input clk;
input reset;
input [DATA_WIDTH-1:0] top_1;
input [DATA_WIDTH-1:0] top_2;
input [DATA_WIDTH-1:0] left_1;
input [DATA_WIDTH-1:0] left_2;
input WE_1;   // write enables for weight registers
input WE_2;
input WE_3;
input WE_4;
input mux_1;  // mux selects for PE output
input mux_2;
input mux_3;
input mux_4;
//--------------------------
// OUTPUTS
output [DATA_WIDTH-1:0] down_1;
output [DATA_WIDTH-1:0] down_2;
//--------------------------
// WIRES
wire [DATA_WIDTH-1:0] pe1_2;  // PE 1 to 2 (top to bottom)
wire [DATA_WIDTH-1:0] pe1_3;  // PE 1 to 3 (left to right)
wire [DATA_WIDTH-1:0] pe2_4;  // PE 2 to 4 (top to bottom)
wire [DATA_WIDTH-1:0] pe3_4;  // PE 3 to 4 (left to right)
//--------------------------
// INSTANCES
proc_elem one(pe1_2, pe1_3, top_1, left_1, WE_1, mux_1, clk, reset);
proc_elem two(down_1, pe2_4, pe1_2, left_2, WE_2, mux_2, clk, reset);
proc_elem_end three(pe3_4, top_2, pe1_3, WE_3, mux_3, clk, reset);
proc_elem_end four(down_2, pe3_4, pe2_4, WE_4, mux_4, clk, reset);
//--------------------------

endmodule
