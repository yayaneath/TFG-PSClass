function [ frec, signalRange, gain] = readTXT( day )
%%% Función que lee la frecuencia, el rango de la señal y la ganancia para un día determinado.

fid = fopen(['./LB0' day '.txt'], 'rt');
tline = fgets(fid);

% Reading frecuency
[~, remain] = strtok(tline, '#');

for i = 1 : 12
    [~, remain] = strtok(remain, '#');
end

[token, remain] = strtok(remain, '#');
frec = str2double(token);

% Reading signal range
k = 1;
signalRange = zeros(1, 1);
for i = 1 : 4
   [token, remain] = strtok(remain, '#');
    
   if rem(i, 2) == 0
      value = str2double(token);
      signalRange(k, 1) = value;
      k = k + 1;
   end
end

% Reading channel 0 to 4 gain
j = 1;
gain = zeros(1,1);
for i = 1 : 20
    [token, remain] = strtok(remain, '#');
    
    if rem(i, 4) == 0
        gain(j, 1) = str2double(token);
        j = j + 1;
    end
end

% Channels 5-7 have channel 4's gain
for i = 0 : 2
    gain(j + i, 1) = str2num(token);
end

end

    