function accelerometerDataAnalysis
clc;                %% Clear all console
clear;              %% Clear all variables 

global TIME_POS = 1;
global X_AXIS_POS = 2;
global Y_AXIS_POS = 3;
global Z_AXIS_POS = 4;

%% file with data to analysis
rawSensorData = load([ "./Inz_data/data_acc4.txt"]);
rawDataSize = size(rawSensorData,1);

for i = 1:rawDataSize
  sampleTime(i) = rawSensorData(i,TIME_POS) /1000; 
  
  xAxisAcceleration(i) = rawSensorData(i,X_AXIS_POS) /16 / 4096 * 9.81;
  yAxisAcceleration(i) = rawSensorData(i,Y_AXIS_POS) /16 / 4096 * 9.81; 
  zAxisAcceleration(i) = rawSensorData(i,Z_AXIS_POS) /16 / 4096 * 9.81; 
endfor


%present data
figure(1);

plot(sampleTime, xAxisAcceleration);
hold on;
plot(sampleTime, yAxisAcceleration);
plot(sampleTime, zAxisAcceleration);
axisa = axis;
axisa(2) = 50;
axis(axisa);
titleSet = title("Dane z czujników");
legendSet = legend ("x Axis", "y Axis","z Axis", "location", "southoutside");
ylabelSet = ylabel ("Przyspieszenie [m/s]");

set (legendSet, "fontsize", 20);
set (titleSet, "fontsize", 30);
set (ylabelSet, "fontsize", 25);
endfunction