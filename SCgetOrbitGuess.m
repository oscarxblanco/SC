function guess = SCgetOrbitGuess(SC)
% Estimate the entrance coordinates from BPM means across a drift.
% SC.INJ.trackMode should be TbT

guess = zeros(6,1);
bpms = SC.ORD.BPM;
if numel(bpms) < 2, return; end
bpms = bpms([1 end]);
s = findspos(SC.IDEALRING,[bpms numel(SC.IDEALRING)+1]);
distance = s(1)+s(3)-s(2);
if ~isfinite(distance) || distance <= 0, return; end
%SC.INJ.trackMode = 'pORB';
Btbt = reshape(SCgetBPMreading(SC,'BPMords',bpms),[2,numel(bpms),SC.INJ.nTurns]);

% aboid the first turn before averaging
B = mean(Btbt(:,:,2:end),3);
if any(~isfinite(B),'all'), return; end
slope = (B(:,1)-B(:,2))/distance;
position = B(:,1)-s(1)*slope;
guess([1 3]) = position;
guess([2 4]) = slope;
end
