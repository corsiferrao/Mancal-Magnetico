L = 0.234;
R = 6.3;
m = 0.375;
Kp = 625;
Kb = 10;

G = tf([Kb],conv([m 0 -Kp],[0 L R])) 

pole(G)
step(G)

%%
Kb = 9.54;
L = 0.234;

G = tf([Kb],conv([m 0 -Kp],[0 L R])) 
pole(G)

