%% Atribuição do número de canais WDM com modulações A, B e C
NchAQAM=ceil(Perc_AQAM*Nch); 
NchBQAM=ceil(Perc_BQAM*Nch); 
NchCQAM=Nch-(NchAQAM+NchBQAM);
%%% Atribuicao dos diferentes formatos de modulacao aos diferentes canais

vecAQAM(1:NchAQAM)=M_impA;
vecBQAM(1:NchBQAM)=M_impB;
vecCQAM(1:NchCQAM)=M_impC;
M_vec=[vecAQAM vecBQAM vecCQAM];      % vector do formato de modulaÃ§Ã£o

