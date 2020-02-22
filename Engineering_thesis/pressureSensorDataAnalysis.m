function pressureSensorDataAnalysis
clc;                %% czy�ci konsole
clear;              %% czy�ci zmienne   

global TIME_POS = 1;
global PRESS_ALT_POS  = 2;
global PRESS_ALT_FRAC_POS = 3;
global TEMP_POS = 4;
global TEMP_FRAC_POS = 4;
global MAX_DIFF = 0.7;
global SHOW_FROM = 100;

%% file with data to analysis
rawSensorData = load([ "./Inz_data/data_press5.txt"]);
rawDataSize = size(rawSensorData,1);
SampleToAvr = 5;
SampleToAvr2 = 10;

for i = 1:rawDataSize
  sampleTime(i) = rawSensorData(i,TIME_POS) /1000; 
  
  pressureAltitude(i) = rawSensorData(i, PRESS_ALT_POS);
  if(bitget(rawSensorData(i,PRESS_ALT_FRAC_POS) /16, 4) == 1)
   pressureAltitude(i) += 0.5;
 elseif(bitget(rawSensorData(i,PRESS_ALT_FRAC_POS) /16,3) == 1)
  pressureAltitude(i) +=0.25;
 elseif(bitget(rawSensorData(i,PRESS_ALT_FRAC_POS) /16,2) == 1)
  pressureAltitude(i) += 0.125;
 elseif(bitget(rawSensorData(i,PRESS_ALT_FRAC_POS) /16,1) == 1)
  pressureAltitude(i) += 0.0625;
endif

 pressureAltitudeAvr(i) = pressureAltitude(i);
 pressureAltitudeAvr2(i) = pressureAltitude(i);
 
 if(i<SampleToAvr)
   for(index = 1:i -1)
    pressureAltitudeAvr(i) += pressureAltitudeAvr(index);
   endfor
   pressureAltitudeAvr(i) /= i;
  
 else
  for(index = 1:SampleToAvr - 1)
   if(pressureAltitudeAvr(i - 1) - pressureAltitude(i-index) > MAX_DIFF)
    pressureAltitudeAvr(i) += pressureAltitudeAvr(i - 1) + MAX_DIFF;
   elseif (pressureAltitudeAvr(i - 1) - pressureAltitude(i-index) < -MAX_DIFF)
    pressureAltitudeAvr(i) += pressureAltitude(i - 1) - MAX_DIFF;
   else
    pressureAltitudeAvr(i) += pressureAltitude(i-index);
   endif
  endfor
   pressureAltitudeAvr(i) /= SampleToAvr;
 endif
 
  if(i<SampleToAvr2)
   for(index = 1:i -1)
    pressureAltitudeAvr2(i) += pressureAltitude(index);
   endfor
   pressureAltitudeAvr2(i) /= i;
  
 else
  for(index = 1:SampleToAvr2 - 1)
   if(pressureAltitudeAvr2(i - 1) - pressureAltitude(i-index) > MAX_DIFF)
    pressureAltitudeAvr2(i) += pressureAltitudeAvr(i - 1) + MAX_DIFF;
   elseif (pressureAltitudeAvr2(i - 1) - pressureAltitude(i-index) < -MAX_DIFF)
    pressureAltitudeAvr2(i) += pressureAltitude(i - 1) - MAX_DIFF;
   else
    pressureAltitudeAvr2(i) += pressureAltitude(i-index);
   endif
   
   
   %pressureAltitudeAvr2(i) += pressureAltitudeAvr2(i-index);
   endfor
   pressureAltitudeAvr2(i) /= SampleToAvr2;
 endif
 
 dataSample(i,1) = sampleTime(i);
 dataSample(i,2) = pressureAltitude(i);
endfor

save "data.txt" dataSample;
figure(3);
subplot (3, 1, 1);
plot(sampleTime(SHOW_FROM:rawDataSize), pressureAltitude(SHOW_FROM:rawDataSize));
titleSet = title("Dane z czujnikow OVR -130ms");;
ylabelSet = ylabel ("Wysokosc [m]");

subplot (3, 1, 2);
plot(sampleTime(SHOW_FROM:rawDataSize), pressureAltitudeAvr(SHOW_FROM:rawDataSize));

titleSet = title("Dane z czujnikow AVR = 5 sample");
ylabelSet = ylabel ("Wysokosc [m]");

subplot (3, 1, 3);
plot(sampleTime(SHOW_FROM:rawDataSize), pressureAltitudeAvr2(SHOW_FROM:rawDataSize));

titleSet = title("Dane z czujnikow AVR = 7 sample");
ylabelSet = ylabel ("Wysokosc [m]");

endfunction