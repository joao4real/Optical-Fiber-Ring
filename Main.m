% Clear the workspace and functions before rerunning
clear;
clc;
clear functions;

%Insertion/Extraction Factor
Z = 0.3;

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
Rs = Transceivers(txrx);

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
ch_sp = [50 62.5];

% Get flexible grid and extracted wavelengths
[grid1,mod_ch1,n_ch1] = FlexibleGrid(ch_sp(1),range);
Dlamda1 = ceil(Z*length(grid1));

[grid2,mod_ch2,n_ch2] = FlexibleGrid(ch_sp(end),range);
Dlamda2 = ceil(Z*length(grid2));

% Dispersion of longest path
[dispersion,latency] = Dispersion(grid1,paths,Rs);

% Calculate ASE Noise
pase1 = ASE(attpaths, Rs, grid1);
pase2 = ASE(attpaths, Rs, grid2);

%Get NLI
[nli1,eta_fi1] = NLI(txrx,70,n_ch1,ch_sp(1),grid1(end),Rs(:,1));
[nli2,eta_fi2] = NLI(txrx,70,n_ch2,ch_sp(2),grid2(end),Rs(:,1));

% Calculate OSNR of longest path
OSNR1 = OSNR(txrx,pase1,nli1);
OSNR2 = OSNR(txrx,pase2,nli2);

% Calculate ROSNR
ROSNR1 = ROSNR(txrx,n_ch1,mod_ch1);
ROSNR2 = ROSNR(txrx,n_ch2,mod_ch2);

% Calculate Margin
Margin1 = Margin(OSNR1,ROSNR1);
Margin1 = Margin1(1:4,:);
Margin2 = Margin(OSNR2,ROSNR2);
Margin2 = Margin2(5:8,:);

%Plot graphs
%figure(1);
%Plot(grid1, Margin1);

%figure(2);
%Plot(grid2, Margin2);

%Optimal state
optimal_Margin1 = Optimal(pase1,eta_fi1,ROSNR1);
optimal_Margin1 = optimal_Margin1(1:4,:);
optimal_Margin2 = Optimal(pase2,eta_fi2,ROSNR2);
optimal_Margin2 = optimal_Margin2(5:8,:);

%Plot graphs
figure(1);
Plot(grid1, optimal_Margin1);

figure(2);
Plot(grid2, optimal_Margin2);

