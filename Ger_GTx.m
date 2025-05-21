function [f1,f2,freqs_centrais,B_WDM,Bks,Pks_dBm,P_tot_dBm,Espac_canais_vec]=Ger_GTx(Spectrum_str,Nch,Espac_canais,P_tot_dBm,f_inicial,Bk,N_pontos_f1_f2,Roll_off,R_sl)

if (Spectrum_str==0)
    B_WDM=Nch*Espac_canais;     %%% Banda WDM ocupada pelo sinal
    Espac_canais_vec(1:Nch)=Espac_canais;
    Pks_dBm=(P_tot_dBm-10*log10(Nch))*ones(1,Nch);            %% Potencia dos canais WDM ao longo do espectro
    Bks=Bk*ones(1,Nch);        %% Largura de banda de cada um dos canais WDM
    
    %G_Tx_amp=(10.^(Pks_dBm/10)*1e-3)./Bks;      %%% Valor da DEP de cada um dos canais assumindo DEP rectangular
    
    freqs_centrais=f_inicial-(Nch-1)*Espac_canais:Espac_canais:f_inicial;         %% Frequencia central de cada canal WDM
    freqs_spacing=min(diff(freqs_centrais));
    df_min=freqs_spacing/N_pontos_f1_f2;
    
    f1=freqs_centrais(1)-N_pontos_f1_f2*2*df_min:df_min:freqs_centrais(end)+N_pontos_f1_f2*2*df_min;
    f2=freqs_centrais(1)-N_pontos_f1_f2*2*df_min:df_min:freqs_centrais(end)+N_pontos_f1_f2*2*df_min;
    
    %     f1=linspace(freqs_centrais(1)-Espac_canais_vec(1)/2,f_inicial+Espac_canais_vec(end)/2,N_pontos_f1_f2);          %% Frequencias que aparecem no GGN
    %     f2=linspace(freqs_centrais(1)-Espac_canais_vec(1)/2,f_inicial+Espac_canais_vec(end)/2,N_pontos_f1_f2);
    
    %%% rectangular filter
%     if (Roll_off==0)
%         for nn=1:Nch
%             G_Tx_ch(nn,:)=G_Tx_amp(nn)*f_rect(Bks(nn),f1,freqs_centrais(nn));
%             P_Tx_dBm(nn,:)=10*log10(10^(Pks_dBm(nn)/10)*1e-3*f_rect(Bks(nn),f1,freqs_centrais(nn)))+30;
%         end
%     end
    
    %%% raised_cosine filter
    %if (Roll_off~=0)
%         Bks=R_sl*ones(1,Nch);
%         G_Tx_amp=(10.^(Pks_dBm/10)*1e-3)./Bks;      %%% Valor da DEP de cada um dos canais assumindo DEP RC
%         for nn=1:Nch
%             G_Tx_ch(nn,:)=G_Tx_amp(nn)*raised_cossine_filter(R_sl,f1,freqs_centrais(nn),Roll_off);
%             P_Tx_dBm(nn,:)=10*log10(10^(Pks_dBm(nn)/10)*1e-3*f_rect(Bks(nn),f1,freqs_centrais(nn)))+30;
% %             figure(678)
% %             hold on
% %             plot(f1,G_Tx_ch(nn,:)),grid;
% %             pause
%         end
%     %end
%     
%     G_Tx_WDM=sum(G_Tx_ch);
    
%     figure(99)
%     plot(f1,G_Tx_WDM)
%     grid
%     xlabel('Frequencia [Hz]')
%     ylabel('DEP [W/Hz]')
%     title('Espectro transmitido do sinal WDM')
%     
%     figure(100)
%     plot(f1,P_Tx_dBm)
%     grid
%     xlabel('Frequencia [Hz]')
%     ylabel('Potencia [dBm]')
%     title('Potencia transmitida ao longo do sinal WDM')
    
%     P_WDM=trapz(f1,G_Tx_WDM);           %%% Confirmacao de que P_WDM=P_tot
%     P_WDM_dBm=10*log10(P_WDM)+30;
%     %pause
end

