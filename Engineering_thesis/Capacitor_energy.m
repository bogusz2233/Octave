clc;                %% Clear all console
clear;              %% Clear all variables 

pulse_time = 577 * 10^(-6);
amp_burst = 2;      %% 2A
voltage = 4;        %% GSM zasilanie
dVoltage = 0.3;     %% maksymalna zmiana napięcia

energy_needed = pulse_time * amp_burst * voltage;

%% Energy in capasitor
%% E = 1/2 * C * U^2  => C = 2 * E/(U^2)
%% E1 = 1/2 * (voltage-dVoltage) ^2 * C
%% E2 = 1/2 * voltage ^2 *C;
%% dE = energy_needed
%% energy_needed  = E2 - E1 = 1/2 * C(voltage^2 - (voltage-dVoltage)^2)
%% energy_needed  = 1/2 * voltage^2 * C * (1 - (dVoltage/voltage)^2 )
%% C = 2 * energy_needed / (1 - (dVoltage/voltage)^2 ) / voltage^2

%%C = 2 * energy_needed / (1 - (dVoltage/voltage)^2 ) / voltage^2;
C = 2 * energy_needed / (voltage^2 - (voltage-dVoltage)^2);
printf("Kondesator o pojemności %d uF \n",C *10^6);

%% czas ładowania 100mA
Energy_c = 1/2 * C * voltage^2;
dW = 0.2 * voltage;
printf("Kondesator będzie sie ładował %d mikrosekund \n", Energy_c/dW *10^3);

%%czas potrzebny na doładowanie
dEnergy = 1/2 * C*(voltage^2 - (voltage-dVoltage)^2);
printf("Kondesator będzie sie doładował %d mikrosekund \n", dEnergy/dW *10^3);