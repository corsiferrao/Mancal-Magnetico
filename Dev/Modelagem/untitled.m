%% 
% Modelagem Dinâmica
% Mancal Mangnético
%
% Rafael Corsi
%%
                    % L = L1*x + L2
L1 = -1.206e-05;    % [H]
L2 = 7.807e-05;     % [H]
R = 6.3;            % Resistencia elétrica [ohm]

N = 300;            % Número de espiras da bobina

m = 0.375;          % massa [kg]

gb = 0.3e-3;        % gap para o batente [m]
gi = 0.7e-3;        % gap para o estator interno [m]

Vmax = 30;          % tensao maxima de excitacao das bobinas [V]

Kp = 625;           % rigidez passiva linear [N/m]     


%load Fp_model;
load fit_Kb;
Kb = 58;            % força ativa pnt operação [N/A]
Fp_model = fit_Kb;  % Força ativa fit          [N(m,A)]     

%% Modelos dinamicos

L = tf(Kb,[L2 R]);   % indutor
Ro = tf(1,[m 0 -Kp]);% Rotor

G = L*Ro;            % mancal - rotor - atuador

%% analises
figure;
rlocus(G)

%% Estimador
u0 = 4*pi*1E-7;     % permeabilidade entreferro
Sg = 197E-6;        % area entreferro [m^2]
Fb  = 0:1:200;
x   = 0;

K1 = u0/Sg;
K2 = 1/u0/N;

figure
plot(Fb,sqrt(Fb*2*K1)*(gi-l)*K2*1.4)

%% PID
% s = zpk('s');
% 
% P = 4.13e+04;
% I =  1.38e+05;
% D = 1.38e+03;
% N = 1134;
% 
% PID = P*(1+I/s+D*N/(1+N/s))
% 

%load S_PID

%rlocus(S_PID)
figure
rlocus(S_PID*G)
belezura
title('')
export_pdf('Dinamica/Resultados/rlocus_pid_g',1);


figure
bode(S_PID*G)
title('')
export_pdf('Dinamica/Resultados/bode_pid_g',1);

figure
step(feedback(S_PID*G,1))
title('')
belezura
export_pdf('Dinamica/Resultados/step_pid_g',1);

%%
rlocus(G*PID)

%% malha fechada
mf = feedback(G*PID,1);
rlocus(mf)
