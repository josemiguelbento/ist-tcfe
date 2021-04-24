close all
clear all

pkg load symbolic;

format long;

%option = 1 %half wave rectifier
option = 2 %full wave rectifier

%variables -----------------------------------------
Renv = 5e3
C = 5e-6
f=50;
vini = 230;
Rreg = 5e3

%transformer -----------------------------------------
n = 10
A = vini/n;

%envelope detector -----------------------------------------

t=linspace(0, 10/f, 1000);
w=2*pi*f;
vSenv = A * cos(w*t);
vOhr = zeros(1, length(t));
vOenv = zeros(1, length(t));

tOFF = 1/w * atan(1/w/Renv/C);

vOnexp = A*cos(w*tOFF)*exp(-(t-tOFF)/Renv/C);

figure 1
if option == 1
	for i=1:length(t)
	  if (vSenv(i) > 0)
	    vOhr(i) = vSenv(i);
	  else
	    vOhr(i) = 0;
	  endif
	endfor
endif

if option == 2
	for i=1:length(t)
	  vOhr(i) = abs(vSenv(i));
	endfor
endif

for i=1:length(t)
  if t(i) < tOFF
    vOenv(i) = vOhr(i);
  elseif vOnexp(i) > vOhr(i)
    vOenv(i) = vOnexp(i);
  else
    tOFF = tOFF + 1/f/option;
    vOnexp = A*abs(cos(w*tOFF))*exp(-(t-tOFF)/Renv/C);
    vOenv(i) = vOhr(i);
  endif
endfor

cum = mean(vOenv)
ripple_env = max(vOenv) - min(vOenv)

average_env = min(vOenv)+ripple_env/2

%plot(t*1000, vOhr)
%hold
%plot(t*1000, vOenv)
%title("Envelope output voltage v_o(t)")
%xlabel ("t[ms]")
%legend("rectified","envelope")
%print ("vout_envlope.eps", "-depsc");

%voltage regulator -----------------------------------------
n_diodes = 17
von = 0.7;

vOreg = zeros(1, length(t));
vOreg_dc = 0;
vOreg_ac = zeros(1, length(t));

%dc component regulator ----------------
if average_env >= von*n_diodes
  vOreg_dc = von*n_diodes;
else
  vOreg_dc = average_env;
endif

%ac component regulator -----------------
vt = 0.026;
Is = 1e-14;
new = 1;

rd = new*vt/(Is*exp(von/(new*vt)))

vOreg_ac = n_diodes*rd/(n_diodes*rd+Rreg) * (vOenv-average_env);

vOreg = vOreg_dc + vOreg_ac;


%plots ----------------------------------------------

%output voltages at rectifier, envelope detector and regulator
hfc = figure(1);
title("Regulator and envelope output voltage v_o(t)")
plot (t*1000, vOhr, ";vo_{rectifier}(t);", t*1000,vOenv, ";vo_{envelope}(t);", t*1000,vOreg, ";vo_{regulator}(t);");
xlabel ("t[ms]")
ylabel ("v_O [Volts]")
legend('Location','northeast');
print (hfc, "all_vout.eps", "-depsc");

%Deviations (vO - 12) 
hfc = figure(2);
title("Deviations from desired DC voltage")
plot (t*1000,vOreg-12, ";vo-12 (t);");
xlabel ("t[ms]")
ylabel ("v_O [Volts]")
legend('Location','northeast');
print (hfc, "deviation.eps", "-depsc");


average_reg = mean(vOreg)
ripple_reg = max(vOreg)-min(vOreg)

quality = 1/ripple_reg + 1/abs(average_reg-12) 

cost = Renv/1000 + Rreg/1000 + C*1e6 + 0.1 + n_diodes*0.1; %o 0.1 e do diodo do envelope detector 

if option == 1
  cost = cost + 0.1
elseif option == 2
  cost = cost + 0.4
endif

MERIT = quality/cost

