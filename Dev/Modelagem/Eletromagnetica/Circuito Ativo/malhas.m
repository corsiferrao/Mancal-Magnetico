%% Resolucao da malha para o circuito ativo
% Rafael Corsi
% 7/3/15
% Mancal Magnético

%% Inicializacao

% Principais resistencias
syms RgA RrA RfA RnA; 
syms RgB RrB RfB RnB; 
syms RgC RrC RfC RnC; 
syms RgD RrD RfD RnD; 
syms RgE RrE RfE RnE; 
syms RgF RrF RfF RnF; 
syms RgG RrG RfG RnG; 
syms RgH RrH RfH RnH; 

% Forcas contra eletromotriz
syms FA FB FC FD FE FF FG FH;

% correntes nas malhas
syms I1 I2 I3 I4 I5 I6 I7 I8;

%% Corrente malhas
Im = [I1;I2;I3;I4;I5;I6;I7;I8];

%% FEM
% adotando o sentido horario/ anti-horario de rotacao correto
% (referencial)
Fm = [FA + FB;
      FB + FC;
      FC + FD;
      FD + FE;
      FE + FF;
      FF + FG;
      FG + FH;
      FH + FA]

%% Resistencias individual malhas
R1 = RgA+RrA+RfA+RnA;
R2 = RgB+RrB+RfB+RnB;
R3 = RgC+RrC+RfC+RnC;
R4 = RgD+RrD+RfD+RnD;
R5 = RgE+RrE+RfE+RnE;
R6 = RgF+RrF+RfF+RnF;
R7 = RgG+RrG+RfG+RnG;
R8 = RgH+RrH+RfH+RnH;

% Matriz resistencia malhas
Rm = diag([R1,R2,R3,R4,R5,R6,R7,R8])
      
%% Resistencias adjacentes
Ra1 = [0 RgB+RnB 0 0 0 0 0 RgH+RnH];
Ra2 = [RgA+RnA 0 RgC+RnC 0 0 0 0 0];
Ra3 = [0 RgB+RnB 0 RgD+RnD 0 0 0 0];
Ra4 = [0 0 RgC+RnC 0 RgE+RnE 0 0 0];
Ra5 = [0 0 0 RgD+RnD 0 RgF+RnF 0 0];
Ra6 = [0 0 0 0 RgE+RnE 0 RgG+RnG 0];
Ra7 = [0 0 0 0 0 RgF+RnF 0 RgH+RnH];
Ra8 = [RgA+RnA 0 0 0 0 0 RgG+RnG 0];

% Matriz resistencia adjacente
Ra = [Ra1; Ra2; Ra3; Ra4; Ra5; Ra6; Ra7; Ra8]

%% Solução da equacao
% \[ (Rm-Ra)*Im = Fm    \]
% \[ Im = inv(Rm-Ra)*Fm \]

I = inv(Rm-Ra)*Vm;

%% Solve
