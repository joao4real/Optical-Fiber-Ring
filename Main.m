% Clear the workspace and functions before rerunning
clear;
clc;
clear functions;

% Define mapping: 'HD' = 1, 'SD' = 0 in position 8
A = [100, 150, 200, 4, 8, 16, 1, 1, 8.0, 7, 15000, -1, -29];
B = [100, 150, 200, 4, 8, 16, 0, 1, 9.2, 11, 10000, 2, -30];
C = [100, 150, 200, 4, 8, 16, -2, 0, 8.9, 20, 20000, 0, -27];
D = [100, 150, 200, 4, 8, 16, 2, 0, 9.8, 22.5, 8000, 1, -25];
E = [300, 400, 500, 8, 16, 32, 0, 0, 8.9, 20, 9000, 2, -33];
F = [300, 400, 500, 8, 16, 32, 1, 0, 10.9, 22.5, 15000, 0, -27];
G = [200, 400, 500, 4, 16, 32, -2, 0, 10.0, 25, 25000, 3, -29];
H = [200, 400, 500, 4, 16, 32, 1, 0, 10.9, 22.5, 20000, 1, -31];

txrx = [A;B;C;D;E;F;G;H];

% Channel minimum bandwidth
vch = Transceivers(txrx);

L1 = 57;   %Coimbra - Arganil
L2 = 75;   %Arganil - Viseu
L3 = 61;   %Viseu - Arouca
L4 = 71;   %Arouca - Aveiro   
L5 = 84;   %Aveiro - Figueira da Foz
L6 = 53;   %Figueira da Foz - Coimbra

% All path's length
paths = [L1 L2 L3 L4 L5 L6];

% Paths' attenuation
attpaths = Attenuation(paths);

% List components bandwidth
edfa15  = [1527.9,1565.6];
wss100  = [1528.5785,1566.9278];
twinwss = [1527.6049,1568.3623];

% Get bandwidth interval
range = BandwithRange(edfa15,wss100,twinwss);

% Define channel-spacing
ch_sp = 62.5;

% Get flexible grid
grid = FlexibleGrid(ch_sp,range);

% Dispersion of longest path
D = Dispersion(grid,paths);

% Calculate OSNR of longest path
OSNR = OSNR(attpaths,vch,grid,txrx);