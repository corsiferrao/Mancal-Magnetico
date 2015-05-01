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
R1 = Rg(1)+Rn(1)+Rr(1)+Rf(1)+Rg(2)+Rn(2);
R2 = Rg(2)+Rn(2)+Rr(2)+Rf(2)+Rg(3)+Rn(3);
R3 = Rg(3)+Rn(3)+Rr(3)+Rf(3)+Rg(4)+Rn(4);
R4 = Rg(4)+Rn(4)+Rr(4)+Rf(4)+Rg(5)+Rn(5);
R5 = Rg(5)+Rn(5)+Rr(5)+Rf(5)+Rg(6)+Rn(6);
R6 = Rg(6)+Rn(6)+Rr(6)+Rf(6)+Rg(7)+Rn(7);
R7 = Rg(7)+Rn(7)+Rr(7)+Rf(7)+Rg(8)+Rn(8);
R8 = Rg(8)+Rn(8)+Rr(8)+Rf(8)+Rg(1)+Rn(1);

% Matriz resistencia malhas
Rm = diag([R1,R2,R3,R4,R5,R6,R7,R8]);
      
%% Resistencias adjacentes
Ra1 = [0 Rg(2)+Rn(2) 0 0 0 0 0 Rg(8)+Rn(8)];
Ra2 = [Rg(1)+Rn(1) 0 Rg(3)+Rn(3) 0 0 0 0 0];
Ra3 = [0 Rg(2)+Rn(2) 0 Rg(4)+Rn(4) 0 0 0 0];
Ra4 = [0 0 Rg(3)+Rn(3) 0 Rg(5)+Rn(5) 0 0 0];
Ra5 = [0 0 0 Rg(4)+Rn(4) 0 Rg(6)+Rn(6) 0 0];
Ra6 = [0 0 0 0 Rg(5)+Rn(5) 0 Rg(7)+Rn(7) 0];
Ra7 = [0 0 0 0 0 Rg(6)+Rn(6) 0 Rg(8)+Rn(8)];
Ra8 = [Rg(1)+Rn(1) 0 0 0 0 0 Rg(7)+Rn(7) 0];

% Matriz resistencia adjacente
Ra = [Ra1; Ra2; Ra3; Ra4; Ra5; Ra6; Ra7; Ra8];

% Matriz R
R = Rm-Ra;

%% Solução da equacao
% \[ (Rm-Ra)*Im = Fm    \]
% \[ Im = inv(Rm-Ra)*Fm \]

I = R\Fm;

phi =  [ I(1) - I(8); % A
         I(1) - I(2); % B
         I(3) - I(2); % C
         I(3) - I(4); % D
         I(5) - I(4); % E 
         I(5) - I(6); % F 
         I(7) - I(6); % G 
         I(7) - I(8)]; % H




