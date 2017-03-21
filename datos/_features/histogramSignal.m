function [ histo ] = histogramSignal( signal )
% Plots and returns histogram (matrix)

histo = hist(signal);

bar(histo);

end

