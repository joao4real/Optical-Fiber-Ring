function grid = NumberOfChannels(ch_sp, interval)

% Change given Channel Spacing from GHz to THz
ch_sp=ch_sp*1e-3;

% Change given interval from nm to pm
interval= interval*1e3;

% Minimum and Maximum frequency in THz
minf = round(physconst('LightSpeed') / interval(2),3);
maxf = round(physconst('LightSpeed') / interval(1),3);

%Frequency slot
fs = 0.00625;

last_ch = 193.1 + floor((maxf - 193.1 - (ch_sp/2))/fs)*fs;
first_ch = last_ch - floor((minf - last_ch + ch_sp/2)/-ch_sp)*ch_sp;

grid = first_ch:ch_sp:last_ch;

end