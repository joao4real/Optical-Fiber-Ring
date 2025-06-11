function epsilon = SpectralEfficiency(Rs,txrx,Bwdm,mod_ch)

Rb_ch = txrx(:,1:3);
Rbwdm = sum(Rb_ch*mod_ch.',2);

epsilon = Rbwdm / Bwdm;
end
