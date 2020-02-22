clc;                %% czy�ci konsole
clear;              %% czy�ci zmienne   

global TIME_POS = 1;
global PRESS_ALT_POS  = 2;
global PRESS_ALT_FRAC_POS = 3;
global TEMP_POS = 4;
global TEMP_FRAC_POS = 4;
global SHOW_FROM = 100;

%% file with data to analysis
rawSensorData = load([ "./Inz_data/data_press5.txt"]);
rawDataSize = size(rawSensorData,1);
SampleToAvr = 5;
SampleToAvr2 = 10;
SampleToAvr3 = 15;

function retval = countLimitedAvr(sample, tableSize, memoryCount)
  MAX_DIFF = 1;
  
  for i=1:tableSize
   data(i) = 0;
   
   if(i<memoryCount)  
    for(index =0:(i-1))
    data(i) += sample(i - index);
    endfor
    data(i)/= i;
   else
    
    for(index =0:(memoryCount - 1))
    data(i - 1) - sample(i-index)
      if((data(i - 1) - sample(i-index) ) > MAX_DIFF)
       data(i) += data(i - 1) + MAX_DIFF
      else
       data(i) += sample(i - index);
      endif
    endfor
    
    data(i) /= memoryCount;
    
  endif
 endfor
 retval = data; 
endfunction

function retval = countCommonAvr(sample, tableSize, memoryCount)
  
  for i=1:tableSize
   data(i) = 0;
   
   if(i<memoryCount)  
    for(index =0:(i-1))
    data(i) += sample(i - index);
    endfor
    data(i)/= i;
   else
    for(index =0:(memoryCount - 1))
    data(i) += sample(i - index);
    endfor
    data(i)/= memoryCount;
    
  endif
 endfor
 
 retval = data; 
endfunction

function plotData(xValue, yValue)
  plot(xValue(200:600), yValue(200:600));
  axis([240,750,153,157.5]);
  ylabelSet = ylabel ("Wysokosc [m]");
  xlabelSet = xlabel ("Czas [s]");
endfunction

for i = 1:rawDataSize
  sampleTime(i) = rawSensorData(i,TIME_POS) /1000; 
  pressureAltitude(i) = rawSensorData(i, PRESS_ALT_POS);
  
  % Change binnary number to trurh number
  if(bitget(rawSensorData(i,PRESS_ALT_FRAC_POS) /16, 4) == 1)
   pressureAltitude(i) += 0.5;
 elseif(bitget(rawSensorData(i,PRESS_ALT_FRAC_POS) /16,3) == 1)
  pressureAltitude(i) +=0.25;
 elseif(bitget(rawSensorData(i,PRESS_ALT_FRAC_POS) /16,2) == 1)
  pressureAltitude(i) += 0.125;
 elseif(bitget(rawSensorData(i,PRESS_ALT_FRAC_POS) /16,1) == 1)
  pressureAltitude(i) += 0.0625;
 endif
endfor

 %Calculate value with K1
 firstAvr = countCommonAvr(pressureAltitude,rawDataSize,5);
 secondAvr = countCommonAvr(pressureAltitude,rawDataSize,10);
 thirdAvr = countCommonAvr(pressureAltitude,rawDataSize,20);
 
 %present data
 figure(1);
 subplot (2, 2, 1);
 plotData(sampleTime, pressureAltitude);
 titleSet = title("Dane rzeczywiste");
 
 subplot (2, 2, 2);
 plotData(sampleTime, firstAvr);
 titleSet = title("K= 5");
 
 subplot (2, 2, 3);
 plotData(sampleTime, secondAvr);
 titleSet = title("K= 10");
 
 subplot (2, 2, 4);
 plotData(sampleTime, thirdAvr);
 titleSet = title("K= 20");
 
 
  %Calculate value with K1
 firstLimitedAvr = countLimitedAvr(pressureAltitude,rawDataSize,5);
 secondLimitedAvr = countLimitedAvr(pressureAltitude,rawDataSize,10);
 thirdLimitedAvr = countLimitedAvr(pressureAltitude,rawDataSize,20);

  %present data
 figure(2);
  subplot (2, 2, 1);
  plot(sampleTime(200:600), firstLimitedAvr(200:600));
 %%plotData(sampleTime, pressureAltitude);
 %%titleSet = title("Dane rzeczywiste");
 
 subplot (2, 2, 2);
 plotData(sampleTime, firstLimitedAvr);
 titleSet = title("K= 5");
 
 subplot (2, 2, 3);
 plotData(sampleTime, secondLimitedAvr);
 titleSet = title("K= 10");
 
 subplot (2, 2, 4);
 plotData(sampleTime, thirdLimitedAvr);
 titleSet = title("K= 20");
 