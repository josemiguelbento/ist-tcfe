close all
clear all

pkg load symbolic;

% 95815

R1 = sym ('1.04606282456');
R2 = sym ('2.00732621328');
R3 = sym ('3.06060705885');
R4 = sym ('4.07055531265');
R5 = sym ('3.1225213804');
R6 = sym ('2.06927045958');
R7 = sym ('1.01531018068');
Va = sym ('5.24359648479');
Id = sym ('1.01891541651');
Kb = sym ('7.0473187437');
Kc = sym ('8.3479788681');


%Mesh Method---------------------------------------------

syms I_SE I_SD I_IE I_ID;

Eq_A = R1*I_SE + R3*(I_SE+I_SD) + R4*(I_SE+I_IE) == Va;
Eq_C = R6*I_IE + R7*I_IE + R4*(I_IE+I_SE)== Kc*I_IE;
Eq_B = I_SD == Kb*R3*(I_SE+I_SD);
Eq_D = I_ID == Id;

sm = solve(Eq_A,Eq_B,Eq_C,Eq_D);


%Mesh Method COMPUTATION----------------------------------

I_SE = double(sm.I_SE) %we have to put double otherwise sm.I_SE will come out symbolic
I_SD = double(sm.I_SD)
I_IE = double(sm.I_IE)
I_ID = double(sm.I_ID)

diary "mesh_tab.tex"
diary on
V1m = double(Va)
V2m = V1m - double(R1) * I_SE
V3m = V2m + double(R2) * I_SD
V4m = double(R4) * (I_SE + I_IE)
V5m = V4m + double(R5) * (I_ID-I_SD)
V6m = V4m - double(Kc) * I_IE
V7m = - double(R6) * I_IE
V8m = V7m
diary off


%Nodal method

syms V0n V1n V2n V3n V4n V5n V6n V7n V8n

Eq_a = V0n == 0;
Eq_b = V8n == V7n;
Eq_0 = (V1n-V2n)/R1 +(V0n - V8n)/R6 + (V0n - V4n)/R4 == 0; 
Eq_2 = (V2n-V4n)/R3 + (V2n-V3n)/R2 + (V2n-V1n)/R1 == 0;
Eq_3 = - Kb*(V2n-V4n) + (V3n-V2n)/R2 == 0;
Eq_5 = (V5n-V4n)/R5 + Kb*(V2n-V4n) - Id == 0;
Eq_7 = (V7n-V6n)/R7 + (V7n - V0n)/R6 == 0;
Eq_Va = V1n - V0n == Va;
Eq_Vc = V4n - V6n == Kc * (V0n - V7n)/R6;

sn = solve(Eq_a,Eq_b,Eq_0,Eq_2,Eq_3,Eq_5,Eq_7,Eq_Va,Eq_Vc);


%Nodal method COMPUTATION

diary "node_tab.tex"
diary on
V0n = double(sn.V0n)
V1n = double(sn.V1n)
V2n = double(sn.V2n)
V3n = double(sn.V3n)
V4n = double(sn.V4n)
V5n = double(sn.V5n)
V6n = double(sn.V6n)
V7n = double(sn.V7n)
V8n = V7n
diary off

