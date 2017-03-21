function [ kurt ] = kurtosisSignal( signal )
% Returns kurtosis (single value)

kurt = kurtosis(signal, 1);

end

