close all
clear all

datao = fopen('data_octave.txt','r');
DATAO = fscanf(datao,'%*s = %f');
fclose(datao);

Renv = DATAO(1);
C = DATAO(2);
Rreg = DATAO(3);
n = DATAO(4);
n_diodes = DATAO(5);

dataf = fopen('./sim/result_sim.txt','r');
DATA = fscanf(dataf,'%*s = %f');
fclose(dataf);

diary merit.txt
diary on
Renv
C
Rreg
n
n_diodes
cost = Renv/1000 + C*1e6 + Rreg/1000 + n_diodes*2*0.1+4*0.1
average = DATA(1)
ripple = DATA(4)

MERIT = 1/cost/(ripple+abs(average-12)+1e-6)

diary off
