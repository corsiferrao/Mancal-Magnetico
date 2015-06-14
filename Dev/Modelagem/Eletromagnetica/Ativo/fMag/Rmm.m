function [ R ] = Rmm(l, s, mu )
%% relutncia gap 
% Rafael Corsi
% 7/3/15
% Mancal Magnético

R = abs(l)./(mu.*s);

end

