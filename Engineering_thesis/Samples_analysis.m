clc;                %% Clear all console
clear;              %% Clear all variables 

clear all;

dataFileName = "data";

data = load([ "./Inz_data/"  dataFileName  ".txt"]);%./Inz_data/data_press.txt;

START_FROM_SAMPLE = 2;
PRESS_SENSOR = 0;
pressSum = 0;

dataSize = size(data)(1);
SampleToAvr = 5;
for i = 1:dataSize
  if(data(i,1) < 0)
  time(i) = time(i-1) + 1;  
  else
  time(i) = data(i,1) / 1000;
  endif
  
  xAxis(i) = data(i,2) /16/ 1024 * 9.81;
  yAxis(i) = data(i,3) /16/ 1024 * 9.81;
  zAxis(i) = data(i,4) /16/ 1024  * 9.81;
  %fraction count
  fractionPress = 0;
 if(bitget((data(i,6) /16), 4) == 1)
   fractionPress += 0.5;
 elseif(bitget((data(i,6) /16),3) == 1)
  fractionPress +=0.25;
 elseif(bitget((data(i,6) /16),2) == 1)

  fractionPress += 0.125;
 elseif(bitget((data(i,6) /16),1) == 1)
  fractionPress += 0.0625;
endif


 if(PRESS_SENSOR == 1)
  altitude(i) = 0;
  altitude(i) += data(i,5) * 2^8;
  altitude(i) += data(i,6);
  altitude(i) /= 2^4;
  altitude(i) -= mod(altitude(i), 2^2);
  altitude(i) /= 2^2;
  altitude(i) += fractionPress;
 else
 altitude(i) = data(i,5) +fractionPress;
 endif
 pressSum += altitude(i);
 
 fractionTemp = 0;
  if(bitget((data(i,8) /16), 4) == 1)
   fractionTemp += 0.5;
 elseif(bitget((data(i,8) /16),3) == 1)
  fractionTemp +=0.25;
 elseif(bitget((data(i,8) /16),2) == 1)
  fractionTemp += 0.125;
  elseif(bitget((data(i,8) /16),1) == 1)
  fractionTemp += 0.0625;
 endif
 
 altitude2(i) = altitude(i);
 if(i<SampleToAvr)
   for(index = 1:i -1)
    altitude2(i) += altitude2(index);
   endfor
   altitude2(i) /= i;
  
 else
  for(index = 1:SampleToAvr - 1)
   altitude2(i) += altitude2(i-index);
   endfor
   altitude2(i) /= SampleToAvr;
 endif
 
 temperature(i) = data(i,7);

endfor

altitude2Avr = 0;
for (i = 1:dataSize)
   altitude2Avr += altitude2(i);
endfor
altitude2Avr /= dataSize;

for i = 1:dataSize
  avrPlot(i) =altitude2Avr;
endfor

hold off;
subplot (3, 1, 1)
plot(time(START_FROM_SAMPLE:dataSize), xAxis(START_FROM_SAMPLE:dataSize), "-", "linewidth", 1);

hold on;
plot(time(START_FROM_SAMPLE:dataSize), yAxis(START_FROM_SAMPLE:dataSize), "-", "linewidth", 1);
plot(time(START_FROM_SAMPLE:dataSize), zAxis(START_FROM_SAMPLE:dataSize), "-", "linewidth", 1);

legenSet = legend ("x Axis", "y Axis","z Axis");
titleSet = title("Dane z czujników");

ylableSet = ylabel ("Przyspieszenie [m/s]");
set (legenSet, "fontsize", 30);
set (titleSet, "fontsize", 40);
set (ylableSet, "fontsize", 20);


subplot (3, 1, 2)
plot(time(START_FROM_SAMPLE:dataSize), altitude(START_FROM_SAMPLE:dataSize), "-", "linewidth", 1);
hold on;
plot(time(START_FROM_SAMPLE:dataSize), avrPlot(START_FROM_SAMPLE:dataSize), "-", "linewidth", 1);
ylableSet = ylabel ("Wysokość [m]");
set (ylableSet, "fontsize", 20);
axixa = axis;
hold off;
subplot (3, 1, 3)
plot(time(START_FROM_SAMPLE:dataSize), altitude2(START_FROM_SAMPLE:dataSize), "-", "linewidth", 1);
ylableSet = ylabel ("Wysokość średnia [m]");
hold on;
plot(time(START_FROM_SAMPLE:dataSize), avrPlot(START_FROM_SAMPLE:dataSize), "-", "linewidth", 1);
a = axis;
a(3)=116.2;
a(4)=118;
axis(axixa);
set (ylableSet, "fontsize", 20);
pressSum/dataSize