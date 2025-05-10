function OSNR = CalculateOSNR(attpaths, vch, grid,txrx)

    gpos = 10^(1.65);              
    fn = 10^0.6;            
    h = 6.626e-34;           
    v0 = grid(end)*10^12;     
    B0 = vch;

    two_pase_pre = fn * B0(:,1)*10^9 * (10.^(attpaths/10) - 1) * h * v0;
    two_pase_pos = fn * B0(:,1)*10^9 * (gpos - 1) * h * v0;
    
    pase = two_pase_pre + two_pase_pos;
    p_txrx = 10.^(txrx(:,7)/10)*10^-3;
    
    osnr = p_txrx ./ pase;

    %Calculate Minimum OSNR - OSNR for longest path possible
    
    [~, x] = max(osnr(1,:));       
    osnr(:,x) = [];              % Remove shortest-path osnr
    
    OSNR = 10*log10(sum(1 ./ osnr, 2).^-1);

end