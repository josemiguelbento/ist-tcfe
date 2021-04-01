close all
clear all

pkg load symbolic;

format long;

%data_gen

datafile=fopen('data.txt','r');
data=fscanf(datafile, '%s = %f', [3 inf]);
data = data';
fclose(datafile);

simf=fopen('data_sim.txt','w');
fprintf(simf, 'R1 1 2 %fk\n', data(1,3));
fprintf(simf, 'R2 2 3 %fk\n', data(2,3));
fprintf(simf, 'R3 2 5 %fk\n', data(3,3));
fprintf(simf, 'R4 0 5 %fk\n', data(4,3));
fprintf(simf, 'R5 5 6 %fk\n', data(5,3));
fprintf(simf, 'R6 0 4 %fk\n', data(6,3));
fprintf(simf, 'R7 7 8 %fk\n', data(7,3));
fprintf(simf, 'Vs 1 0 DC %f\n', data(8,3));
fprintf(simf, 'Vf 4 7 DC 0\n');
fprintf(simf, 'C 6 8 %fu\n', data(9,3));
fprintf(simf, 'Gb 6 3 2 5 %fm\n', data(10,3));
fprintf(simf, 'Hd 5 8 Vf %fk\n', data(11,3));

fclose(simf);


R1 = sym(sprintf('%.11f', data(1,3)));
R2 = sym(sprintf('%.11f', data(2,3)));
R3 = sym(sprintf('%.11f', data(3,3)));
R4 = sym(sprintf('%.11f', data(4,3)));
R5 = sym(sprintf('%.11f', data(5,3)));
R6 = sym(sprintf('%.11f', data(6,3)));
R7 = sym(sprintf('%.11f', data(7,3)));
Vs = sym(sprintf('%.11f', data(8,3)));
Vf = sym('0');
C = sym(sprintf('%.11f', data(9,3)));
Kb = sym(sprintf('%.11f', data(10,3)));
Kd = sym(sprintf('%.11f', data(11,3)));

%%NODAL THEO 1
syms V0 V1 V2 V3 V4 V5 V6 V7 V8

Eq_0 = V0 == 0;
Eq_f = V4 == V7;
Eq_d = V5-V8 == Kd*(V0-V4)/R6;
Eq_s = V1-V0 == Vs;
Eq_2 = (V2-V1)/R1 + (V2-V5)/R3 + (V2-V3)/R2 == 0;
Eq_3 = (V3-V2)/R2 - Kb*(V2-V5) == 0;
Eq_5 = (V5-V2)/R3 + (V5-V0)/R4 + (V5-V6)/R5 + (V8-V7)/R7 == 0;
Eq_6 = Kb*(V2-V5) + (V6-V5)/R5 == 0;
Eq_7 = (V4-V0)/R6 + (V7-V8)/R7 == 0;

sn = solve(Eq_0,Eq_f,Eq_d,Eq_s,Eq_2,Eq_3,Eq_5,Eq_6,Eq_7);

diary "nodal_tab.tex"
diary on

V0 = double(sn.V0)
V1 = double(sn.V1)
V2 = double(sn.V2)
V3 = double(sn.V3)
V4 = double(sn.V4)
V5 = double(sn.V5)
V6 = double(sn.V6)
V7 = double(sn.V7)
V8 = double(sn.V8)


I_r1 = (V2 -V1)/double(R1)
I_r2 = (V3 -V2)/double(R2)
I_r3 = (V5 -V2)/double(R3)
I_r4 = (V5 -V0)/double(R4)
I_r5 = (V6 -V5)/double(R5)
I_r6 = (V4 -V0)/double(R6)
I_r7 = (V8 -V7)/double(R7)
Gb = I_r5
Hd = double(Kd)*(V0-V4)/double(R6);

diary off


