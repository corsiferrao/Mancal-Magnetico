function [ F, P1, P2, P3 ] = merito_ativo(Fx, L, m, versao )
%computa a funcao merito e retorna o valor do funcional

P1 = 3*4E2./Fx;           % pondera Fx
P2 = 3E4*L;               % pondera Indutancia
%    P3 = m.Vm*1E6/10;    % pondera volume

P3 = 0;

F  = P1 + P2;     % calcula funcional


end

