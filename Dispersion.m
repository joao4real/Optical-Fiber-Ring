function dispersion = Dispersion(grid,paths)

%Get longest path
s = sort(paths);
L = sum(s(2:end));

% To analyse the worst case scenario, highest wavelength must be
% choosen to have max dispersion
wlmax = physconst('LightSpeed')/(grid(end)*10^3);

%Zero dispersion wavelength in nm
wl0 = 1317;

%Zero dispersion slope in ps/(nm2*km)
s0 = 0.088;

%Dispersion coefficient
D = (s0/4)*(wlmax - (wl0^4/wlmax^3));

%Total Dispersion
dispersion = D*L;

end
