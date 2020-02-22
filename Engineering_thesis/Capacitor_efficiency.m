clc;                %% czy�ci konsole
clear;              %% czy�ci zmienne 
close all;

Up=3.85;
Uk=[0:0.05:Up];
C=3.45*10^(-3);

Ec = 1/2 * C *Up^2;
size = length(Uk);

for i = 1:size
  Ep(i)=1/2*C*(Up^2-Uk(i)^2);
  sprawnosc(i) = Ep(i)/Ec * 100;
  rozladowanie(i) = Uk(i)/Up *100;
endfor

plot(rozladowanie,sprawnosc, "linewidth", 2);
titleSet = title("Wykorzystanie energii zgromadzonej w kondensatorze");
%set (titleSet, "fontsize", 40);

ylableSet = ylabel ("Wykorzystanie energii [%]");
%set (ylableSet, "fontsize", 20);

xlableSet = xlabel ("Napiecie rozladowania kondensatora [V]");
%set (xlableSet, "fontsize", 20);
grid on;