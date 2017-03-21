function [ fcSignals, fdSignals, jbSignals, jcSignals ] = readDB( )
%%% Se leen todas las señales en la base de datos, separadas por días.

tic();

fcSignals = readDay('FC');
fdSignals = readDay('FD');
jbSignals = readDay('JB');
jcSignals = readDay('JC');

toc();

end

