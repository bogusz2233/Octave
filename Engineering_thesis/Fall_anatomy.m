##Data anylise from sensor
clc;                %% Clear all console
clear;              %% Clear all variables 
clear all;
close all;

dataFileName = "badania/chodzenie/acc";
dataAltFileName = "badania/chodzenie/press";

data = load([ "./Inz_data/"  dataFileName  ".txt"]);
dataPress = load([ "./Inz_data/"  dataAltFileName  ".txt"]);

dataSize = size(data)(1);
dataAltSize = size(dataPress)(1);

avrSampleValue = 3;
avrDegValue = 100;
gThreshold = 3;
dThreshold = 0.5;

upCounter = 0;
downCounter = 0;

SampleToAvr = 5;
for i = 1:dataSize
  %Analiza danych z akcelorometru
  %%Przeliczenie czasu
  time(i) = data(i,1) / 1000;
  
  xAxis(i) = data(i,2)/ 4096;
  yAxis(i) = data(i,3)/ 4096;
  zAxis(i) = data(i,4)/ 4096;
  
   xAvr(i) = 0;
   yAvr(i) = 0;
   zAvr(i) = 0;
  if(i <= avrSampleValue)
   for( j = 1:i)
    xAvr(i) += xAxis(j);
    yAvr(i) += yAxis(j);
    zAvr(i) += zAxis(j);
   endfor
   xAvr(i) /= i;
   yAvr(i) /= i;
   zAvr(i) /= i;
   
 else
    for( j = i-avrSampleValue:i)
    xAvr(i) += xAxis(j);
    yAvr(i) += yAxis(j);
    zAvr(i) += zAxis(j);
   endfor
   xAvr(i) /= avrSampleValue+1;
   yAvr(i) /= avrSampleValue+1;
   zAvr(i) /= avrSampleValue+1;
  endif
  
  Wypadkowa(i) = sqrt(xAxis(i)^2 + yAxis(i)^2 + zAxis(i)^2);
  upLine(i) = gThreshold;
  downLine(i) = dThreshold;
  if(Wypadkowa(i) > gThreshold)
   upCounter++;
  elseif (Wypadkowa(i) < dThreshold)
   downCounter++;
  endif
  Wypadkowa2(i) = sqrt(xAvr(i)^2 + yAvr(i)^2 + zAvr(i)^2);
  
  %obliczenie kąta
  %%lx(i) = asin(sqrt(xAxis(i)^2/(xAxis(i)^2 + yAxis(i)^2 +zAxis(i)^2)));
  %%ly(i) = asin(sqrt(yAxis(i)^2/(xAxis(i)^2 + yAxis(i)^2 +zAxis(i)^2)));
  %%lz(i) = asin(sqrt(zAxis(i)^2/(xAxis(i)^2 + yAxis(i)^2 +zAxis(i)^2)));
  
  lx(i) = asin(sqrt(xAxis(i)^2/(xAxis(i)^2 + yAxis(i)^2 +zAxis(i)^2))) /pi*180;
  ly(i) = asin(sqrt(yAxis(i)^2/(xAxis(i)^2 + yAxis(i)^2 +zAxis(i)^2))) /pi*180;
  lz(i) = asin(sqrt(zAxis(i)^2/(xAxis(i)^2 + yAxis(i)^2 +zAxis(i)^2))) /pi*180;
  %srednia 
  lyAvr(i) = 0;
  if(i <= avrDegValue)
   for( j = 1:i)
    lyAvr(i) += ly(j);
   endfor
   lyAvr(i) /= i;
 else
    for( j = i-avrDegValue:i)
    lyAvr(i) += ly(j);
   endfor
   lyAvr(i) /= avrDegValue+1;
   lyAvr(i) += 2;
  endif
endfor

%Analiza danych z barometru
for i = 1:dataAltSize
  timeAlt(i) = dataPress(i,1) / 1000;
  
  altitude(i) = dataPress(i,2);

  if(bitget(dataPress(i,3) /16, 4) == 1)
   altitude(i) += 0.5;
 elseif(bitget(dataPress(i,3) /16,3) == 1)
  altitude(i) +=0.25;
 elseif(bitget(dataPress(i,3) /16,2) == 1)
  altitude(i) += 0.125;
 elseif(bitget(dataPress(i,3) /16,1) == 1)
  altitude(i) += 0.0625; 
endif

 pressureAltitudeAvr(i) = altitude(i);

 if(i<SampleToAvr)
   for(index = 1:i -1)
    pressureAltitudeAvr(i) += pressureAltitudeAvr(index);
   endfor
   pressureAltitudeAvr(i) /= i;
  
 else
  for(index = 1:SampleToAvr - 1)
    pressureAltitudeAvr(i) += altitude(i-index);
  endfor
   pressureAltitudeAvr(i) /= SampleToAvr;
 endif
endfor


figure(3);
hold off;
subplot (3, 1, 1);
hold on;
plot(time,Wypadkowa);
plot(time,upLine);
plot(time,downLine);
legend("Srednia geometryczna", "Gorny prog detekcji", "Dolny prog detekcji");

ylabel ("Przyspieszenie [g]");
axis([0,60,0,7]);
subplot (3, 1, 2);
%plot(time,lx);
hold on;
plot(time,ly);
plot(time,lyAvr);

legend("Rzeczywisty", "Usredniony");
axis([0,60,0,100]);
%plot(time,lz);
ylabel ("Kat w osi Y[deg]");
%legend("Xdeg", "Ydeg", "Zdeg");
subplot (3, 1, 3);
plot(timeAlt,altitude);
hold on;
plot(timeAlt,pressureAltitudeAvr);

legend("Rzeczywisty", "Usredniony");
ylabel("Wysokosc [m]");
xlabel("Czas [s]");
printf("Przekroczono dól %d\n",downCounter);
printf("Przekroczono gore %d\n",upCounter);