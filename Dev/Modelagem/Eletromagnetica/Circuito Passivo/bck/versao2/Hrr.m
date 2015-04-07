function [Hrr] = Hrr(Hge, Hrr0)
% Calcula Hm (no íma)

parametros 
load iron;

urr0  = iron.MuH(Hrr0);

Hrr = Hge*u0*Sge/urr0/Srr;

end

