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

% batente
E = 3e9;                % elastificade do nylon
Lb = 5.3e-3;            % profundidade (radial) do batente [m]
Hb = 8e-3;              % altura (axial) do batente [m]
dA = [1.435e2 3.335e-2];% A = dA(1)*dL^2 + dA(2)*dL (area de penetracao no batente) [m2]
Ab = dA * [1e-8 1e-4]'; % area de penetracao a meia excurcao [m2]
Kbb = E*Hb*Ab/Lb;        % contante elastica a meia escursao [N/m]

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

%% variação dos paramtros
figure
hold on
ii = 1;
%for d=0:0.05E-3:0.3E-3
for i = 0:0.01:1
    G = tf(fit_Kb(d,i),conv([L1*d+L2 R],[m 0 -Kp]));
    MAG = bode(G);
    [Gm(ii),Pm(ii), Wcg(ii),Wcp(ii)] = margin(G);
    bode(G);
    hold on;
    ii = ii + 1;
end
%end

%% Estimador
u0 = 4*pi*1E-7;     % permeabilidade entreferro
Sg = 197E-6;        % area entreferro [m^2]
Fb  = 0:1:200;
x   = 0;

K1 = u0/Sg;
K2 = 1/u0/N;
l = 0;
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

load S_PID

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
step(feedback(S_PID*G,1)*10E-5)
title('')
belezura
export_pdf('Dinamica/Resultados/step_pid_g',1);

%%
rlocus(G*PID)

%% malha fechada
mf = feedback(G*PID,1);
rlocus(mf)

%% PID nao linear
%load resultado_pid_nlinear

figure
plot(simulink_posicao.time,simulink_posicao.signals.values)
xlabel('Tempo (s)')
ylabel('Amplitude (m)')
belezura
export_pdf('Dinamica/Resultados/pid_nlinear_condicao_inicial_posicao',1);


figure
plot(simulink_esforco.time,simulink_esforco.signals.values)
xlabel('Tempo (s)')
ylabel('Tensão (V)')
belezura
export_pdf('Dinamica/Resultados/pid_nlinear_condicao_inicial_esforco',1);