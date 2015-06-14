function Hm = Hm(Hge)
% Calcula Hm (no íma)

parametros 
load iron;

Hm = (-Hge*u0*Sge/Sm+Br)*Hc/Br;
end

