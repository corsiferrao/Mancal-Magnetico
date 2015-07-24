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

%% L

L = tf(Kb,[L2 R])
%bode(L);

%% Rotor
Ro = tf(1,[m 0 -Kp]) 

%% Sistema
G = L*Ro;
Gss = ss(G);

figure;
rlocus(G)

%% PID
P = 2.58;
I = 15.25;
D = 0.044;
N = 1616.33;

PID = tf([P+D*N,P*N+I,I*N],[1 N 0])

rlocus(PID)

%%
rlocus(G*PID)

%% malha fechada
mf = feedback(G*PID,1);
rlocus(mf)

%% Controlador H_inf

s = zpk('s');
w0 = 500;
Gd = w0/(s^2+s+0.001);

[K,CL,GAM] = loopsyn(G,Gd); % Design a loop-shaping controller K

[A, B, C, D] = ssdata(K);
[Num, Den] = ss2tf(A,B,C,D);
c = tf(Num,Den);

% Plot the results
sigma(G*K,'r',Gd,'k-.',Gd/GAM,'k:',Gd*GAM,'k:',{.1,30})
legend('Achieved Loop Shape','Target Loop Shape','Gd/GAM','Gd*GAM')


T = feedback(G*K,eye(1));
sigma(T,ss(GAM),'r*',{.1,30});
legend('Closed loop','GAM')
grid

%% Controlador Alocaçao de polos