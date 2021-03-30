close all
clear all

%data_gen

datafile=fopen('data.txt','r');
data=fscanf(datafile, '%s = %f', [3 inf]);
data = data';
fclose(datafile);

simf=fopen('data_sim.txt','w');
fprintf(simf, 'R1 1 2 %fk\n', data(1,3));
fprintf(simf, 'R2 2 3 %fk\n', data(2,3));
fprintf(simf, 'R3 2 5 %fk\n', data(3,3));
fprintf(simf, 'R4 4 5 %fk\n', data(4,3));
fprintf(simf, 'R5 5 6 %fk\n', data(5,3));
fprintf(simf, 'R6 4 7 %fk\n', data(6,3));
fprintf(simf, 'R7 7 8 %fk\n', data(7,3));
fprintf(simf, 'Vs 1 4 DC %f\n', data(8,3));
fprintf(simf, 'Vf 9 7 DC 0\n');
fprintf(simf, 'C 6 8 %fu\n', data(9,3));
fprintf(simf, 'Gb 6 3 2 5 %fm\n', data(10,3));
fprintf(simf, 'Hd 5 8 Vf %fk\n', data(11,3));

fclose(simf);

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic

syms t
syms R
syms C
syms vi(t)
syms vo(t)
syms i(t)

i(t)=C*diff(vo,t)

printf("\n\nKVL equation:\n");

vi(t) = R*i(t)+vo(t)

syms vo_n(t) %natural solution
syms vo_f(t) %forced solution

printf("\n\nSolution is of the form");

v(t) = vo_n(t) + vo_f(t)

printf("\n\nNatural solution:\n");
syms A
syms wn

vi(t) = 0 %no excitation
i_n(t) = C*diff(vo_n, t)


printf("\n\n Natural solution is of the form");
vo_n(t) = A*exp(wn*t)

R*i_n(t)+vo_n(t) == 0

R*C*wn*vo_n(t)+vo_n(t) == 0

R*C*wn+1==0

solve(ans, wn)


%%EXAMPLE NUMERIC COMPUTATIONS

R=1e3 %Ohm
C=100e-9 %F

f = 1000 %Hz
w = 2*pi*f; %rad/s

%time axis: 0 to 10ms with 1us steps
t=0:1e-6:10e-3; %s

Zc = 1/(j*w*C)
Cgain = Zc/(R+Zc)
Gain = abs(Cgain)
Phase = angle(Cgain)

vi = 1*cos(w*t);
vo = Gain*cos(w*t+Phase);

hf = figure ();
plot (t*1000, vi, "g");
hold on;
plot (t*1000, vo, "b");

xlabel ("t[ms]");
ylabel ("vi(t), vo(t) [V]");
print (hf, "forced.eps", "-depsc");
