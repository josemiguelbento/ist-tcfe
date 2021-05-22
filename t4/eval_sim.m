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

diary valores.tex
diary on

printf('$V_{cc}$ & %d & V\n', Vcc);
printf('$abs(V_{in})$ & %d & V\n', Vinm);
%printf('$phase(V_{in})$ & %d & rad\n', Vinf);
printf('$R_{in}$ & %d & Ohm\n', Rin);
printf('$C_{i}$ & %d & F\n', Ci);
printf('$R_{1}$ & %d & Ohm\n', R1);
printf('$R_{2}$ & %d & Ohm\n', R2);
printf('$R_{c}$ & %d & Ohm\n', Rc);
printf('$R_{e}$ & %d & Ohm\n', Re);
printf('$C_{b}$ & %d & F\n', Cb);
printf('$R_{out}$ & %d & Ohm\n', Rout);
printf('$C_{o}$ & %d & F\n', Co);
printf('$R_{L}$ & %d & Ohm\n', RL);
diary off

%-----------------------------------------GARANTIA
%		npn

%		vc>vb

%		pnp
%		vc<vb

dataop = fopen('./sim/FAR_check.txt','r');
DATAOP = fscanf(dataop,'%*s = %f');
fclose(datao);

Vbase = DATAOP(1);
Vcoll = DATAOP(2);
Vemit = DATAOP(3);
Vemit2 = DATAOP(4);
Vin = DATAOP(5);
Vin2 = DATAOP(6);
Vout = DATAOP(7);
Vvcc = DATAOP(8);

dataopm = fopen('./mat/operating_point.txt','r');
DATAOPM = fscanf(dataopm,'%*s = %f');
fclose(dataopm);

Vbase_oct = DATAOPM(1);
Vcoll_oct = DATAOPM(2);
Vemit_oct = DATAOPM(3);
Vemit2_oct = DATAOPM(4);
Vin_oct = DATAOPM(5);
Vin2_oct = DATAOPM(6);
Vout_oct = DATAOPM(7);
Vvcc_oct = DATAOPM(8);

if ((Vcoll > Vbase) && (0<Vcoll))
  flag = "ok"
else
  flag = "bad"
endif

% mudar isto quando tivermos op do octave
if ((Vcoll_oct > Vbase_oct) && (0<Vcoll_oct))
  flag_oct = "ok"
else
  flag_oct = "bad"
endif

diary op.tex
diary on

printf('Vbase & %.4f & %.4f & V\n', Vbase, Vbase_oct);
printf('Vcoll & %.4f & %.4f & V\n', Vcoll, Vcoll_oct);
printf('Vemit & %.4f & %.4f & V\n', Vemit, Vemit_oct);
printf('Vemit2 & %.4f & %.4f & V\n', Vemit2, Vemit2_oct);
printf('Vin & %.4f & %.4f & V\n', Vin, Vin_oct);
printf('Vin2 & %.4f & %.4f & V\n', Vin2, Vin2_oct);
printf('Vout & %.4f & %.4f & V\n', Vout, Vout_oct);
printf('Vvcc & %.4f & %.4f & V\n', Vvcc, Vvcc_oct);
printf('FAR? & %s & %s & V\n', flag, flag_oct);
diary off


dataf = fopen('./sim/result_sim.txt','r');
DATA = fscanf(dataf,'%*s = %f');
fclose(dataf);

dataf = fopen('./sim/result_sim_inc.txt','r');
DATAINC = fscanf(dataf,'%*s = %f');
fclose(dataf);


cost = Rin/1000 + Ci*1e6 + R1/1000 + R2/1000 + Rc/1000 + Re/1000 + Cb*1e6 + Rout/1000 + Co*1e6 + 2*0.1;
lco = DATA(1);
uco = DATA(2);
bandwidth = DATA(2) - DATA(1);
gain = DATA(6);
Ziabs = DATA(9);
Zoabs = DATAINC(3);
MERIT = gain*bandwidth/(cost*lco);


datar = fopen('./mat/result_octave.txt','r');
DATAR = fscanf(datar,'%*s = %f');
fclose(datar);

datafreq = fopen('./mat/result_octave_lco_uco.txt','r');
DATAFREQ = fscanf(datafreq,'%*s = %f');
fclose(datafreq);

Zi_oct = DATAR(1);
Zo_oct = DATAR(2);
Zi1_oct = DATAR(3);
Zo1_oct = DATAR(4);
Zi2_oct = DATAR(5);
Zo2_oct = DATAR(6);
uco_oct = uco;
lco_oct = DATAFREQ(2);
bandwidth_oct = uco_oct-lco_oct;
gain_oct = DATAR(7);
MERIT_oct = gain_oct*bandwidth_oct/(cost*lco_oct);


diary merit.tex
diary on

printf('$Zi_{total}$ & %d & %d & Ohm\n', DATA(9), Zi_oct);
printf('$Zo_{total}$ & %d & %d & Ohm\n', DATAINC(3), Zo_oct);
printf('$Zi_{gain}$ & - & %d & Ohm\n', Zi1_oct);
printf('$Zo_{gain}$ & - & %d & Ohm\n', Zo1_oct);
printf('$Zi_{output}$ & - & %d & Ohm\n', Zi2_oct);
printf('$Zo_{output}$ & - & %d & Ohm\n', Zo2_oct);
printf('Cost & %d & %d & MU\n', cost, cost);
printf('uco & %.3f & %.3f & Hz\n', uco, uco_oct);
printf('lco & %.3f & %.3f & Hz\n', lco, lco_oct);
printf('Bandwidth & %.3f & %.3f & Hz\n', bandwidth, bandwidth_oct);
printf('$Gain_{gainstage}$ & - & %.3f & [adimensional]\n', DATAR(8));
printf('$Gain{outputstage}$ & - & %.3f & [adimensional]\n', DATAR(9));
printf('$Gain{total}$ & %.3f & %.3f & [adimensional]\n', gain, gain_oct);
printf('MERIT & %.4f & %.4f & gold medals\n', MERIT, MERIT_oct);
diary off


