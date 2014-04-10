lgn = 0.6*1E-3;
lga = 0.6*1E-3;
lgb = 0.6*1E-3;

Sgn = 21E-3*8E-3;
Sga = 21E-3*8E-3;
Sgb = 21E-3*8E-3;

lfn = 0.6*1E-3;
lfa = 0.6*1E-3;
lfb = 0.6*1E-3;

lra = lfn;
lrb = lfn;

Sfn = Sgn;
Sfa = Sgn;
Sfb = Sgn;

Sra = Sgn;
Srb = Sgn;

mu0 = 4*pi*1E-7;
muf = 100*mu0;

C1 = (Sgn*lfn*mu0)\(Sfn*muf) + lgn;
C2 = inv((Sga*lfa*mu0)\(Sfa*muf) + (Sga*lra*mu0)\(Sra*mu0) + lga)*Sga;
C3 = inv((Sgb*lfb*mu0)\(Sfb*muf) + (Sgb*lrb*mu0)\(Srb*mu0) + lgb)*Sgb;

I =4; N=300; w=30E3;

F = I*N*w

Bn = muf*F*(C2+C3)/(Sgn + C1*(C2+C3))