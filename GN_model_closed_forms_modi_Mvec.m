function [eta_fi_dB_closed_form,eta_fi_dB_closed_form_spans_total,eta_fi_npans_total,eta_SPM_fi,eta_XPM_fi,eta_corr_fi]=GN_model_closed_forms_mod(freqs_centrais_le,p_tot,pks_lin,Bks,Wanted_channels,alfa_Np_m,Beta2,Beta3,gama,CR,L_sec,n_spans_total,Nch,Exc_kurt_mov)

%Exc_kurt(1:Nch)=Exc_kurt_mov(1);      %% Considerar a mesma modulação em todos os canais
%Exc_kurt(1:Nch)=0*(1:Nch);    %% Impor Gaussian Modulation
Exc_kurt=Exc_kurt_mov;

eta_fi_per_span=zeros(1,length(Wanted_channels));
%%% Ciclo relativo ao número de spans - só para closed-form ISRS-GN model
for nxn=1:n_spans_total
    n_spans=nxn;
    if (n_spans==1)
        n_til=0;
    else
        n_til=n_spans;
    end
    %%% Closed-form ISRSGN-model
    for xx1=1:length(Wanted_channels)
        fi=freqs_centrais_le(Wanted_channels(xx1));
        p_i=pks_lin(Wanted_channels(xx1));
        Bi=Bks(Wanted_channels(xx1));
        a=alfa_Np_m;
        a_bar=alfa_Np_m;

        A=a+a_bar;
        Phi_i=3/2*pi^2*(Beta2+2*pi*Beta3*fi);
        Ti=(a+a_bar-p_tot*CR*fi)^2;
        %eta_SPM_total(xx1)=n_spans^(1+coh_factor)*eta_SPM_fi(xx1);
        %coh_factor=3/10*log(1+6/L_sec*Leff_a/(asinh(pi^2/2*abs(Beta2)*Leff_a*Bi^2*(Nch^2)^(Bi/Espac_canais))));  %% Non-Nyquist-WDM approx Poggiolini Dec 2012
        %coh_factor=log(1+2*Leff_a/(n_spans_total*L_sec)*(1-n_spans_total+n_spans_total*harmonic(n_spans_total-1))/asinh(pi^2/2*abs(Beta2)*Leff_a*B_WDM^2))/log(n_spans_total); %% Nyquist WDM with multiple spans (22)
        %cof_factor=3/10*log(1+6/L_sec*Leff_a/(asinh(pi^2/2*abs(Beta2)*Leff_a*B_WDM^2))); %% (23) Poggiolini Nyquist-WDM with multiple spans aprox de (22)
        coh_factor=0;               %%%acumulação incoerente
        %coh_factor=3/10*log(1+(6/a)/(L_sec*asinh(pi^2/2*Bi^2*abs(Beta2+2*pi*Beta3*fi)/a)));   %%% Vem da função do Semrau

        
        eta_SPM_fi(xx1)=4/9*gama^2/(Bi^2*Phi_i*a_bar*(2*a+a_bar))*pi*((Ti-a^2)/a*asinh(Phi_i*Bi^2/(pi*a))+(A^2-Ti)/A*asinh(Phi_i*Bi^2/(pi*A)));
        eta_SPM_total(xx1)=4/9*gama^2/Bi^2*pi*n_spans^(1+coh_factor)/(Phi_i*a_bar*(2*a+a_bar))*((Ti-a^2)/a*asinh(Phi_i*Bi^2/(pi*a))+(A^2-Ti)/A*asinh(Phi_i*Bi^2/(pi*A)));

        %%% Cálculo de eta_XPM
        for xx2=1:Nch
            fk=freqs_centrais_le(xx2);
            p_k=pks_lin(xx2);
            B_k=Bks(xx2);
            Tk=(a+a_bar-p_tot*CR*fk)^2;
            Phi_i_k=2*pi^2*(fk-fi)*(Beta2+pi*Beta3*(fi+fk));
            fiii=-4*pi^2*(Beta2+pi*Beta3*(fi+fk))*L_sec;
            eta_XPM_k(xx2)=(p_k/p_i)^2*gama^2/(B_k*Phi_i_k*a_bar*(2*a+a_bar))*((Tk-a^2)/a*atan(Phi_i_k*Bi/a)+(A^2-Tk)/A*atan(Phi_i_k*Bi/A));
            eta_corr_k(xx2)=Exc_kurt(xx2)*(p_k/p_i)^2*gama^2/B_k*(1/(Phi_i_k*a_bar*(2*a+a_bar))*((Tk-a^2)/a*atan(Phi_i_k*Bi/a)+(A^2-Tk)/A*atan(Phi_i_k*Bi/A))+ ...
                2*pi*n_til*Tk/(abs(fiii)*B_k^2*a^2*A^2)*((2*abs(fk-fi)-B_k)*log((2*abs(fk-fi)-B_k)/(2*abs(fk-fi)+B_k))+2*B_k));
            eta_XPM_k_total_corr(xx2)=(p_k/p_i)^2*gama^2/B_k*((n_spans+5/6*Exc_kurt(xx2))/(Phi_i_k*a_bar*(2*a+a_bar))*((Tk-a^2)/a*atan(Phi_i_k*Bi/a)+(A^2-Tk)/A*atan(Phi_i_k*Bi/A))+ ...
                5/3*(Exc_kurt(xx2)*pi*n_til*Tk)/(abs(fiii)*B_k^2*a^2*A^2)*((2*abs(fk-fi)-B_k)*log((2*abs(fk-fi)-B_k)/(2*abs(fk-fi)+B_k))+2*B_k));
            if (fk==fi)
                eta_XPM_k(xx2)=0;
                eta_corr_k(xx2)=0;
                eta_XPM_k_total_corr(xx2)=0;
            end
        end
        eta_XPM_fi(xx1)=32/27*sum(eta_XPM_k);
        eta_corr_fi(xx1)=80/81*sum(eta_corr_k);            %% correção do formato de modulação
        eta_XPM_total(xx1)=32/27*sum(eta_XPM_k_total_corr);
    end
    
    eta_fi_per_span=eta_fi_per_span+eta_SPM_fi*n_spans_total^coh_factor+eta_XPM_fi;          %% Eta é calculado ao fim de n_spans_total
    eta_fi(nxn,:)=eta_fi_per_span+eta_corr_fi;
    %eta_fi2(nxn,:)=eta_SPM_fi*n_spans^coh_factor+eta_XPM_fi+eta_corr_fi;
    %eta_fi2_sum(nxn,:)=sum(eta_fi2,1);
    
    %% Total NLI coefficient after n spans Eq.(16) Modulation format correction
    eta_fi_npans_total(nxn,:)=eta_SPM_total+eta_XPM_total;
    
    eta_fi_dB_closed_form(nxn,:)=10*log10(eta_fi(nxn,:));    %%% Eq. (15)
    eta_fi_dB_closed_form_spans_total(nxn,:)=10*log10(eta_fi_npans_total(nxn,:));   %%% Eq. (16)
end
