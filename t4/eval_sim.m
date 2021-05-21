close all
clear all

datao = fopen('data_octave.txt','r');
DATAO = fscanf(datao,'%*s = %f');
fclose(datao);

Vcc = DATAO(1);
Vinm = DATAO(2);
Vinf = DATAO(3);
Rin = DATAO(4);
Ci = DATAO(5);
R1 = DATAO(6);
R2 = DATAO(7);
Rc = DATAO(8);
Re = DATAO(9);
Cb = DATAO(10);
Rout = DATAO(11);
Co = DATAO(12);
RL = DATAO(13);


dataf = fopen('./sim/result_sim.txt','r');
DATA = fscanf(dataf,'%*s = %f');
fclose(dataf);

dataf = fopen('./sim/result_sim_inc.txt','r');
DATAINC = fscanf(dataf,'%*s = %f');
fclose(dataf);


cost = Rin/1000 + Ci*1e6 + R1/1000 + R2/1000 + Rc/1000 + Re/1000 + Cb*1e6 + Rout/1000 + Co*1e6 + 2*0.1;
lco = DATA(1);
bandwidth = DATA(2) - DATA(1);
gain = DATA(4);
Ziabs = DATA(9);
Zoabs = DATAINC(3);
MERIT = gain*bandwidth/(cost*lco);


%datar = fopen('./mat/result_octave.txt','r');
%DATAR = fscanf(datar,'%*s = %f');
%fclose(datar);


%average_oct = DATAR(1);
%ripple_oct = DATAR(4);
%MERIT_oct = 1/cost/(ripple_oct+abs(average_oct-12)+1e-6);


diary merit.tex
diary on

printf('Zi & %d & kOhm\n', DATA(9));
printf('Zo & %d & Ohm\n', DATAINC(3));
printf('Cost & %d & MU\n', cost);
printf('lco & %.3f & V\n', lco);
printf('Bandwidth & %.3f & V\n', bandwidth);
printf('Gainv(out) & %.3f & V\n', gain);
printf('MERIT & %.4f & gold medals\n', MERIT);
diary off

%-----------------------------------------GARANTIA
%npn

%vc>vb
%vb>ve
%vc-ve > v_ce_sat

%pnp
%vc<vb
%ve-vc >v_ec_sat


