function Margin = Margin(OSNR,ROSNR)

% Transmission penalty
TP = 1;

% Margin in dB
Margin = OSNR - ROSNR - TP;

end