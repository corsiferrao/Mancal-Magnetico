L1 = -1.206e-05;
L2 = 7.807e-05;

N=300;

R = 6.3;
m = 0.375;

gb = 0.3e-3;            % gap para o batente [m]
gi = 0.7e-3;            % gap para o estator interno [m]

Vmax = 30;              % tensao maxima de excitacao das bobinas [V]

Kp = 625;
Kb = 10;

E = 3e9;                % elastificade do nylon
Lb = 5.3e-3;            % profundidade (radial) do batente [m]
Hb = 8e-3;              % altura (axial) do batente [m]
dA = [1.435e2 3.335e-2];% A = dA(1)*dL^2 + dA(2)*dL (area de penetracao no batente) [m2]
Ab = dA * [1e-8 1e-4]'; % area de penetracao a meia excurcao [m2]
Kb = E*Hb*Ab/Lb;        % contante elastica a meia escursao [N/m]

load Fp_model;

load controlador_v1

%% L0

L = tf(1,[L2 R]);
bode(L);

%% Sistema

G = tf([Kb],conv([m 0 -Kp],[0 L2 R])) 

bode(G)
pole(G)
