`timescale 1ns / 1ps

module with_SSI(input a,
                input b,
                input c,
                input d,
                output f3,
                output f2,
                output f1,
                output f0);
    
    //nots
//    wire a_not;
//    wire b_not;
//    wire c_not;
//    wire d_not;
//    not_gate not_0(a,a_not);
//    not_gate not_1(b,b_not);
//    not_gate not_2(c,c_not);
//    not_gate not_3(d,d_not);
    
    //f0 = BD
    and_gate f0_0(b,d,f0);
    
    //f1  = (AD) ^ (BC)
    wire [1:0] f1_temp;
    and_gate f1_0(a,d,f1_temp[0]);
    and_gate f1_1(b,c,f1_temp[1]);
    xor_gate f1_2(f1_temp[0], f1_temp[1], f1);
    
    //f2 = (AC) ^ (ABCD)
    wire [3:0] f2_temp;
    and_gate f2_0(a,c,f2_temp[0]);
    and_gate f2_1(a,b,f2_temp[1]);
    and_gate f2_2(c,d,f2_temp[2]);
    and_gate f2_3(f2_temp[1],f2_temp[2],f2_temp[3]);
    xor_gate f2_4(f2_temp[0], f2_temp[3], f2);
    
    //f_3 = ABCD
    wire [1:0] f3_temp;
    and_gate f3_0(a,b,f3_temp[0]);
    and_gate f3_1(c,d,f3_temp[1]);
    and_gate f3_2(f3_temp[0],f3_temp[1],f3);
    
                
endmodule

module with_decoder(
input a,b,c,d,
output f3,f2,f1,f0
    );
   wire [15:0] O;
   wire [3:0] in;
   wire [15:0] temp;
   
  assign in[3] = a;
  assign in[2] = b;
  assign in[1] = c;
  assign in[0] = d;
  
  DECODER decoder1(in,O);
  
  or_gate or1(O[15],1'b0,f3); //f3
  
  or_gate or2(O[10],O[11],temp[15]);
  or_gate or3(temp[15],O[14],f2); //f2
  
  or_gate or4(O[6],O[7],temp[14]);
  or_gate or5(O[9],O[11],temp[13]);
  or_gate or6(O[13],O[14],temp[12]);
  or_gate or7(temp[14],temp[13],temp[11]);
  or_gate or8(temp[11],temp[12],f1); //f1
  
  or_gate or9(O[5],O[7],temp[10]);
  or_gate or10(O[13],O[15],temp[9]);
  or_gate or11(temp[10],temp[9],f0); //f0
    
    
endmodule




//module with_MUX(input a,
//                input b,
//                input c,
//                input d,
//                output f3,
//                output f2,
//                output f1,
//                output f0);
                
//    //f0 = BD
//    wire f0_0;
//    and_gate and_f0_0(b,d,f0_0);
//    MUX mux_0(.D({f0_0, f0_0, f0_0, f0_0}), .S({a,c}), .O(f0));
    
//    //f1  = A'BC + BCD' + AB'D + AC'D
//    //00 -> 0
//    //01 -> B + BD' = B
//    //10 -> B'D + D = D
//    //11 -> BD' + B'D = B ^ D
    
//    wire f1_0;
//    wire f1_1;
//    wire f1_2;
//    wire f1_3;
    
//    assign f1_0 = 0;
//    assign f1_1 = b;
//    assign f1_2 = d;
//    xor_gate xor_f1_0(b,d,f1_3);
    
//    MUX mux_1(.D({f1_0, f1_1, f1_2, f1_3}), .S({a,c}), .O(f1));
    
    
//    //f2 = AB'C + ACD'
//    //00 -> 0
//    //01 -> 0
//    //10 -> 0
//    //11 -> B' + D' = 1 ^ BD
//    wire f2_0;
//    wire f2_1;
//    and_gate and_f2_0(b,d,f2_0);
//    xor_gate xor_f2_0(1,w,f2_1);
    
//    MUX mux_2(.D({0, 0, 0, f2_1}), .S({a,c}), .O(f2));
    
//    //f3 = ABCD
//    //11 -> BD
//    //else -> 0 
//    wire f3_0;
//    and_gate and_f3_0(b,d,f3_0);
//    MUX mux_3(.D({0, 0, 0, f3_0}), .S({a,c}), .O(f3));
            
//endmodule

module with_MUX(
input a,b,c,d,
output f3,f2,f1,f0
);
wire [15:0] temp;
//bd, bd, bd, bd
and_gate and1(b,d,temp[15]);
MUX mux1({temp[15],temp[15],temp[15],temp[15]},{a,c},f0); //f0
//b xor d, d, b, 0
xor_gate exor1(b,d,temp[14]);
MUX mux2({temp[14],d,b,1'b0},{a,c},f1); //f1
//bd xor 1, 0, 0, 0
xor_gate exor2(temp[15],1'b1,temp[13]);
MUX mux3({temp[13],1'b0,1'b0,1'b0},{a,c},f2); //f2
//bd, 0, 0, 0
MUX mux4({temp[15],1'b0,1'b0,1'b0},{a,c},f3); //f3
endmodule
