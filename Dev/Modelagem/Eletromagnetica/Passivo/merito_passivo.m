function [ F, P1, P2, P3, P4, P5, P6 ] = merito_passivo( Fx, Fy, Vm, dBef, m, Gap, Raio, versao )
%computa a funcao merito e retorna o valor do funcional

switch versao
    
    case 1
        P1 = Fx./10;             % pondera Fx
        P2 = 100./(Fy);          % pondera Fy
        P3 = 10*abs(dBef);       % pondera Delta Bef
        P4 = Vm*1E6/10;          % pondera volume
        
    case 2
        P1 = Fx./10;             % pondera Fx
        P2 = 200./(Fy);          % pondera Fy
        P3 = 10*abs(dBef);       % pondera Delta Bef
        P4 = Vm*1E6/10;          % pondera volume]
        P5=0; P6 = 0;
    case 3
        P1 = Fx./15;             % pondera Fx
        P2 = 100./(Fy);          % pondera Fy
        P3 = 10*abs(dBef);       % pondera Delta Bef
        P4 = Vm*1E6/10;          % pondera volume
        P5=0; P6 = 0;
    case 4
        P1 = Fx./10;             % pondera Fx
        P2 = 60./(Fy);           % pondera Fy
        P3 = 10*abs(dBef);       % pondera Delta Bef
        P4 = Vm*1E6/10;          % pondera volume
        P5=0; P6 = 0;
    case 5
        P1 = Fx./7;             % pondera Fx
        P2 = 180./(Fy);          % pondera Fy
        P3 = 10*abs(dBef);       % pondera Delta Bef
        P4 = Vm*1E6/15;          % pondera volume
        P5 = Raio*1E3./80;       % pondera raio externo
        P6 = 10./(Gap*1E3);      % pondera gap externo
        ...
    otherwise
    P1=0;P2=0;P3=0;P4=0; P5=0; P6 = 0;
end



F  = P1 + P2 + P3 + P4 + P5 + P6;     % calcula funcional


end

