function optimal_Margin = Optimal(pase,eta_fi,ROSNR,txrx,worst_ch,cN_ch,cCh_sp,c_Lv,c_Rsl)

pase_val = zeros(length(worst_ch),1);
eta_val = zeros(length(worst_ch),1);

    for i=1:length(worst_ch)
        pase_val(i) = pase(i,worst_ch(i));
        eta_val(i) = eta_fi(i,worst_ch(i));
    end

 x = nthroot(pase_val ./ (2*eta_val), 3);
 P_opt = min(txrx(:,7),10*log10(x)+30); 
 p_opt = 10.^(P_opt/10)*1e-3;
 cTxrx = [txrx(:,4:6) P_opt];
 
 nli = zeros(height(cTxrx),cN_ch);
  for i=1:height(cTxrx)
      nli(i,:)= GN_model_project_Mvec(cTxrx(i,1:4),70,cN_ch,cCh_sp,c_Lv,c_Rsl(i));
  end

 osnr = p_opt ./ (pase+nli);
 optimal_Margin = Margin(10*log10(osnr),ROSNR);

end