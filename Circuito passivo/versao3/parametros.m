%% parametros físicos e construtivos

NFRAC = 36;     % Fraçoes de mancal (partes para o calculo)
                % nfrac = 36 representa fraçoes de 10 graus
AS    = 1.2;    % Fator de espraiamento da área (entrefeerro)

Hc  = 995000;   % Hc ima (representa aberto)
                % para igualar ao modelo do comsol
                % pelo datasheet = 1054E3
Br  = 1.39;     % Br ima (representa curto)

hef  = 4E-3;    % Altura ferro
wef  = 14E-3;   % Largura do ferro estator externo

wm   = 8E-3;    % Largura imã
hm   = 10E-3;   % Altura do ima

wge  = 1.2E-3;  % Gap nominal
hge  = hef;     % Algura do ferro

wrf  = 10E-3;   % Largura ferro rotor
wrr  = 6E-3;    % Largura rotor retorno

ree  = 75E-3;   % Raio ext nerno
rei  = ree-wef; % Raio interno ferro estator externo
rre  = rei-wge; % Raio rotor externo
rri  = rre-wrf; % Raio rotor interno

pee = 2*pi*ree/NFRAC; % perímetro raio ext

Sm  = pi*(ree^2 - (ree-wm)^2)/NFRAC;     % Área da seccao ímã            (validado)
Sef = 2*pi*(ree - wef/2)*hef/NFRAC;      % Área do ferro estator externo (42.58)
Srf = 2*pi*(rre - wrf/2)*hef/NFRAC;      % Area do ferro rotor           (41.74)
Srr = pi*((rri+wrr)^2-rri^2)/NFRAC;      % Area do retorno rotor         (validado)
Sge = AS*2*pi*(ree - wge/2)*hge/NFRAC;   % Area do gap

%Sef = 42.58E-6;
%Srf = 41.74E-6;
%Sge = Sef*1.2;

%% Permeabilidades

u0 = 4*pi*1E-7; % ar

ufs = 1326*u0;  % ferro

um = u0 ;       % Imã
                % para igualar ao modelo do comsol
                % $ \mu_m = B_r/H_c $
             
