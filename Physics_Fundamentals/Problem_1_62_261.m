% Scipt to help in solving problem in book named "Fundamentals of Physics", 
% Edition 2, PWN
% Halloday, Resick, Walker
% Problem 62 on 261 page, Volume 1

clc;                %% Clear all console
clear;              %% Clear all variables 

g = 9.81;           %% gravity
L = 0.75;           %% length of road with friction
uk = 0.4;           %% friction coefficent
kat = deg2rad(30);  %% kat w radianach, nachylenie  stoku
Va  = 8;            %% predkosc w punkcie A;
h = 2;              %% wysokosc na jakiej zaczyna sie obszar z tarciem

%% obliczanie predkosci w punkcie B:
Vb_sqrt = Va^2 - 2*g*h - 2*g*L*sin(kat) - uk*g*cos(kat)*L;

if(Vb_sqrt < 0)
    printf("Speed lower than 0, body will not reach the point\n");    
else
    Vb = sqrt(Vb_sqrt);
    printf("Speed of body at this point equals: %.3d m/s\n",Vb);
endif