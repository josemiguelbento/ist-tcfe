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

%%NODAL METHOD
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
Gbn= I_r5

diary off