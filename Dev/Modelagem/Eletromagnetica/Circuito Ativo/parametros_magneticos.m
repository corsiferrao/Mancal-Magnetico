%% Parametros magneticos

%% ima 
m.AS  = 1;      % Fator de espraiamento da área (entrefeerro)

mag.Hc  = 995000;   % Hc ima (representa aberto)
                    % para igualar ao modelo do comsol
                    % pelo datasheet = 1054E3
mag.Br  = 1.2504;   % Br ima (representa curto)
                    % datasheet Br = 1.39



%% Permeabilidades

mag.u0 = 4*pi*1E-7; % ar

mag.ufs = 1326*mag.u0;  % ferro

mag.um = mag.u0 ;   % Imã
                    % para igualar ao modelo do comsol
                    % $ \mu_m = B_r/H_c $
                