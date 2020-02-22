% Scipt to help in solving problem in book named "Fundamentals of Physics", 
% Edition 2, PWN
% Halloday, Resick, Walker
% Problem 33 on 258 page, Volume 1

clc;                %% Clear all console
clear;              %% Clear all variables 

g = 9.81;
h1 = sin(deg2rad(37)) * 0.2;
k = 170;
x = 0.2;
m = 2;
V = sqrt(2*g*h1 + (k*x^2)/m );
printf("A) Speed: %d m/s \n",V);

%%Podpunt D
D = 1;
h2 = sin(deg2rad(37)) * D;
V2 = sqrt(2*g*h1 + 2*g*h2 + (k*x^2)/m );
printf("B) Speed: %d m/s \n",V2);