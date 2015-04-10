%% parametros físicos e construtivos

m.NFRAC = 36;     % Fraçoes de m (partes para o calculo)
                  % nfrac = 36 representa fraçoes de 10 graus
                
m.ree  = 75E-3;   % Raio externo estator                  x

m.hef  = 6E-3;    % Altura ferro estator externo          x
m.wef  = 14E-3;   % Largura do ferro estator externo      x

m.wm   = 8E-3;    % Largura imã                           x
m.hm   = 10E-3;   % Altura do ima                         x

m.wge  = 1.2E-3;  % Gap nominal externo                   x
m.hge  = m.hef;   % Algura do gap

m.wrf  = 10E-3;   % Largura ferro rotor                   x
m.wrr  = 6E-3;    % Largura rotor retorno                 x

% Estator interno

m.wgi = 0.6E-3; % Gap nominal interno                     V    
 
%Awg 33
m.fs  = 0.0254      % secção do fio (mm2)
m.ff  = 1.2         % fator de embobinamento
m.nnb = 150;        % número de voltas da bobina          V
                    % volume total dos fios 
m.Vnb = 150*m.ff*m.Fs;

m.wnb = m.Vnb/m.hnb; % Largura nucleo     
                     % m.wnb = 8E-3;                      
m.hnb = m.hm;        % Altura núcleo                      V

m.wei = 6E-3;   % Largura estator interno                 V  

                % Raio estator interno interno
m.reie = m.ree-m.wef-m.wge-m.wrf-m.wgi-m.wnb;  
                % Raio estator interno externo
m.reii = m.reie - m.wei;
             
