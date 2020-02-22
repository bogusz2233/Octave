% Scipt to help in solving problem in book named "Fundamentals of Physics", 
% Edition 2, PWN
% Halloday, Resick, Walker
% Problem 11 on 312 page, Volume 1

clc;                %% Clear all console
clear;              %% Clear all variables 

%First particle
mass1 = 0.5;
r10 = 0+0i
force1 = 2+3i;

%Second particle
mass2 = 1.5;
r20 = 1 + 2i;
force2 = -3 - 2i;

%Particles Acceleration
a1 = force1/mass1;
a2 = force2/mass2;

%Particles move in time = 0:4;
time = 0:0.1:4;

for(i = 1:length(time) )
r1(i) = r10 + 1/2*a1*time(i)^2;
r2(i) = r20 + 1/2*a2*time(i)^2;
endfor

rsm = (r1 * mass1 + r2 *mass2)/(mass1+mass2)
plot(time,r1);
hold on;
plot(time,r2);
plot(time,rsm);