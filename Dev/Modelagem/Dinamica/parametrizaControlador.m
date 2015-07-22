%% H_inf
s = zpk('s');
w0 = 100;
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

%% Bode
h1 = figure
%belezura
 bode(G);
  H=get(gcf,'Children');
belezura

%%
h1 = figure
%belezura
 bode(T);
  H=get(gcf,'Children');
belezura

%%
figure
plot(pr.time,pr.signals.values)
xlabel('t (s)')
ylabel('Position (mm)')
legend('dx','dy')
axis([0,0.7,-0.6E-4,3.8E-4])
belezura
