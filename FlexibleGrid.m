function [grid,mod_ch, n_ch] = FlexibleGrid(ch_sp, interval)

A_QAM = 0.45;
B_QAM = 0.3;
C_QAM = 0.25;

% Change given Channel Spacing from GHz to THz
ch_sp=ch_sp*1e-3;

% Change given interval from nm to pm
interval= interval*1e3;

% Minimum and Maximum frequency in THz
minf = round(physconst('LightSpeed') / interval(2),3);
maxf = round(physconst('LightSpeed') / interval(1),3);

%Central frequency unit
cf = 0.00625;

first_ch = 193.1 - floor((193.1 - minf - ch_sp/2)/cf) * cf;
last_ch = first_ch + floor((maxf - first_ch - ch_sp/2)/ch_sp) * ch_sp;

grid = first_ch:ch_sp:last_ch;

n_ch = length(grid);

n_chA = ceil(n_ch* A_QAM);
n_chB = ceil(n_ch* B_QAM);
n_chC = n_ch - n_chA - n_chB;
mod_ch = [n_chA n_chB n_chC];

end