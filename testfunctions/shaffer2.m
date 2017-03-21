function [ value ] = shaffer2( x, y )
%SHAFFER2 Summary of this function goes here
%   Detailed explanation goes here

aux1 = power(sin(power(x, 2) - power(y, 2)), 2);
aux1 = aux1 / power((1 + 0.0001 * (power(x, 2) + power(y, 2))), 2);
value = 0.5 + aux1;

end

