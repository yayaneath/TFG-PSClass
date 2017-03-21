function [ data ] = readMinute( day, min )
%%% Dado un día y un minuto, esta función devuelve las muestras de dicho minuto.

caracter=num2str(min);

fid=fopen(['./dia' day '/LB0' day caracter '.bin']);

data = fread(fid, [8, 6000], 'int16', 'ieee-be');

fclose('all');

if fid
    clear fid;
end

end

