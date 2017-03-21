function [ signals ] = readDay( day )
%%% Devuelve las señales que recogen las muestras de un día entero.

minutes = 0;

switch day
    case 'FC'
        minutes = 190;
    case 'FD'
        minutes = 242;
    case 'JB'
        minutes = 142;
    case 'JC'
        minutes = 141;
end

signals = zeros(8, 0);

for i = 1 : minutes 
    output = fprintf('Reading day %s. Minute: %i.\n', day, i);
    minuteSignals = readMinute(day, i);
    signals = [signals minuteSignals];
end


end

