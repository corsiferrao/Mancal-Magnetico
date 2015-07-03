%% parametros físicos e construtivos

m.NFRAC = 36;     % Fraçoes de m (partes para o calculo)
                  % nfrac = 36 representa fraçoes de 10 graus
                
m.ree  = 75E-3;   % Raio externo estator                  I

m.wm   = 8E-3;    % Largura imã                           I
m.hm   = 10E-3;   % Altura do ima                         I

m.hef  = 4E-3;    % Altura ferro estator externo          I

% incremento no tamanho do ferro estaro externo com ref.
% a largura do ima
m.wef  = 10E-3;   % Largura do ferro estator externo      

m.wge  = 1.2E-3;  % Gap nominal externo                   I
m.hge  = m.hef;   % Algura do gap

m.wrf  = 10E-3;   % Largura ferro rotor                   I
m.wrr  = 6E-3;    % Largura rotor retorno                 I

% Estator interno
m.wgi = 0.6E-3; % Gap nominal interno                     II    
 
% Fio + embobinamento
m.fs  = 0.0254E-6;   % secção do fio (mm2) : awg 33
m.ff  = 1.2;         % fator de embobinamento
m.nnb = 300;         % número de voltas da bobina         II                 
                     % Area tota de embobinamento 
Anb = 2*m.nnb*m.ff*m.fs;

                     % Altura estator interno  
                     % = a altura do estator externo
m.hei = 2*m.hef + m.hm; 

m.hnb = 10E-3;       % Altura do nucleo da bobina         II

m.lnb = 22E-3;      % comrpimento do nucelo da bobina     II

% Altutra de uma parte (cima ou baixo)
Hnbu = (m.hei-m.hnb)/2;  % Altura util p/ embobinamento

% A largura do nucelo deve ser adaptada para acomodar
% a bobina
m.wnb = 8E-3 ;%Anb/Hnbu;  % Largura nucleo     
                     
m.wei = 6E-3;     % Largura estator interno               II  

%  - gera a pronfundidade do nucleo
% devemos verificar se o 8*(rnb + 2*Hnbu) <= 360 graus
m.rnb = 12E-3;       % Raio do nucelo da bobina           II

                    
                     