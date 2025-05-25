function pathAtts = Attenuation(paths)

% Values in dB
mfa = 0.2; % Max fiber attenuation
mfd = 0.02; % Max fiber attenuation difference
mas = 0.03; % Max splice attenuation
mca = 0.25; % Max conector attenuation

% Fiber section length
sl = 3e3;

paths = paths*1e3;
pathAtts = paths/1e3 * (mfa + mfd) + (ceil(paths/sl) - 1) * mas + 2 * mca;

end