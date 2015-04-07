%% parametros físicos e construtivos
nfrac = 4;      % Fraçoes de mancal (partes para o calculo)
AS  = 1.08;     % Fator de espraiamento da área (entrefeerro)

Hc = 1054E3;    % Hc ima
Br = 1.29;      % Br ima

hef  = 4E-3;    % Altura ferro
wef  = 14E-3;   % Largura do ferro estator externo

wm   = 8E-3;    % Largura imã
hm   = 10E-3;   % Altura do ima
wge  = 1.2E-3;  % Gap nominal

wrf = 10E-3;    % Largura ferro rotor
wrr = 6E-3;     % Largura rotor retorno

ree  = 0.075;   % Raio externo
rei  = ree-wef; % Raio interno ferro estator externo
rre  = rei-wge; % Raio rotor externo
rri  = rre-wrf; % Raio rotor interno

Sm  = pi*(ree^2 - (ree-wm)^2);  % Área da seccao ímã
Sef = 2*pi*(ree - wef/2)*hef;   % Área do ferro estator externo
Srf = 2*pi*(rre - wrf/2)*hef;   % Area do ferro rotor
Srr = pi*((rri+wrr)^2-rri^2);   % Area do retorno rotor
Sge = 2*pi*(ree - wge/2)*hef;   % Area do gap

%% Permeabilidade 
u0 = 4*pi*1E-7; 
%ufs = 1326*u0;
ufs = 2.5E-1;
um = Br/Hc;
