function [ value ] = egg( x, y )
%EGG Summary of this function goes here
%   -512 < x,y < 512
%   min: (512, 404.2319) -> -959.6407

value = -(y+47)*sin(sqrt(abs(y+x/2+47))) - x*sin(sqrt(abs(x-(y+47))));

end

