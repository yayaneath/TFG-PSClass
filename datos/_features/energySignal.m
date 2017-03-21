function [ energy ] = energySignal( signal, frequency )
% Returns energy (matrix)

energy = sum(signal.^2)/frequency;

end

