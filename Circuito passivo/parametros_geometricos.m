%% parametros físicos e construtivos

m.NFRAC = 36;     % Fraçoes de m (partes para o calculo)
                  % nfrac = 36 representa fraçoes de 10 graus
                
m.hef  = 5E-3;    % Altura ferro estator externo
m.wef  = 14E-3;   % Largura do ferro estator externo

m.wm   = 8E-3;    % Largura imã
m.hm   = 9E-3;   % Altura do ima

m.wge  = 1.2E-3;  % Gap nominal
m.hge  = m.hef;   % Algura do ferro rotor

m.wrf  = 10E-3;   % Largura ferro rotor
m.wrr  = 6E-3;    % Largura rotor retorno

m.ree  = 75E-3;   % Raio externo estator
m.rei  = m.ree-m.wef; % Raio interno ferro estator externo
m.rre  = m.rei-m.wge; % Raio rotor externo ferro
m.rri  = m.rre-m.wrf; % Raio rotor interno ferro

  
             
