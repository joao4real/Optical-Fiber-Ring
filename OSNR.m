 %Calculate Minimum OSNR - OSNR for longest path possible
    
 function OSNR = OSNR(txrx,pase,nli)

    p_txrx_ch = 10.^(txrx(:,7)/10)*10^-3;
    p_txrx_ch = repmat(p_txrx_ch, 1, length(pase));
    pn = pase + nli;
    osnr = p_txrx_ch ./ pn;
    %osnr = p_txrx_ch ./ pase;
    OSNR = 10*log10(osnr);
end
