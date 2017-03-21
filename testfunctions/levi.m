function [ value ] = levi( x,y )
%LEVY Summary of this function goes here
%   min at (1,1) ~ 0 [-10, 10]

value = power(sin(3*pi*x),2)+power(x-1,2)*(1+power(sin(3*pi*y),2))...
    +power(y-1,2)*(1+power(sin(2*pi*y),2));

end

