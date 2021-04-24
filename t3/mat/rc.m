close all
clear all

pkg load symbolic;

format long;

%option = 1 %half wave rectifier
option = 2 %full wave rectifier

%envelope detector
R = 1000
C = 1e-6
A=5
t=linspace(0, 5e-3, 1000);
f=1000;
w=2*pi*f;
vS = A * cos(w*t);
vOhr = zeros(1, length(t));
vO = zeros(1, length(t));

tOFF = 1/w * atan(1/w/R/C);

vOnexp = A*cos(w*tOFF)*exp(-(t-tOFF)/R/C);

figure
if option == 1
	for i=1:length(t)
	  if (vS(i) > 0)
	    vOhr(i) = vS(i);
	  else
	    vOhr(i) = 0;
	  endif
	endfor
endif

if option == 2
	for i=1:length(t)
	  vOhr(i) = abs(vS(i));
	endfor
endif

plot(t*1000, vOhr)
hold

for i=1:length(t)
  if t(i) < tOFF
    vO(i) = vOhr(i);
  elseif vOnexp(i) > vOhr(i)
    vO(i) = vOnexp(i);
  else
    tOFF = tOFF + 1/f/option;
    vOnexp = A*abs(cos(w*tOFF))*exp(-(t-tOFF)/R/C);
    vO(i) = vOhr(i);
  endif
endfor

plot(t*1000, vO)
title("Output voltage v_o(t)")
xlabel ("t[ms]")
legend("rectified","envelope")
print ("venvlope.eps", "-depsc");
