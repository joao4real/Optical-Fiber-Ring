 %Calculate Minimum OSNR - OSNR for longest path possible
    
 function OSNR = OSNR(txrx,pase,nli)

    p_txrx_ch = repmat(10.^(txrx(:,7)/10)*10^-3, 1, length(pase));
    OSNR = 10*log10(p_txrx_ch ./ (pase + nli));
    
end
