function [pase_pre,pase_pos,pase] = ASE(attpaths, vch, grid)

    gpos = 10^(1.7);              
    fn = 10^0.6;            
    h = 6.626e-34;           
    v0 = grid(1)*10^12;     

    pase_pre = fn * vch(:,1)*10^9 * (10.^(attpaths/10) - 1) * h * v0;
    pase_pos = fn *vch(:,1)*10^9 * (gpos - 1) * h * v0;
    pase = pase_pre + pase_pos;

    
 
end