%%% Espectro com duas modulações intercaladas em que se mantém a potência por canal, mas varia-se a banda 
% if (Spectrum_str==1)
%     Pks_dBm=(P_tot_dBm-10*log10(Nch))*ones(1,Nch);            %% Potencia dos canais WDM ao longo do espectro
%     Bks=Bk*ones(1,Nch);        %% Largura de banda de cada um dos canais WDM
%     Bks(1:2:end)=2*Bk; 
%     Espac_canais_vec=Espac_canais*ones(1,Nch);        %% Espaçamento entre canais de cada um dos canais WDM
%     Espac_canais_vec(1:2:end)=2*Espac_canais
%     B_WDM=sum(Espac_canais_vec);
%       
%     G_Tx_amp=(10.^(Pks_dBm/10)*1e-3)./Bks;      %%% Valor da DEP de cada um dos canais assumindo DEP rectangular
%    
%     freqs_centrais(Nch)=f_inicial;
%     for ooo=Nch:-1:2
%         freqs_centrais(ooo-1)=freqs_centrais(ooo)-(Espac_canais_vec(ooo)/2+Espac_canais_vec(ooo-1)/2)
%     end
%     
%     freqs_spacing=min(diff(freqs_centrais));
%     df_min=freqs_spacing/N_pontos_f1_f2;      
%     f1=freqs_centrais(1)-N_pontos_f1_f2*2*df_min:df_min:freqs_centrais(end)+N_pontos_f1_f2*2*df_min;
%     f2=freqs_centrais(1)-N_pontos_f1_f2*2*df_min:df_min:freqs_centrais(end)+N_pontos_f1_f2*2*df_min;
%     
% %     f1=linspace(freqs_centrais(1)-Espac_canais_vec(1)/2,f_inicial+Espac_canais_vec(end)/2,N_pontos_f1_f2);          %% Frequencias que aparecem no GGN
% %     f2=linspace(freqs_centrais(1)-Espac_canais_vec(1)/2,f_inicial+Espac_canais_vec(end)/2,N_pontos_f1_f2);
%     
%     for nn=1:Nch
%         G_Tx_ch(nn,:)=G_Tx_amp(nn)*f_rect(Bks(nn),f1,freqs_centrais(nn));
%         P_Tx_dBm(nn,:)=10*log10(10^(Pks_dBm(nn)/10)*1e-3*f_rect(Bks(nn),f1,freqs_centrais(nn)))+30;
%     end
%     
%     G_Tx_WDM=sum(G_Tx_ch);
%     
% %     figure(99)
% %     plot(f1,G_Tx_WDM)
% %     grid
% %     xlabel('Frequencia [Hz]')
% %     ylabel('DEP [W/Hz]')
% %     title('Espectro transmitido do sinal WDM')
% %     
% %     figure(100)
% %     plot(f1,P_Tx_dBm)
% %     grid
% %     xlabel('Frequencia [Hz]')
% %     ylabel('Potencia [dBm]')
% %     title('Potencia transmitida ao longo do sinal WDM')
%     
%     P_WDM=trapz(f1,G_Tx_WDM);           %%% Confirmacao de que P_WDM=P_tot
%     P_WDM_dBm=10*log10(P_WDM)+30
%     %pause
% end
% 
% %%% Espectro com duas modulações intercaladas em que se mantém a banda por canal, mas varia-se a potência
% if (Spectrum_str==2)
%     B_WDM=Nch*Espac_canais;     %%% Banda WDM ocupada pelo sinal
%     Pks_dBm=P_ch_ref_dBm*ones(1,Nch);            %% Potencia dos canais WDM ao longo do espectro colocada na potência de referência
%     p_ref=10^(P_ch_ref_dBm/10)*1e-3;
%     p_tot=10^(P_tot_dBm/10)*1e-3;
%     Nch_ref=ceil(Nch/2);
%     Nch_2=Nch-Nch_ref;
%     pch_2=(p_tot-Nch_ref*p_ref)/Nch_2;
%     Pks_dBm(2:2:end)=10*log10(pch_2)+30;         % Atribuir a restante potência aos outros canais
%        
%     Bks=Bk*ones(1,Nch);        %% Largura de banda de cada um dos canais WDM
%     Espac_canais_vec=Espac_canais*ones(1,Nch);        %% Espaçamento entre canais de cada um dos canais WDM
%     B_WDM=sum(Espac_canais_vec);
%       
%     G_Tx_amp=(10.^(Pks_dBm/10)*1e-3)./Bks;      %%% Valor da DEP de cada um dos canais assumindo DEP rectangular
%    
%     freqs_centrais(Nch)=f_inicial;
%     for ooo=Nch:-1:2
%         freqs_centrais(ooo-1)=freqs_centrais(ooo)-(Espac_canais_vec(ooo)/2+Espac_canais_vec(ooo-1)/2);
%     end
%     
%     freqs_spacing=min(diff(freqs_centrais));
%     df_min=freqs_spacing/N_pontos_f1_f2;
%     f1=freqs_centrais(1)-N_pontos_f1_f2*2*df_min:df_min:freqs_centrais(end)+N_pontos_f1_f2*2*df_min;
%     f2=freqs_centrais(1)-N_pontos_f1_f2*2*df_min:df_min:freqs_centrais(end)+N_pontos_f1_f2*2*df_min;
%     
% %     f1=linspace(freqs_centrais(1)-Espac_canais_vec(1)/2,f_inicial+Espac_canais_vec(end)/2,N_pontos_f1_f2);          %% Frequencias que aparecem no GGN
% %     f2=linspace(freqs_centrais(1)-Espac_canais_vec(1)/2,f_inicial+Espac_canais_vec(end)/2,N_pontos_f1_f2);
%     
%     for nn=1:Nch
%         G_Tx_ch(nn,:)=G_Tx_amp(nn)*f_rect(Bks(nn),f1,freqs_centrais(nn));
%         P_Tx_dBm(nn,:)=10*log10(10^(Pks_dBm(nn)/10)*1e-3*f_rect(Bks(nn),f1,freqs_centrais(nn)))+30;
%     end
%     
%     G_Tx_WDM=sum(G_Tx_ch);
%     
% %     figure(99)
% %     plot(f1,G_Tx_WDM)
% %     grid
% %     xlabel('Frequencia [Hz]')
% %     ylabel('DEP [W/Hz]')
% %     title('Espectro transmitido do sinal WDM')
% %     
% %     figure(100)
% %     plot(f1,P_Tx_dBm)
% %     grid
% %     xlabel('Frequencia [Hz]')
% %     ylabel('Potencia [dBm]')
% %     title('Potencia transmitida ao longo do sinal WDM')
%     
%     P_WDM=trapz(f1,G_Tx_WDM);           %%% Confirmacao de que P_WDM=P_tot
%     P_WDM_dBm=10*log10(P_WDM)+30
%     %pause
% end
% 
% %%% Espectro com tres modulacoes posicionadas aleatoriamente em que se mantém a banda por canal, mas varia-se a potencia
% if (Spectrum_str==3)
%     Ch_pos=zeros(1,Nch);
%     Nch_1=ceil(Per_Nch_cada_mod(1)*Nch);
%     Nch_2=ceil(Per_Nch_cada_mod(2)*Nch);
%     Nch_3=Nch-(Nch_1+Nch_2);
%     Nch_cmod=[Nch_1 Nch_2 Nch_3];
%     
%     Nch_1_pos=sort(randperm(Nch,Nch_1));
%     Ch_pos(Nch_1_pos)=1;   %%% Sinalizar onde está a modulacao 1
%     Ch_detect=find(Ch_pos==0);
%     Nch_2_pos=Ch_detect(sort(randperm(length(Ch_detect),Nch_2)));
%     Ch_pos(Nch_2_pos)=2;   %%% Sinalizar onde está a modulacao 2
%     Ch_detect3=find(Ch_pos==0);
%     Nch_3_pos=Ch_detect3(sort(randperm(length(Ch_detect3),Nch_3)));
%     Ch_pos(Nch_3_pos)=3;   %%% Sinalizar onde está a modulacao 3
%     
%     Pks_dBm(Nch_1_pos)=P_ch_ref_dBm;            %% Potencia dos canais WDM ao longo do espectro colocada na potência de referencia
%     p_ref=10^(P_ch_ref_dBm/10)*1e-3;
%     p_tot=10^(P_tot_dBm/10)*1e-3;
%     p_rest=(p_tot-Nch_1*p_ref);   %% Potência que falta atribuir ao sinal WDM
%     pch_2=p_ref*(0.2+(4-0.2)*rand);         %% Gerar aleatoriamente a potência do canal 2 [-6 dBm, 6 dBm] acima do canal 1
%     Pks_dBm(Nch_2_pos)=10*log10(pch_2)+30;
%     Pks_dBm(Nch_3_pos)=10*log10((p_rest-pch_2*Nch_2)/Nch_3)+30;  
%     
% %     P_rest_dBm=P_tot_dBm-(P_ch_ref_dBm+10*log10(Nch_1))     %% Potencia que falta atribuir ao sinal WDM
% %     P_rest_ch_dBm=P_rest_dBm-(10*log10(Nch_2)+10*log10(Nch_3))   %%% Potência que falta atribuir por canal WDM
% %    
%       
%     Bks=Bk*ones(1,Nch);        %% Largura de banda de cada um dos canais WDM
%     Espac_canais_vec=Espac_canais*ones(1,Nch);        %% Espacamento entre canais de cada um dos canais WDM
%     B_WDM=sum(Espac_canais_vec);
%       
%     G_Tx_amp=(10.^(Pks_dBm/10)*1e-3)./Bks;      %%% Valor da DEP de cada um dos canais assumindo DEP rectangular
%    
%     freqs_centrais(Nch)=f_inicial;
%     for ooo=Nch:-1:2
%         freqs_centrais(ooo-1)=freqs_centrais(ooo)-(Espac_canais_vec(ooo)/2+Espac_canais_vec(ooo-1)/2);
%     end
%         
%     freqs_spacing=min(diff(freqs_centrais));
%     df_min=freqs_spacing/N_pontos_f1_f2;
%     f1=freqs_centrais(1)-N_pontos_f1_f2*2*df_min:df_min:freqs_centrais(end)+N_pontos_f1_f2*2*df_min;
%     f2=freqs_centrais(1)-N_pontos_f1_f2*2*df_min:df_min:freqs_centrais(end)+N_pontos_f1_f2*2*df_min;
%     
% %     f1=linspace(freqs_centrais(1)-Espac_canais_vec(1)/2,f_inicial+Espac_canais_vec(end)/2,N_pontos_f1_f2);          %% Frequencias que aparecem no GGN
% %     f2=linspace(freqs_centrais(1)-Espac_canais_vec(1)/2,f_inicial+Espac_canais_vec(end)/2,N_pontos_f1_f2);
%     
%     for nn=1:Nch
%         G_Tx_ch(nn,:)=G_Tx_amp(nn)*f_rect(Bks(nn),f1,freqs_centrais(nn));
%         P_Tx_dBm(nn,:)=10*log10(10^(Pks_dBm(nn)/10)*1e-3*f_rect(Bks(nn),f1,freqs_centrais(nn)))+30;
%     end
%     
%     G_Tx_WDM=sum(G_Tx_ch);
%     
% %     figure(99)
% %     plot(f1,G_Tx_WDM)
% %     grid
% %     xlabel('Frequencia [Hz]')
% %     ylabel('DEP [W/Hz]')
% %     title('Espectro transmitido do sinal WDM')
% %     
% %     figure(100)
% %     plot(f1,P_Tx_dBm)
% %     grid
% %     xlabel('Frequencia [Hz]')
% %     ylabel('Potencia [dBm]')
% %     title('Potencia transmitida ao longo do sinal WDM')
%     
%     P_WDM=trapz(f1,G_Tx_WDM);           %%% Confirmacao de que P_WDM=P_tot
%     P_WDM_dBm=10*log10(P_WDM)+30
%     %pause
% end
% 
% %%% Espectro flex-grid
% if (Spectrum_str==4)
%     Espac_canais_pos=randi(length(Possib_espacs),1,Nch);
%     Espac_canais_vec=Possib_espacs(Espac_canais_pos);
%     B_WDM=sum(Espac_canais_vec);
%     Bks=Possib_Bks(Espac_canais_pos);
%     Pks_dBm=Possib_Pch_dBm(Espac_canais_pos);   
%     P_tot_dBm=10*log10(sum(10.^(Pks_dBm/10)*1e-3))+30;
%     
%     %% Se se quiser impor potências aleatórias ao longo dos canais
% %     p_ref=10^(P_ch_ref_dBm/10)*1e-3;
% %     pks=p_ref*(0.2+(4-0.2)*rand(1,Nch));         %% Gerar aleatoriamente a potência do canal 2 [-6 dBm, 6 dBm] acima do canal 1
% %     Pks_dBm=10*log10(pks)+30;   
% %     P_tot_dBm=10*log10(sum(10.^(Pks_dBm/10)*1e-3))+30
%             
%     G_Tx_amp=(10.^(Pks_dBm/10)*1e-3)./Bks;      %%% Valor da DEP de cada um dos canais assumindo DEP rectangular
%    
%     freqs_centrais(Nch)=f_inicial;
%     for ooo=Nch:-1:2
%         freqs_centrais(ooo-1)=freqs_centrais(ooo)-(Espac_canais_vec(ooo)/2+Espac_canais_vec(ooo-1)/2);
%     end
%     
%     freqs_spacing=min(diff(freqs_centrais));
%     df_min=freqs_spacing/N_pontos_f1_f2;
%     f1=freqs_centrais(1)-N_pontos_f1_f2*2*df_min:df_min:freqs_centrais(end)+N_pontos_f1_f2*2*df_min;
%     f2=freqs_centrais(1)-N_pontos_f1_f2*2*df_min:df_min:freqs_centrais(end)+N_pontos_f1_f2*2*df_min;
%     
% %     f1=linspace(freqs_centrais(1)-Espac_canais_vec(1)/2,f_inicial+Espac_canais_vec(end)/2,N_pontos_f1_f2);          %% Frequencias que aparecem no GGN
% %     f2=linspace(freqs_centrais(1)-Espac_canais_vec(1)/2,f_inicial+Espac_canais_vec(end)/2,N_pontos_f1_f2);
%     
%     for nn=1:Nch
%         G_Tx_ch(nn,:)=G_Tx_amp(nn)*f_rect(Bks(nn),f1,freqs_centrais(nn));
%         P_Tx_dBm(nn,:)=10*log10(10^(Pks_dBm(nn)/10)*1e-3*f_rect(Bks(nn),f1,freqs_centrais(nn)))+30;
%     end
%     
%     G_Tx_WDM=sum(G_Tx_ch);
%     
% %     figure(99)
% %     plot(f1,G_Tx_WDM)
% %     grid
% %     xlabel('Frequencia [Hz]')
% %     ylabel('DEP [W/Hz]')
% %     title('Espectro transmitido do sinal WDM')
% %     
% %     figure(100)
% %     plot(f1,P_Tx_dBm,'ro-')
% %     grid
% %     xlabel('Frequencia [Hz]')
% %     ylabel('Potencia [dBm]')
% %     title('Potencia transmitida ao longo do sinal WDM')
%     
%     P_WDM=trapz(f1,G_Tx_WDM);           %%% Confirmacao de que P_WDM=P_tot
%     P_WDM_dBm=10*log10(P_WDM)+30
%     %pause
% end
