function [ meanDeviation ] = meanDeviation( signal )
% Returns mean deviation (single value)

%means = meanFrequency(signal);
means = mean(signal);
sigLength = length(signal);
meanDeviation = sum(abs(signal - means))/sigLength;

end

