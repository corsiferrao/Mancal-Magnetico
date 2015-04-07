function Hge = Hge(uef, urf, urr)
% Calcula o valor do campo magnetico no entreferro

parametros;

p1 = -Hc*hm/(Sm*Br*2);
p2 = -wge/(u0*Sge);
p3 = -wrf/(urf*Srf);
p4 = -hm/(urr*Srr*2);
p5 = -wef/(uef*Sef);

Hge = abs((p1+p2+p3+p4+p5)*hm*Hc*2*Sge);

end


