function [ F ] = F(B, S, mag)
%% Calcula forca
% Rafael Corsi
% 7/3/15
% Mancal Magnético

F = (B.^2*S)/(2*mag.u0);

end

