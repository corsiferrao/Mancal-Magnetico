function [ F, P1, P2, P3, P4 ] = merito_ativo(Fx, L, Vma, gi, versao )
%computa a funcao merito e retorna o valor do funcional

P1 = 3*4E2./Fx;           % pondera Fx
P2 = 15E4*L;               % pondera Indutancia
P3 = Vma*1E6/10;    % pondera volume
P4 = 25./(1E4*gi);
F  = P1 + P2 + P3 + P4;     % calcula funcional


end

