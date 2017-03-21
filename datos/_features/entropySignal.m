function [ ent ] = entropySignal( signal )
% Returns energy (single value)

probabilities = signal.^2/sum(signal.^2);
ent = - sum(probabilities.*log10(probabilities));

end

