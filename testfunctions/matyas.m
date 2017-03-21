function [ value ] = matyas( x, y )
%MATYAS Summary of this function goes here
%   Minimun at (0,0) -> 0

value = 0.26 * (power(x, 2) + power(y, 2)) - 0.48 * x * y;

end

