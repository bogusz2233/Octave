% Scipt to help in solving problem in book named "Fundamentals of Physics", 
% Edition 2, PWN
% Halloday, Resick, Walker
% Problem 63 on 261 page, Volume 1

clc;                %% Clear all console
clear;              %% Clear all variables 

d = 3.7;            %% odleglosc do spre�yny
k = 0.15 * 10^6;    %% stala sprezyny [N/m]
m = 1800;           %% masa windy 
Ft = 4.4 * 10^3;    %% sila hamowania windy
g = 9.81;           %% stala grawitacji

%% Podpunkt A:
V1 = sqrt(2*g*d - Ft*d/m * 2);
printf("Podpunkt A:\n");
printf("Predkosc przy zetknieciu z sprezyna wynosi V1 = %.3d m/s\n", V1);

%% Podpunkt B:
a = 1/2 * k;
b = Ft -g *m;
c = -V1^2 * m / 2;
printf("\nPodpunkt B:\n");
if((b^2 -4 * a * c) > 0);
  X1 = - b - sqrt(b^2 -4 * a * c);
  X2 = - b + sqrt(b^2 -4 * a * c);
  
  X1 /= 2*a;
  X2 /= 2*a; 
  printf("odleglosc jaka przebedzie winda zanim wyhamuje to x1 = %.3d m lub x2 = %.3d m \n", X1,X2);
  if(X2 > 0)
    X = X2;
  else
    X = X1;
  endif;
  printf("Czyli sprezyna zegnie sie na X = %d cm\n", round(X * 100));
else
  printf("Delta jest ujemna\n");
endif

%% Podpunkt c:
printf("\nPodpunkt C:\n");
h = (1/2 * X^2 * k )/ (m * g + Ft);
printf("Wysokosc na jaka ponownie wzniesie sie winda wynosi h = %.3d m\n", h);

%% Podpunkt c:
printf("\nPodpunkt D:\n");
S = m * g * d / Ft;
printf("Calkowita droga jaka przebedzie winda zanim calkowicie wychamuje wyniesie S = %.3d m\n",S); 