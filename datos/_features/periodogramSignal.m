function [ ppx ] = periodogramSignal( signal )
% TO BE FIXED

win = rectwin(length(signal));
nfft = max(256, 2^nextpow2(length(signal)));
ppx = periodogram(signal, win, nfft);

end

