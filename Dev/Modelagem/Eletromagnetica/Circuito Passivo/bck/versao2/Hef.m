function Hef = Hef(Hge, Hef0)
% Calcula Hm (no íma)

parametros 
load iron;

uef0 = iron.MuH(Hef0);
Hef = Hge*u0*Sge/uef0/Sef;

end

