function [orbit,orbitin] = SCgetClosedOrbit(SC,refpts)
% Use the optional fixed guess at the entrance of SC.RING.
if nargin < 2, refpts = []; end
if isfield(SC.INJ,'orbitGuess') && ~isempty(SC.INJ.orbitGuess)
    validateattributes(SC.INJ.orbitGuess,{'numeric'},{'real','finite','size',[6 1]});
    [orbit,orbitin] = findorbit6(SC.RING,refpts,'guess',SC.INJ.orbitGuess);
else
    [orbit,orbitin] = findorbit6(SC.RING,refpts);
end
end
