function [ data ] = readMinute( day, min )
%%% Dado un d�a y un minuto, esta funci�n devuelve las muestras de dicho minuto.

caracter=num2str(min);

fid=fopen(['./dia' day '/LB0' day caracter '.bin']);

data = fread(fid, [8, 6000], 'int16', 'ieee-be');

fclose('all');

if fid
    clear fid;
end

end

