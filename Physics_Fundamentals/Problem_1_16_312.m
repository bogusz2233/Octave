% Scipt to help in solving problem in book named "Fundamentals of Physics", 
% Edition 2, PWN
% Halloday, Resick, Walker
% Problem 16 on 261 page, Volume 1

clc;                %% Clear all console
clear;              %% Clear all variables 

ml = 30;       %% masa lodzi
mr = 80;       %% masa Ricardo
x = 3/2;       %% odleglosc ich oboje od srodka loodzi
dx = 0.4;      %% przesuni�cie lodzi

mc = (-dx * ml + (2*x - dx) * mr) / (2*x + dx);    
printf("Camelita wazy: %.3d kg\n", mc);