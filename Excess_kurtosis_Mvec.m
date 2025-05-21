M_Modul=M_vec;
for ffg=1:length(M_Modul)  
    if (M_Modul(ffg)==0)
        %%% Gaussian modulation
        Exc_kurt(ffg)=0;
    elseif (M_Modul(ffg)==4)
        %%% Uniform QPSK
        Exc_kurt(ffg)=-1;
    elseif (M_Modul(ffg)==8)
        %%% 2ASK/QPSK - Star8QAM
        Exc_kurt(ffg)=-0.64;
    elseif (M_Modul(ffg)==16)
        %%% Uniform 16-QAM
        Exc_kurt(ffg)=-0.68;
    elseif (M_Modul(ffg)==32)
        %%% 32-QAM
        Exc_kurt(ffg)=-69/100;
    elseif (M_Modul(ffg)==64)
        %%% Uniform 64-QAM
        Exc_kurt(ffg)=-0.619;
    elseif (M_Modul(ffg)==256)
        %%% Uniform 256-QAM
        Exc_kurt(ffg)=-0.605;
    else
        %%% Uniform inf-QAM
        Exc_kurt(ffg)=-0.6;
    end
end
