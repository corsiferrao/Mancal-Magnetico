function [ F, P1, P2, P3, P4 ] = merito_ativo(Fx, L, m, versao )
%computa a funcao merito e retorna o valor do funcional

switch versao
    
   case 1
        P1 = 4E3/Fx;           % pondera Fx
        P2 = 1E5*L;           % pondera Indutancia
    %    P3 = m.Vm*1E6/10;      % pondera volume
        ...
    otherwise
      	P1=0;P2=0;P3=0;P4=0;
end

P3 = 0;

F  = P1 + P2 + P3;     % calcula funcional


end

