% Scipt to help in solving problem in book named "Fundamentals of Physics", 
% Edition 2, PWN
% Halloday, Resick, Walker
% Problem 35 on 259 page, Volume 1

clc;                %% Clear all console
clear;              %% Clear all variables 

g = 9.81;
m = 3.2;  
k = 431;
x = 21 * 0.01;  %% cm => m
d = 1/2 * k*x^2 /(m*g*sin(deg2rad(30))) - x;
printf("A) Distance d = %d m \n",d);
printf("A) Distance d = %d cm \n",d * 100);

%%Subpoint B
x2=0:0.001:10;
y= 1/2 *m * g * x2.^2 * cos(deg2rad(90-30)) -(1/6 *k*x2.^3);
plot(x2,y)