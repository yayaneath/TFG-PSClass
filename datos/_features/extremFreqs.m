function [ high, low ] = extremFreqs( signal, frequency )
% Returns high and low (matrix)

lSignal = length(signal);
fftSignal = fft(signal);
ampSignal = abs(fftSignal);

[~, maxIndex] = max(ampSignal);
[~, minIndex] = min(ampSignal);

high = maxIndex*frequency/lSignal;
low = minIndex*frequency/lSignal;

end

