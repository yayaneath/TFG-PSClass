function [data, classes] = compDayFeatures(day, features)
%%% Devuelve una matriz canal-por-minuto-por-característica y las etiquetas. Se le han de indicar el día y la cantidad de características a usar.

%%
% Obtain day data and split it
[sigClass, sigWhole] = readDataClass(day);
[sigFreq, ~, ~] = readTXT(day);

initChannel = 3;
totalChannels = size(sigClass, 1);
sigWhole = sigWhole(initChannel:end, :);

%%
% channel-by-minute class
classes = sigClass(initChannel:end, :)';

%%
% Extract features
channels = totalChannels - initChannel + 1;
window = 6000;
mins = size(sigWhole, 2) / window;
data = zeros(channels, mins, features);

for i = 1 : features
    disp('Computing feature ');
    disp(i);
    for j = 1 : mins
        for c = 1 : channels
            initMin = (j - 1) * window + 1;
            endMin = j * window;
            sig = sigWhole(c, initMin : endMin);
            
            switch i
                case 1 % Skewness
                    data(c, j, i) = skewnessSignal(sig);
                case 2 % Kurtosis
                    data(c, j, i) = kurtosisSignal(sig);
                case 3 % Mean frequency
                    data(c, j, i) = meanFrequency(sig);
                case 4 % Energy
                    data(c, j, i) = energySignal(sig, sigFreq);
                case 5 % Power
                    data(c, j, i) = powerSignal(sig);
                case 6 % Standard deviation
                    data(c, j, i) = standardDeviation(sig);
                case 7 % Mean deviation
                    data(c, j, i) = meanDeviation(sig);
                case 8 % Variance
                    data(c, j, i) = varianceSignal(sig);
            end
        end
    end
end

end