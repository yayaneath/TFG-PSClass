function [ fcSignals, fdSignals, jbSignals, jcSignals ] = readDB( )
%%% Se leen todas las se�ales en la base de datos, separadas por d�as.

tic();

fcSignals = readDay('FC');
fdSignals = readDay('FD');
jbSignals = readDay('JB');
jcSignals = readDay('JC');

toc();

end

