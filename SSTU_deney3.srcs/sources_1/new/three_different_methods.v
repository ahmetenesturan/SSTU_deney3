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




module with_MUX(input a,
                input b,
                input c,
                input d,
                output f3,
                output f2,
                output f1,
                output f0);
                
    //f0 = BD
    wire f0_0;
    and_gate and_f0_0(b,d,f0_0);
    MUX mux_0(.D({f0_0, f0_0, f0_0, f0_0}), .S({a,c}), .O(f0));
    
    //f1  = A'BC + BCD' + AB'D + AC'D
    //00 -> 0
    //01 -> B + BD' = B
    //10 -> B'D + D = D
    //11 -> BD' + B'D = B ^ D
    
    wire f1_0;
    wire f1_1;
    wire f1_2;
    wire f1_3;
    
    assign f1_0 = 0;
    assign f1_1 = b;
    assign f1_2 = d;
    xor_gate xor_f1_0(b,d,f1_3);
    
    MUX mux_1(.D({f1_0, f1_1, f1_2, f1_3}), .S({a,c}), .O(f1));
    
    
    //f2 = AB'C + ACD'
    //00 -> 0
    //01 -> 0
    //10 -> 0
    //11 -> B' + D' = 1 ^ BD
    wire f2_0;
    wire f2_1;
    and_gate and_f2_0(b,d,f2_0);
    xor_gate xor_f2_0(1,w,f2_1);
    
    MUX mux_2(.D({0, 0, 0, f2_1}), .S({a,c}), .O(f2));
    
    //f3 = ABCD
    //11 -> BD
    //else -> 0 
    wire f3_0;
    and_gate and_f3_0(b,d,f3_0);
    MUX mux_3(.D({0, 0, 0, f3_0}), .S({a,c}), .O(f3));
            
endmodule
