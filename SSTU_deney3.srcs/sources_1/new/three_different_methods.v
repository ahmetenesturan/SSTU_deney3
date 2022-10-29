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
