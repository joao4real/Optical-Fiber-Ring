function [dispersion,latency,N_taps] = Dispersion(grid,paths,Rs)

%Get longest path
s = sort(paths);
L = sum(s(2:end));

% To analyse the worst case scenario, highest   wavelength must be
% choosen to have max dispersion
wlmax = physconst('LightSpeed')/(grid(1)*10^3);

%Zero dispersion wavelength in nm
wl0 = 1317;

%Zero dispersion slope in ps/(nm2*km)
s0 = 0.088;

%Dispersion coefficient
D = (s0/4)*(wlmax - (wl0^4/wlmax^3));

%Total Dispersion
dispersion = abs(D)*L;

%Number of samples per symbol
SpS = 2;

%Truncate Rs
Rs = Rs(:,1)*1e9;

%Symbol interval
Ts = 1./Rs;

%Sampling interval
Tsamp = Ts / SpS;

% Convert dispersion from ps/nm to s/m
disp_s_per_m = dispersion * 1e-3;

% Convert wl0 from nm to meters
wlmax_m = wlmax * 1e-9;

% Compute number of taps
N_taps = 2 * floor((disp_s_per_m * wlmax_m^2) ./ (2 * physconst('LightSpeed') * Tsamp.^2)) + 1;

% Latency
latency = N_taps .* Tsamp;

end