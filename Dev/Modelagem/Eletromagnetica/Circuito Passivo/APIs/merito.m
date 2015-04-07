function [ F, P1, P2, P3, P4 ] = merito( Fx, Fy, Vm, dBef, m, versao )
%computa a funcao merito e retorna o valor do funcional

switch versao
    
   case 1
        P1 = Fx./10;             % pondera Fx
        P2 = 100./(Fy*m.NFRAC);  % pondera Fy 
        P3 = 10*abs(dBef);       % pondera Delta Bef
        P4 = Vm*1E6/10;          % pondera volume
        
   case 2
        P1 = Fx./10;             % pondera Fx
        P2 = 200./(Fy*m.NFRAC);  % pondera Fy 
        P3 = 10*abs(dBef);       % pondera Delta Bef
        P4 = Vm*1E6/10;          % pondera volume]
 
   case 3
        P1 = Fx./15;             % pondera Fx
        P2 = 100./(Fy*m.NFRAC);  % pondera Fy 
        P3 = 10*abs(dBef);       % pondera Delta Bef
        P4 = Vm*1E6/10;          % pondera volume
        
   case 4
        P1 = Fx./10;             % pondera Fx
        P2 = 60./(Fy*m.NFRAC);   % pondera Fy 
        P3 = 10*abs(dBef);       % pondera Delta Bef
        P4 = Vm*1E6/10;          % pondera volume
        
        ...
    otherwise
      	P1=0;P2=0;P3=0;P4=0;
end



F  = P1 + P2 + P3 + P4;     % calcula funcional


end

