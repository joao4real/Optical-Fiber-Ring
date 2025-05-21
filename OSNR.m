 %Calculate Minimum OSNR - OSNR for longest path possible
    
function OSNR = OSNR(txrx,pase)

    p_txrx_ch = 10.^(txrx(:,7)/10)*10^-3;
    osnr = p_txrx_ch ./ pase;

    [~, x] = max(osnr(1,:));       
    osnr(:,x) = [];              % Remove shortest-path osnr
    
    OSNR = 10*log10(sum(1 ./ osnr,2).^-1);
end
