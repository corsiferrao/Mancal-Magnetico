%%
% Rafael Corsi
% Mancal magnético - Dissertação de Mestrado
% 10.4.14
%
% Resumo :
%   Calculo das forças eletromagnéticas do circuito ativo, Mancal V0.2
%
clear;

% Comprimentos
lgn = 0.6*1E-3;
lga = 0.6*1E-3;
lgb = 0.6*1E-3;

% Parâmetros de exitação
I = 4; 
N = 300; 
w = 10E3;

% Constantes geométricas
rn = 49.2E-3;
tn = 25.89; %graus
hn = 8E-3;

lfn = (rn - 38.20E-3); 
lfa = lfn ;
lfb = lfn ;

lra = 2*pi*53/8;
lrb = lra;

Sgn = 2*pi*(tn/360)*rn*hn;
Sga = Sgn;
Sgb = Sgn;

Sfn = Sgn;
Sfa = Sgn;
Sfb = Sgn;

Sra = 60E-6;
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
Hgn = (F*(C2+C3)/(Sgn + C1*(C2+C3)))
Hga = (F - Hgn*C1)*C2/Sga
Hgb = (F - Hgn*C1)*C3/Sga

%%
Bgn = Hgn*mu0
Bga = Hga*mu0
Bgb = Hgb*mu0

% Força de atração nos gaps
fn = Bgn^2*2*Sgn/(mu0*lgn)
fa = Bga^2*2*Sga/(mu0*lga)
fb = Bgb^2*2*Sgb/(mu0*lgb)