function Hge = Hge2(uef, urf, urr)
% Calcula o valor do campo magnetico no entreferro

parametros;

C1 = u0*Sge;
p1 = hm*Sm/um;
p2 = 2*wef/(uef*Sef);
p3 = 2*wge/C1;
p4 = 2*wrf/(urf*Srf);
p5 = wrf/(urr*Srr);


Hge = Br*wm*Sm/(um*C1*(p1-p2-p3-p4-p5));

end


