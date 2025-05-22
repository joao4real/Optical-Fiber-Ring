function optimal_Margin = Optimal(pase,eta_fi,ROSNR)

pch_opt = nthroot(pase ./ (2*eta_fi),3);
osnr_opt = pch_opt ./ (1.5 * pase);
optimal_Margin = Margin(10*log10(osnr_opt),ROSNR);

end