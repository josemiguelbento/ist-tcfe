close all
clear all

%data generation ------------------------------------------

data = fopen('data_octave.txt','r');
DATA = fscanf(data,'%*s = %f');
fclose(data);


R1 = DATA(6)
R2 = DATA(7)
R3 = DATA(8)
R4 = DATA(9)
C1 = DATA(11)
C2 = DATA(12)

cost = (R1+R2+R3+R4)/1000 + (C1+C2)*1000000

%data from octave ------------------------------------------
data_oct = fopen('./mat/results_oct.txt','r');
DATAOCT = fscanf(data_oct,'%*s = %f');
fclose(data_oct);

lco_oct = DATAOCT(1)/2/pi
uco_oct = DATAOCT(2)/2/pi
fo_oct =DATAOCT(4)
gain_oct = DATAOCT(5)
gain_db_oct = DATAOCT(6)
Z_in_oct = DATAOCT(7)
Z_out_oct = DATAOCT(8) 

gain_deviation_oct = abs(100-gain_oct)
frequency_deviation_oct = abs(fo_oct-1000)

MERIT_oct = 1/(cost*gain_deviation_oct*frequency_deviation_oct);

%data from ngspice ---------------------------------------------------

data_sim = fopen('./sim/result_sim.txt','r');
DATASIM = fscanf(data_sim,'%*s = %f');
fclose(data_sim);

uco_sim = DATASIM(1)
lco_sim = DATASIM(2)
fo_sim =DATASIM(3)
gain_sim = DATASIM(5)
gain_db_sim = DATASIM(6)
Z_in_sim = DATASIM(7)
%Z_out_sim = DATASIM(8) 

gain_deviation_sim = abs(100-gain_sim)
frequency_deviation_sim = abs(fo_sim-1000)

MERIT_sim = 1/(cost*gain_deviation_sim*frequency_deviation_sim);


diary merit.tex
diary on

printf('$Zi_{total}$ & %d & %d & Ohm\n', Z_in_sim, Z_in_oct);
%printf('$Zo_{total}$ & %d & %d & Ohm\n', DATAINC(3), Zo_oct);



printf('uco & %.3f & %.3f & Hz\n', uco_sim, uco_oct);
printf('lco & %.3f & %.3f & Hz\n', lco_sim, lco_oct);
printf('fo & %.3f & %.3f & Hz\n', fo_sim, fo_oct);
printf('$f_{deviation}$ & %.3f & %.3f & Hz\n', frequency_deviation_sim , frequency_deviation_oct);


printf('$Gain_{total}$ & %.3f & %.3f & [adimensional]\n', gain_sim, gain_oct);
printf('$Gain_{deviation}$ & %.3f & %.3f & [adimensional]\n', gain_deviation_sim , gain_deviation_oct);

printf('Cost & %d & %d & MU\n', cost, cost);

printf('MERIT & %.4f & %.4f & gold medals\n', MERIT_sim, MERIT_oct);
diary off

