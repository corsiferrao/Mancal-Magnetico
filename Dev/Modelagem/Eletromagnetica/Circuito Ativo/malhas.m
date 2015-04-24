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
     -FB - FC;
      FC + FD;
     -FD - FE;
      FE + FF;
     -FF - FG;
      FG + FH;
     -FH - FA];

%% Resistencias individual malhas
R1 = RgA+RnA+RrAB+RfAB+RgB+RnB;
R2 = RgB+RnB+RrBC+RfBC+RgC+RnC;
R3 = RgC+RnC+RrCD+RfCD+RgD+RnD;
R4 = RgD+RnD+RrDE+RfDE+RgE+RnE;
R5 = RgE+RnE+RrEF+RfEF+RgF+RnF;
R6 = RgF+RnF+RrFG+RfFG+RgG+RnG;
R7 = RgG+RnG+RrGH+RfGH+RgH+RnH;
R8 = RgH+RnH+RrHA+RfHA+RgA+RnA;

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

% Matriz R
R = Rm-Ra;
%% Solução da equacao
% \[ (Rm-Ra)*Im = Fm    \]
% \[ Im = inv(Rm-Ra)*Fm \]

I = R\Fm

phi =  [ I(1) - I(8); % A
         I(1) - I(2); % B
         I(3) - I(2); % C
         I(3) - I(4); % D
         I(5) - I(4); % E 
         I(5) - I(6); % F 
         I(7) - I(6); % G 
         I(7) - I(8)] % H



