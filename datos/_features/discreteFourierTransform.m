function [ signalDFT, powerDFT ] = discreteFourierTransform( signal, frequency )
% Plots and returns signal (matrix) and power (matrix)

nfft = 2^nextpow2(length(signal));
signalDFT = fft(signal, nfft);

amplitude = 2*abs(signalDFT);
powerDFT = signalDFT.*conj(signalDFT)/nfft;

f = frequency/2*linspace(0, 1, nfft/2+1);
plot(f, amplitude(1:nfft/2+1));
title('Single-sided Amplitude Spectrum')
xlabel('Frequency (Hz)')
ylabel('Amplitude')


end

