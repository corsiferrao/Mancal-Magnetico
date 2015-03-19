function [ fx, fy, Bfn, Bgn, Bga, Bgb ] = f_ativo( Ia, In, Ib, lgn, lga, lgb )
% Rafael Corsi
% Mancal magnético - Dissertação de Mestrado
% 10.4.14
%
% Resumo :
%   Calculo das forças eletromagnéticas do circuito ativo, Mancal V0.2
%
% TODO: Revisar constantes geometricas !
%       Bg não está batendo
%
% I     = Corrente
% lgn   = Gap bobina nominal
% lga   = Gap bobina a direita
% lgb   = Gap bobina a esquerda


% Parâmetros de exitacao/bobina
N = 300; 
w = 1E6;



% Variáveis auxiliares
C1 = (Sgn*lfn*mu0)/(Sfn*muf) + lgn;
C2 = inv( (Sga*lfa*mu0)/(Sfa*muf) + (Sga*lra*mu0)/(Sra*muf) + lga)*Sga;
C3 = inv( (Sgb*lfb*mu0)/(Sfb*muf) + (Sgb*lrb*mu0)/(Srb*muf) + lgb)*Sgb;

% Força eletromotriz
Fa = Ia*N;
Fn = In*N;
Fb = Ib*N;

SFa = Fa + Fn;
SFb = Fb + Fn;

% Campo magnético no gap 
%Hgn = (SFa*C2 + SFb*C3)/(Sgn + C1*(C2+C3));

Hgn = (SFa*C2 + SFb*C3)/(Sgn+C1*C2+C1*C3);

Hga = (SFa - Hgn*C1)*C2/Sga;
Hgb = (SFb - Hgn*C1)*C3/Sga;


Bgn = Hgn*mu0;
%Bga = Bgn/2;
%Bgb = Bgn/2;
Bga = Hga*mu0;
Bgb = Hgb*mu0;

% Força de atração nos gaps - Trabalho virtual
fn = Bgn^2*Sgn/(2*mu0);%*lgn);
fa = Bga^2*Sga/(2*mu0);%*lga);
fb = Bgb^2*Sgb/(2*mu0);%*lgb);

% Decomposicao das forças
fx = (fn + cos(pi/4)*(fa+fb));
fy = sin(pi/4)*(fa - fb);

Bfn = Hgn*Sgn*mu0/Sfn;

end