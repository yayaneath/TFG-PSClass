function [ psd ] = powerSpectralDensity( signal, frequency )
% Plots and returns power spectral density (matrix)

lSignal = length(signal);

signalDFT = fft(signal);
signalDFT = signalDFT(1:lSignal/2+1);

psd = (1/frequency*lSignal()).*abs(signalDFT).^2;
lPsd = length(psd);
psd(2:lPsd) = 2*psd(2:lPsd);

plot(psd);

end

