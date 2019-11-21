%% housekeeping

clear
clc
close all


%% define constants:

% All in inches:

LDB = 22;
LEF = 18;
L_S_B = 12; % End-Shaker-to-start-tail span.
LGH = 4 * (1/2) ; 
LBC = 5;

% Beam cross section dimensions:

WidthBeam = 1;
t_Fueslage_Wing = 1/8;
tElevator = 1/4;
tRudder = 0.040;


% Material info: AL 6063-T7 Stock

E = 10175; %KSI
roh = 0.0002505; %lb-sec^2/in^4


%% define matrices