%PRINT FILE FOR NGSPICE ANALYSIS 2
simf=fopen('data_simeq.txt','w');
fprintf(simf, 'R1 1 2 %fk\n', data(1,3));
fprintf(simf, 'R2 2 3 %fk\n', data(2,3));
fprintf(simf, 'R3 2 5 %fk\n', data(3,3));
fprintf(simf, 'R4 0 5 %fk\n', data(4,3));
fprintf(simf, 'R5 5 6 %fk\n', data(5,3));
fprintf(simf, 'R6 0 4 %fk\n', data(6,3));
fprintf(simf, 'R7 7 8 %fk\n', data(7,3));
fprintf(simf, 'Vs 1 0 DC 0\n');
fprintf(simf, 'Vf 4 7 DC 0\n');
%fprintf(simf, 'Vx 6 8 DC %f\n', double(V6-V8));
fprintf(simf, 'Gb 6 3 2 5 %fm\n', data(10,3));
fprintf(simf, 'Hd 5 8 Vf %fk\n', data(11,3));

fclose(simf);




%NODAL THEO 2
Vs = sym('0');
Vx = sym(sprintf('%.11f', double(V6-V8)));

syms V0eq V1eq V2eq V3eq V4eq V5eq V6eq V7eq V8eq Ix

Eq2_v0 = V0eq == 0;
Eq2_f = V4eq == V7eq;
Eq2_d = V5eq-V8eq == Kd*(V0eq-V4eq)/R6;
Eq2_s = V1eq-V0eq == Vs;
Eq2_2 = (V2eq-V1eq)/R1 + (V2eq-V5eq)/R3 + (V2eq-V3eq)/R2 == 0;
Eq2_3 = (V3eq-V2eq)/R2 - Kb*(V2eq-V5eq) == 0;
Eq2_0 = (V1eq-V2eq)/R1 + (V0eq-V4eq)/R6 + (V0eq-V5eq)/R4 == 0;
Eq2_6 = Kb*(V2eq-V5eq) + (V6eq-V5eq)/R5 + Ix == 0;
Eq2_7 = (V4eq-V0eq)/R6 + (V7eq-V8eq)/R7 == 0;
Eq2_x = Vx == V6eq-V8eq;

sn_eq = solve(Eq2_v0,Eq2_f,Eq2_d,Eq2_s,Eq2_2,Eq2_3,Eq2_0,Eq2_6,Eq2_7,Eq2_x);

diary "req_tab.tex"
diary on

V0eq = double(sn_eq.V0eq)
V1eq = double(sn_eq.V1eq)
V2eq = double(sn_eq.V2eq)
V3eq = double(sn_eq.V3eq)
V4eq = double(sn_eq.V4eq)
V5eq = double(sn_eq.V5eq)
V6eq = double(sn_eq.V6eq)
V7eq = double(sn_eq.V7eq)
V8eq = double(sn_eq.V8eq)
Req = double(Vx)/double(sn_eq.Ix)
tau = Req*1000*double(C)*10^(-6);
printf('$tau$ = %e', tau)
diary off


%NATUAL SOLUTION ANALYSIS

syms t
syms R
syms C
syms vc_n(t) %natural solution
syms i_n(t)

sim3f=fopen('data_sim3.txt','w');
fprintf(simf, 'R1 1 2 %fk\n', data(1,3));
fprintf(simf, 'R2 2 3 %fk\n', data(2,3));
fprintf(simf, 'R3 2 5 %fk\n', data(3,3));
fprintf(simf, 'R4 0 5 %fk\n', data(4,3));
fprintf(simf, 'R5 5 6 %fk\n', data(5,3));
fprintf(simf, 'R6 0 4 %fk\n', data(6,3));
fprintf(simf, 'R7 7 8 %fk\n', data(7,3));
fprintf(simf, 'Vs 1 0 DC %f\n', 0);
fprintf(simf, 'Vf 4 7 DC 0\n');
fprintf(simf, 'C 6 8 %fu\n', data(9,3));
fprintf(simf, 'Gb 6 3 2 5 %fm\n', data(10,3));
fprintf(simf, 'Hd 5 8 Vf %fk\n', data(11,3));

