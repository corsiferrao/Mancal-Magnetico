%% Resolucao da malha para o circuito ativo
% Rafael Corsi
% 7/3/15
% Mancal Magnético

%% Relutancias

%% Inicializacao

% Principais resistencias
%syms RgA RrAB RfAB RnA; 
%syms RgB RrBC RfBC RnB; 
%syms RgC RrCD RfCD RnC; 
%syms RgD RrDE RfDE RnD; 
%syms RgE RrEF RfEF RnE; 
%syms RgF RrFG RfFG RnF; 
%syms RgG RrGH RfGH RnG; 
%syms RgH RrHA RfHA RnH; 

% Forcas contra eletromotriz
%syms FA FB FC FD FE FF FG FH;

% correntes nas malhas
%syms I1 I2 I3 I4 I5 I6 I7 I8;

%% Corrente malhas
%Im = [I1;I2;I3;I4;I5;I6;I7;I8];

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
      FH + FA];

%% Resistencias individual malhas
R1 = RgA+RrAB+RfAB+RnA;
R2 = RgB+RrBC+RfBC+RnB;
R3 = RgC+RrCD+RfCD+RnC;
R4 = RgD+RrDE+RfDE+RnD;
R5 = RgE+RrEF+RfEF+RnE;
R6 = RgF+RrFG+RfFG+RnF;
R7 = RgG+RrGH+RfGH+RnG;
R8 = RgH+RrHA+RfHA+RnH;

% Matriz resistencia malhas
Rm = diag([R1,R2,R3,R4,R5,R6,R7,R8]);
      
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
Ra = [Ra1; Ra2; Ra3; Ra4; Ra5; Ra6; Ra7; Ra8];

%% Solução da equacao
% \[ (Rm-Ra)*Im = Fm    \]
% \[ Im = inv(Rm-Ra)*Fm \]

I = (Rm-Ra)\Fm

phi =  [ I(1) + I(2); 
        -I(2) - I(3);
         I(3) + I(4);
        -I(4) - I(5);
         I(5) + I(6);
        -I(6) - I(7);
         I(7) + I(8);
        -I(8) - I(1)]



