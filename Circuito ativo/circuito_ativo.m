%%
% Rafael Corsi
% Mancal magnético - Dissertação de Mestrado
% 10.4.14
%
% Resumo :
%   Calculo das forças eletromagnéticas do circuito ativo, Mancal V0.2
%
% TODO: Revisar constantes geometricas !

clear;

% Comprimentos
lgn = 0.6*1E-3;
lga = 0.6*1E-3;
lgb = 0.6*1E-3;

% Parâmetros de exitação
I = 2; 
N = 300; 
w = 1;

% Constantes geométricas
lfn = (49.2-82.4)*1E-3;  

lfa = (55.8-(55.8- 49.8)/2)*2*pi/8*1E-3;
lfb = lfa ;

lm  = abs((41.2-(41.2-35.7)/2)*2*pi/8*1E-3);
lra = lfn + lm;
lrb = lfn+ lm;

Sgn = 235.1E-6;
Sga = 235.1E-6;
Sgb = 235.1E-6;

Sfn = 235.1E-6;

Sfa = (111.6E-3/2-99.6E-3/2)*10E-3;
Sfb = Sfa;

Sra = (82.4/2-71.4/2)*1E-3*8E-3; % Verificar !!
Srb = Sra;

% Constantes eletromanéticas
mu0 = 4*pi*1E-7;
muf = 1030*mu0;

% Variáveis auxiliares
C1 = (Sgn*lfn*mu0)/(Sfn*muf) + lgn;
C2 = inv( (Sga*lfa*mu0)/(Sfa*muf) + (Sga*lra*mu0)/(Sra*muf) + lga)*Sga;
C3 = inv( (Sgb*lfb*mu0)/(Sfb*muf) + (Sgb*lrb*mu0)/(Srb*muf) + lgb)*Sgb;

% Força eletromotriz
F = I*N;

% Campo magnético no gap 
Hgn = (F *(C2+C3)/(Sgn + C1*(C2+C3)));
Hga = (F - Hgn*C1)*C2/Sga;
Hgb = (F - Hgn*C1)*C3/Sgb;

Bgn = Hgn*mu0;
Bga = Hga*mu0;
Bgb = Hgb*mu0;

% Força de atração nos gaps - Trabalho virtual
fn = Bgn^2*2*Sgn/(mu0*lgn);
fa = Bga^2*2*Sga/(mu0*lga);
fb = Bgb^2*2*Sgb/(mu0*lgb);

% Decomposicao das forças
fx = (fn + fa*cos(pi/4) + fb*cos(pi/4))/1E4
fy = (fa*sin(pi/4) - fb*sin(pi/4))/1E4

