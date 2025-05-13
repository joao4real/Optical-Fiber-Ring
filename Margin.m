function Margin = Margin(OSNR,ROSNR)

% Transmission penalty
TP = 1;

% Margin in dB (For now only considering ASE noise)
Margin = OSNR - ROSNR - TP;

end