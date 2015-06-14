function [Hrf] = Hrf(Hge, Hrf0)
% Calcula Hm (no íma)

parametros 
load iron;

urf0  = iron.MuH(Hrf0);

Hrf = Hge*u0*Sge/urf0/Srf;

end

