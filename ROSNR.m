function ROSNR = ROSNR(txrx,n_ch,mod_ch)

%Net Coding Gain
Gcn = txrx(:,9);

% Probability of information bit error
Pbi = 1e-15;

% Modulation
M = txrx(:,4:6);

%FEC
FEC = 1e-2.*txrx(:,10);

% Calculate Qi
Qi = sqrt(2)*erfcinv(2*Pbi);

% Calculate Qfec
Qfec =10.^(log10(Qi) - (Gcn/20) -0.5*log10(1+FEC)); 

% Calculate Pbl
Pbl = 0.5*erfc(Qfec/sqrt(2));

% Calculate rosnr
rosnr = zeros(8,3);

for i = 1:length(Pbl)
    for j = 1: size(M,2)
        switch M(i,j)
            case 8
                rosnr(i,j) = (3 + sqrt(3)) * erfcinv((16/11)*Pbl(i))^2;
            case 32
                rosnr(i,j) = 20 * erfcinv((240/91)*Pbl(i))^2;
            otherwise
                rosnr(i,j) = (2/3) * (M(i,j) - 1) * (erfcinv((Pbl(i) * log2(M(i,j))) / (2 * (1 - 1 / sqrt(M(i,j))))))^2;
        end
    end
end

 ROSNR = zeros(height(txrx),n_ch); 
 k=1;
 for j = 1:width(mod_ch)
    pat = k:k + mod_ch(j) - 1;
    ROSNR(:, pat) = repmat(10*log10(rosnr(:, j)), 1, width(pat));
    k = k + mod_ch(j);
 end
end