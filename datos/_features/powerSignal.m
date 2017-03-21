function [ power ] = powerSignal( signal )
% Returns power (matrix)

power = sum(signal.^2)/length(signal);

end