fclose(sim3f);
C = sym(sprintf('%.11f', data(9,3)));
R = sym(sprintf('%.11f', abs(Req)));

syms A
syms wn
vc_n(t) == A*exp(wn*t)

wn = -1/abs(tau)
A = double(Vx)

printf("\n\nNatural solution:\n");

t=0:1e-6:20e-3;
v6_n = A*exp(wn*t);

hf=figure(1)

plot(t*1000, v6_n, "g")

xlabel ("t[ms]");
ylabel ("v6_n[V]");
legend('v6_n(t)', 'Location', 'Northeast');
print (hf, "natural.eps", "-depsc");


%NODAL THEO 4 forced solution
f=1000
w=sym(sprintf('2*pi*%.11f', f))
C = sym(sprintf('%.11f', data(9,3)))
Vsp = sym (0-j)
Z = sym (0-1/(w*C)*j*10^6)

syms V0p V1p V2p V3p V4p V5p V6p V7p V8p Vxp

Eq3_v0 = V0p == 0;
Eq3_f = V4p == V7p;
Eq3_d = V5p-V8p == Kd*(V0p-V4p)/R6;
Eq3_s = V1p-V0p == Vsp;
Eq3_2 = (V2p-V1p)/R1 + (V2p-V5p)/R3 + (V2p-V3p)/R2 == 0;
Eq3_3 = (V3p-V2p)/R2 - Kb*(V2p-V5p) == 0;
Eq3_0 = (V1p-V2p)/R1 + (V0p-V4p)/R6 + (V0p-V5p)/R4 == 0;
Eq3_6 = Kb*(V2p-V5p) + (V6p-V5p)/R5 + (V6p-V8p)/Z == 0;
Eq3_7 = (V4p-V0p)/R6 + (V7p-V8p)/R7 == 0;
Eq3_x = Vxp == V6p-V8p;

sn_p = solve(Eq3_v0,Eq3_f,Eq3_d,Eq3_s,Eq3_2,Eq3_3,Eq3_0,Eq3_6,Eq3_7,Eq3_x);

diary "phaser_tab.tex"
diary on

V0p = double(abs(sn_p.V0p))
V1p = double(abs(sn_p.V1p))
V2p = double(abs(sn_p.V2p))
V3p = double(abs(sn_p.V3p))
V4p = double(abs(sn_p.V4p))
V5p = double(abs(sn_p.V5p))
V6p = double(abs(sn_p.V6p))
V7p = double(abs(sn_p.V7p))
V8p = double(abs(sn_p.V8p))

diary off


M_V6p = double(abs(sn_p.V6p))
A_V6p = double(angle(sn_p.V6p))
M_Vsp = double(abs(Vsp))
A_Vsp = double(angle(Vsp))

t=0:1e-6:20e-3;
v6_f = M_V6p*cos(double(w)*t-A_V6p);
vs_p = M_Vsp*cos(double(w)*t-A_Vsp);

hf = figure (2);
title('graph of forced from 0 to 20 ms')
plot (t*1000, v6_f, ";v6_f(t);", t*1000, vs_p,";vs_p(t);");

xlabel ("t [ms]");
ylabel ("v [V]");
legend('Location','northeast');
print (hf, "vs_v6_f.eps", "-depsc");


%NODAL THEO 4 total solution


v6_t = v6_n + v6_f;
ti=-5e-3:1e-6:0;
tt=cat(2,ti,t);

v6i=V6*ones(1,size(ti,2));
v6t_t=cat(2,v6i,v6_t);

vsi=data(8,3)*ones(1,size(ti,2));
vst=cat(2,vsi,vs_p);

hft = figure (3);
title('point 5 - graph from -5 to 20 ms')
plot (tt*1000, v6t_t, ";v6(t);", tt*1000, vst,";vs(t);");
xlabel ("t [ms]");
ylabel ("v [V]");
legend('Location','northeast');
print (hft, "theo5.eps", "-depsc");



