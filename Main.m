%% housekeeping

clear
clc
close all


% Done by:

% Elliot Mckee
% Alex Lowry
% Dawson Weis
% Abdulla AlAmeri



%% define constants:

% All in inches:

% LDB = 22;
% LEF = 18;
% L_S_B = 12; % End-Shaker-to-start-tail span.
% LGH = 4 * (1/2) ; 
% LBC = 5;
% 
% % Beam cross section dimensions:
% 
% WidthBeam = 1;
% t_Fueslage_Wing = 1/8;
% tElevator = 1/4;
% tRudder = 0.040;
% 
% 

% - - - - - - - - - - - - - - - - -
% constants from table 1:


%  Material info: AL 6063-T7 Stock

E = 10175; %KSI
roh = 0.0002505; %lb-sec^2/in^4


% ALL english units, check table 1 for details
L = 12;
LE = 4.5;
LR = 5;
w = 1;
h = 1/8;
hE = 1/4;
hR = 0.040;
MT = 1.131;
ST = 0.5655;
IT = 23.124;
A = w*h;
Izz = ( w*h^3 )  / 12 ;


CM2 = (roh*A*L) / 100800;
CK2 = (4*E*Izz) / L^3 ; 
CM4 = (roh*A*L) / 806400 ;
CK4 = (8*E*Izz) / L^3 ; 

%% define matrices


%% FOR 2 ELEMENTS:

% M2 is made up of two matricies:
M2_subMatrix1 = [ 19272    1458*L      5928      -642*L    0     0 ; ...
                  1458*L   172*L^2     642*L     -73*L^2   0     0 ; ...
                  5928     642*L       38544     0         5928  -642*L ; ...
                  -642*L   -73*L^2     0         344*L^2   642*L  -73*L^2 ; ...
                  0        0           5928      642*L     19272  -1458*L ; ...
                  0        0           -642*L    -73*L^2   -1458*L 172*L^2 ; ...
                  ];
              
M2_subMatrix2 = zeros(6);
M2_subMatrix2(5,5) = MT;
M2_subMatrix2(5,6) = ST;
M2_subMatrix2(6,5) = ST;
M2_subMatrix2(6,6) = IT;

M2 = CM2 * M2_subMatrix1 + M2_subMatrix2 ;

K2 = CK4 * ...
    [24,  6*L,   -24,  6*L,   0,    0;...
             6*L, 2*L^2, -6*L, L^2,   0,    0;...
             -24, -6*L,  48,   0,     -24,  6*L;...
             6*L, L^2,   0,    4*L^2, -6*L, L^2;...
             0,   0,     -24,  -6*L,  24,   -6*L;...
             0,   0,     6*L,  L^2,   -6*L, 2*L^2];
         
         

%% FOR 4 ELEMENTS:

M4_subMatrix1 = zeros(10);

M4_subMatrix1(1,1) = 77088;
M4_subMatrix1(1,2) = 2916*L;
M4_subMatrix1(1,3) = 23712;
M4_subMatrix1(1,4) = -1284*L;

M4_subMatrix1(2,1) = 2916*L;
M4_subMatrix1(2,2) = 172*L^2;
M4_subMatrix1(2,3) = 1284*L;
M4_subMatrix1(2,4) = -73*L^2;


M4_subMatrix1(3,1) = 23712;
M4_subMatrix1(3,2) = 1284*L;
M4_subMatrix1(3,3) = 154176;
M4_subMatrix1(3,5) = 23712;
M4_subMatrix1(3,6) = -1284*L;

M4_subMatrix1(4,1) = -1284*L;
M4_subMatrix1(4,2) = -73*L^2;
M4_subMatrix1(4,4) = 344*L^2;
M4_subMatrix1(4,5) = 1284*L;
M4_subMatrix1(4,6) = -73*L^2;

M4_subMatrix1(5,3) = 23712;
M4_subMatrix1(5,4) = 1284*L;
M4_subMatrix1(5,5) = 154176;
M4_subMatrix1(5,7) = 23712;
M4_subMatrix1(5,8) = -1284*L;

M4_subMatrix1(6,3) = -1284*L;
M4_subMatrix1(6,4) = -73*L^2;
M4_subMatrix1(6,6) = 344*L^2;
M4_subMatrix1(6,7) = 1284*L;
M4_subMatrix1(6,8) = -73*L^2;


M4_subMatrix1(7,5) = 23712;
M4_subMatrix1(7,6) = 1284*L;
M4_subMatrix1(7,7) = 154176;
M4_subMatrix1(7,9) = 23712;
M4_subMatrix1(7,10) = -1284*L;

M4_subMatrix1(8,5) = -1284*L;
M4_subMatrix1(8,6) = -73*L^2;
M4_subMatrix1(8,8) = 344*L^2;
M4_subMatrix1(8,9) = 1284*L;
M4_subMatrix1(8,10) = -73*L^2;


M4_subMatrix1(9,7) = 23712;
M4_subMatrix1(9,8) = 1284*L;
M4_subMatrix1(9,9) = 77088;
M4_subMatrix1(9,10) = -2916*L;

M4_subMatrix1(10,7) = -1284*L;
M4_subMatrix1(10,8) = -73*L^2;
M4_subMatrix1(10,9) = -2916*L;
M4_subMatrix1(10,10) = 172*L^2;



M4_subMatrix2 = zeros(10);
M4_subMatrix2(9,9) = MT;
M4_subMatrix2(9,10) = ST;
M4_subMatrix2(10,9) = ST;
M4_subMatrix2(10,10) = IT;


M4 = CM4*M4_subMatrix1 + M4_subMatrix2 ;



K4 = CK4 * ...
    [96,    12*L,   -96,    12*L,   0,     0,     0,     0,     0,       0;...
             12*L,  2*L^2,  -12*L,  L^2,    0,     0,     0,     0,     0,       0;...
             -96,   -12*L,  192,    0,      -96,   12*L,  0,     0,     0,       0;...
             12*L,  L^2,    0,      4*L^2,  -12*L, L^2,   0,     0,     0,       0;...
             0,     0,      -96,    -12*L,  192,   0,     -96,   12*L,  0,       0;...
             0,     0,      12*L,   L^2,    0,     4*L^2, -12*L, L^2,   0,       0;...
             0,     0,      0,      0,      -96,   -12*L, 192,   0,     -96,     12*L;...
             0,     0,      0,      0,      12*L,  L^2,   0,     4*L^2, -12*L^2, L^2;...
             0,     0,      0,      0,      0,     0,     -96,   -12*L, 96,      -12*L;...
             0,     0,      0,      0,      0,     0,     12*L,  L^2,   -12*L,   2*L^2];
         

