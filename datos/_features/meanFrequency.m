function [ meanFreq ] = meanFrequency( signal )
% Returns mean frequency (single value)

freqDomain = fft(signal);
meanFreq = mean(freqDomain);
    
end

