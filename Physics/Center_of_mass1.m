clc;                %% Clear all console
clear;              %% Clear all variables 

close all;
time_sample =0.1;

%%czastka pierwsza
m1 = 1;     %% masa pierwszego ciala
v1 = [0,-2];     %%predkosc poczatkowa pierwszego ciala
pos10 = [0,20];  %%pozycja poczatkowa ciala pierwszego

%%czastka druga
m2 = 3;
v2 = [3,0];
pos20 = [-30,0];
time = 0:time_sample:10;

kat_deg = 20;
kat_zderzenia = deg2rad(kat_deg);    %% kat pod jakim zderzaj� si� czastki
kat_zderzenia180 = deg2rad(180 + kat_deg);
for i = 1:(10/time_sample)
  %% pozcycja pierwszego ciala
  pos1(1,i) = pos10(1) + v1(1) * i * time_sample;
  pos1(2,i) = pos10(2) + v1(2) * i * time_sample;
  
  %% pozcycja drugiego ciala
  pos2(1,i) = pos20(1) + v2(1) * i * time_sample;
  pos2(2,i) = pos20(2) + v2(2) * i * time_sample;
  
  %%srodek masy
  srodek(1,i) = ( pos1(1,i) * m1 + pos2(1,i) * m2 ) / (m1+m2);
  srodek(2,i) = ( pos1(2,i) * m1 + pos2(2,i) * m2 ) / (m1+m2);
endfor
printf("polczylilem przebiegi %s \n", ctime(now()));

%%obliczanie zmian srodka masy 
srodek(1,length(srodek(1,:))-1 );
dxsrodek = ( srodek(1,length(srodek(1,:))) - srodek(1,length(srodek(1,:)) - 1) );
dysrodek = srodek(2,length(srodek(2,:))) - srodek(2,length(srodek(2,:)) - 1);
wczesniejsza_dlugosc = length(srodek(1,:));

for i = wczesniejsza_dlugosc:(wczesniejsza_dlugosc + 10/time_sample)
  %%srodek masy
  srodek(1,i) = srodek(1,wczesniejsza_dlugosc) + dxsrodek * i;
  srodek(2,i) = srodek(2,wczesniejsza_dlugosc) + dysrodek * i;
endfor



%%po zderzeniu:
prev_v1 = v1;
prev_v2 = v2;

%% os X:
v1(1) = 2*m2/(m1 +m2) * prev_v2(1) * cos(kat_zderzenia);
v2(1) = (m1-m2)/(m1+m2) * prev_v2(1) * cos(kat_zderzenia180);

%% os Y:
v1(2) = (m1-m2)/(m1+m2) *  prev_v1(2) *cos(kat_zderzenia);
v2(2) = -2*m1/(m1 +m2) * prev_v1(2) *cos(kat_zderzenia180);

for i = 1:(20/time_sample)
  %% pozcycja pierwszego ciala
  
  pos1(1,(i + wczesniejsza_dlugosc)) = pos1(1, wczesniejsza_dlugosc) + v1(1) * i * time_sample;
  pos1(2,(i + wczesniejsza_dlugosc)) = pos1(2,wczesniejsza_dlugosc) + v1(2) * i * time_sample;
  
  %% pozcycja drugiego ciala
  pos2(1,(i + wczesniejsza_dlugosc)) = pos2(1,wczesniejsza_dlugosc) + v2(1) * i * time_sample;
  pos2(2,(i + wczesniejsza_dlugosc)) = pos2(2,wczesniejsza_dlugosc) + v2(2) * i * time_sample;
  
endfor;

%%sprawdzenie �rodka masy
for i = 1:(20/time_sample)
  srodek2(1,i) = ( m1 * pos1(1,(i +wczesniejsza_dlugosc)) + m2 * pos2(1,(i + wczesniejsza_dlugosc))  ) / (m1+m2);
  srodek2(2,i) = ( m1 * pos1(2,(i +wczesniejsza_dlugosc)) + m2 * pos2(2,(i + wczesniejsza_dlugosc)) ) / (m1+m2);
endfor;
screen = get(0,"screensize");
figure(1,"position",[(screen(1) + 5) (screen(2) + 80) (screen(3) - 5) (screen(4) - 180)]);
subplot(2,2,1);
hold on;    %%do zlapania przebieg�w na jednym
plot(pos1(1,:),pos1(2,:), 'r');
plot(pos2(1,:),pos2(2,:), 'g');
plot(srodek(1,:),srodek(2,:), 'y');
plot(srodek2(1,:),srodek2(2,:), 'p');
axis([-35 35 -25 25]);
hold off;
subplot(2,2,2);
plot(pos1(1,:),pos1(2,:), 'r');
hold on;
plot(pos2(1,:),pos2(2,:), 'g');
plot(srodek(1,:),srodek(2,:), 'y');
plot(srodek2(1,:),srodek2(2,:), 'p');
axis([-35 35 -25 25]);

function retval = avg (v)
  retval = "HAHA";
endfunction
printf("podane: %s \n",liczba);
