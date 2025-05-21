clear all

%% GN model só funciona em equivalente passa-baixo
c_luz=physconst('Lightspeed');
Perc_AQAM=0.45; Perc_BQAM=0.3; Perc_CQAM=0.25; 

M_impA=4;
M_impB=4;
M_impC=4;     
n_spans_total=1;  %% Número de spans
%Lambda0=c_luz/193e12;
Lambda0=1550e-9;    %% Comprimento de onda de referencia
gama=1.3e-3;       % Coeficiente de nao-linearidade da fibra
alfa_dB_km=0.2;      % coeficiente de atenuacao em dB
L_sec=100e3;       % Comprimento da seccao de fibra em m
%CR=0.028*1e-15;     % Slope do ganho de Raman (da aproximação triangular
CR=0;      %% Without SRS
D_lambda=17e-6;    % ParÃ¢metro de dispersao da fibra (s/m^2);
% S_lambda=0.07*1e3;  % Declive da dispersao da fibra (s/m^3);
S_lambda=0;
Nch=41;             % Numero de canais WDM
Espac_canais=50e9;          %%% Espacamento entre canais de referencia
P_ch_ref_dBm=0;
f_inicial=194.28e12;   % Frequencia inicial da banda C
R_sl=28e9;          %% Ritmo de símbolo
Roll_off=0;       %% factor de excesso de banda
Bk=R_sl;        %% Largura de banda de cada canal
P_tot_dBm=P_ch_ref_dBm+10*log10(Nch);
N_pontos_f1_f2=1024;     %%% Manter uma potencia de 2
Res_WDM=1;     %% Intervalo entre canais para fazer o cálculo do GN-model       

MQAM_Mvec;          % Definição dos parâmetros dos transceptores

Spectrum_str=0;
% Spectrum_str=0;     %%% Espectro WDM uniforme ao longo de toda a frequencia (potencia e banda)
% Spectrum_str=1;   %%% Espectro WDM com potencias uniformes, mas com duas modulacoes intercaladas (2 larguras de banda diferentes)
% Spectrum_str=2;   %%% Espectro WDM com bandas uniformes, mas com duas modulacoes intercaladas (2 potencias diferentes)
% Spectrum_str=3;   %%% Espectro WDM com bandas uniformes, mas com tres modulacoes com canais posicionados aleatoriamente (3 potencias diferentes)
% Spectrum_str=4;   %%% Espectro WDM com tres modulacoes com canais posicionados aleatoriamente (3 potencias e bandas diferentes diferentes)
%                     %% Nesta opcao P_tot nÃo e controlado e espacamento, banda e potencias sao impostos por Possib_... arrays
                    %% Pode ser alterada para gerar potencias aleatorias em torno de p_ref nos varios canais
alfa_Np_m=1e-4*alfa_dB_km/log10(exp(1));
%alfa_Np_m=alfa_dB_km/4.343*1e-3;
Beta2=-Lambda0^2*D_lambda/(2*pi*c_luz);      % ParÃ¢metro de dispersao de velocidade de grupo
Beta3=(Lambda0^2/(2*pi*c_luz))^2*S_lambda+Lambda0^3*D_lambda/(2*pi^2*c_luz^2);       % declive (linear) da dispersao da velocidade de grupo
%Beta3=0;

Excess_kurtosis_Mvec;
Exc_kurt_mov=Exc_kurt;
Wanted_channels=1:Res_WDM:Nch;
%Wanted_channels=[26];

%%% Funcao que gera o espectro WDM
[f1,f2,freqs_centrais,B_WDM,Bks,Pks_dBm,P_tot_dBm,Espac_canais_vec]=Ger_GTx(Spectrum_str,Nch,Espac_canais,P_tot_dBm,f_inicial,Bk,N_pontos_f1_f2,Roll_off,R_sl);
%Bks
%% Vectores frequência Lowpass equivalents
f1_le=f1-freqs_centrais(ceil(end/2));
f2_le=f2-freqs_centrais(ceil(end/2));
freqs_centrais_le=freqs_centrais-freqs_centrais(ceil(end/2));
P_tot_dBm;
p_tot=10^(P_tot_dBm/10)*1e-3;
pks_lin=10.^(Pks_dBm/10)*1e-3;          % Potencia dos diferentes canais em lineares

[eta_fi_dB_closed_form,eta_fi_dB_closed_form_spans_total_no,eta_fi_npans_total,eta_SPM,eta_XPM,eta_corr_fi]=GN_model_closed_forms_modi_Mvec(freqs_centrais_le,p_tot,pks_lin,Bks,Wanted_channels,alfa_Np_m,Beta2,Beta3,gama,CR,L_sec,n_spans_total,Nch,Exc_kurt_mov);

eta_fi_dB_closed_form(end,:);
eta_fi_dB_closed_form_spans_total_no(end,:);
p_NLI=eta_fi_npans_total(end,:)*pks_lin(1)^3;
%pch_opt=(pn_ASE./(2*eta_fi_npans_total(end,:))).^(1/3);

%%% Figures GN-model
figure(50)
%hold on
plot(freqs_centrais(Wanted_channels),eta_fi_dB_closed_form_spans_total_no(end,:).','k--')
grid
xlabel('Channel index m')
ylabel('\it\eta_{NLI}\rm [dB (1/W^2)]')
legend('\it\eta_N')