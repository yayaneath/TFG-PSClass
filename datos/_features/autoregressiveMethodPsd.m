function [ psdSignal, freqRange ] = autoregressiveMethodPsd( signal, frequency, order )
% ¿¿¿???

nfft = 2^nextpow2(length(signal));

[psdSignal, freqRange] = pyulear(signal, order, nfft, frequency);

figure;
plot(freqRange, 10*log10(abs(psdSignal)));

end

