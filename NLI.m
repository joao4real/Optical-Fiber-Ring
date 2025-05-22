function [nli,eta_fi] = NLI(txrx,cL_sec,cN_ch,cCh_sp,c_Lv,c_Rsl)
    
nli = zeros(height(txrx),cN_ch);
eta_fi = zeros(height(txrx),cN_ch);

    for i=1:height(txrx)
        [nli(i,:),eta_fi(i,:)] = GN_model_project_Mvec(txrx(i,4:7),cL_sec,cN_ch,cCh_sp,c_Lv,c_Rsl(i));
    end

end

