%% indutancias
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

load Fp_model;

% L

L = tf(Kb,[L2 R]);
%bode(L);

% Rotor
Ro = tf(1,[m 0 -Kp]);

% Sistema
G = L*Ro;
Gss = ss(G);

figure;
rlocus(G)

%% Estimador
u0 = 4*pi*1E-7;
Sg = 

%% PID
s = zpk('s');

P = 2.62;
I = 10.8;
D = 0.061;
N = 1134;

PID = P*(1+I/s+D*N/(1+N/s))

rlocus(PID)
figure
rlocus(PID*G)

%%
rlocus(G*PID)

%% malha fechada
mf = feedback(G*PID,1);
rlocus(mf)

%% LQI
lqi_Q = [1 1 1 1; 1 1 1 1; 1 1 1 1; 1 1 1 1];
lqi_R = [1];
[lqi_K lqi_S lqi_E] = lqi(Gss,lqi_Q,lqi_R)

%% Controlador H_inf

s = zpk('s');
w0 = 500;
Gd = w0/(s^2+s+0.001);

[K,CL,GAM] = loopsyn(G,Gd); % Design a loop-shaping controller K

[A, B, C, D] = ssdata(K);
[Num, Den] = ss2tf(A,B,C,D);
c = tf(Num,Den);

% Plot the results
figure
sigma(G*K,'r',Gd,'k-.',Gd/GAM,'k:',Gd*GAM,'k:',{.1,30})
legend('Achieved Loop Shape','Target Loop Shape','Gd/GAM','Gd*GAM')

figure
T = feedback(G*K,eye(1));
sigma(T,ss(GAM),'r*',{.1,30});
legend('Closed loop','GAM')
grid

%% Controlador Alocaçao de polos