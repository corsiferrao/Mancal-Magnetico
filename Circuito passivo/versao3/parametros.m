%% parametros físicos e construtivos

NFRAC = 36;     % Fraçoes de mancal (partes para o calculo)
                % nfrac = 36 representa fraçoes de 10 graus
                
AS    = 1.2;    % Fator de espraiamento da área (entrefeerro)

Hc  = 995000;   % Hc ima (representa aberto)
                % para igualar ao modelo do comsol
                % pelo datasheet = 1054E3
Br  = 1.2504;   % Br ima (representa curto)
                % datasheet Br = 1.39

hef  = 4E-3;    % Altura ferro estator externo
wef  = 14E-3;   % Largura do ferro estator externo

wm   = 8E-3;    % Largura imã
hm   = 10E-3;   % Altura do ima

wge  = 1.2E-3;  % Gap nominal
hge  = hef;     % Algura do ferro

wrf  = 10E-3;   % Largura ferro rotor
wrr  = 6E-3;    % Largura rotor retorno

ree  = 75E-3;   % Raio externo estator
rei  = ree-wef; % Raio interno ferro estator externo
rre  = rei-wge; % Raio rotor externo ferro
rri  = rre-wrf; % Raio rotor interno ferro

pei = 2*pi*rei/NFRAC; % perímetro raio interno estator 
pee = 2*pi*ree/NFRAC; % perímetro raio externo estator 

Sm  = pi*(ree^2 - (ree-wm)^2)/NFRAC;     % Área da seccao ímã            (validado)
Sef = 2*pi*(ree - wef/2)*hef/NFRAC;      % Área do ferro estator externo (42.58)
Srf = 2*pi*(rre - wrf/2)*hef/NFRAC;      % Area do ferro rotor           (41.74)
Srr = pi*((rri+wrr)^2-rri^2)/NFRAC;      % Area do retorno rotor         (validado)
Sge = AS*2*pi*(ree - wge/2)*hge/NFRAC;   % Area do gap

Sef = 42E-6;
Srf = Sef;
Sge = Sef;


%% Permeabilidades

u0 = 4*pi*1E-7; % ar

ufs = 1326*u0;  % ferro

um = u0 ;       % Imã
                % para igualar ao modelo do comsol
                % $ \mu_m = B_r/H_c $
             
