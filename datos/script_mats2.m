%%% Script BUENO. Calcula caracter?sticas minuto a minuto. Genera datos normalizados y sin normalizar de todas las clases y por d?as.

clear; clc;

%% 
dayNames = ['FC'; 'FD'; 'JB'; 'JC'];

features = 9;

dataFC = zeros(0,0,0); classesFC = zeros(0,0);
dataFD = zeros(0,0,0); classesFD = zeros(0,0);
dataJB = zeros(0,0,0); classesJB = zeros(0,0);
dataJC = zeros(0,0,0); classesJC = zeros(0,0);

%% Data computation
for day = 1 : 4
    dayName = dayNames(day,:);
    [dayClasses, daySignals] = readDataClass(dayName);
    [sigFreq, ~, ~] = readTXT(dayName);

    classes = dayClasses(3:end, :)';
    clear dayClasses;

    minutes = size(classes,1);
    channels = size(classes,2);

    data = zeros(channels, minutes, features); 

    for chan = 1 : channels
        channelSignal = squeeze(daySignals(chan,:,:));

        for min = 1 : minutes
           sig = channelSignal(min,:);
           
           for f = 1 : features
               val = 0;
               switch f
                    case 1 % Skewness
                        val = skewnessSignal(sig);
                    case 2 % Kurtosis
                        val = kurtosisSignal(sig);
                    case 3 % Mean frequency
                        val = meanFrequency(sig);
                    case 4 % Energy
                        val = energySignal(sig, sigFreq);
                    case 5 % Power
                        val = powerSignal(sig);
                    case 6 % Standard deviation
                        val = standardDeviation(sig);
                    case 7 % Mean deviation
                        val = meanDeviation(sig);
                    case 8 % Variance
                        val = varianceSignal(sig);
                    case 9 % Me la acabo de inventar
                        val = sum(sig);
               end
               
               data(chan, min, f) = real(val);
           end    
        end
    end
    
    switch day
        case 1
            classesFC = classes;
            dataFC = data;
        case 2
            classesFD = classes;
            dataFD = data;
        case 3
            classesJB = classes;
            dataJB = data;
        case 4
            classesJC = classes;
            dataJC = data;        
    end
end

clear dayNames day dayName sigFreq minutes sig;
clear channels chan min f val channelSignal;

%% Accumulate days classes and data
classesTotal = [classesFC; classesFD; classesJB; classesJC];
dataTotal = [dataFC dataFD dataJB dataJC];

%% Raw data
chn1 = squeeze(dataTotal(1,:,:));
chn2 = squeeze(dataTotal(2,:,:));
chn3 = squeeze(dataTotal(3,:,:));
chn4 = squeeze(dataTotal(4,:,:));
chn5 = squeeze(dataTotal(5,:,:));
chn6 = squeeze(dataTotal(6,:,:));

clase1 = (classesTotal == 1); 
clase2 = (classesTotal == 2); 
clase3 = (classesTotal == 3);

classes1 = classesTotal(clase1);
classes2 = classesTotal(clase2);
classes3 = classesTotal(clase3);

data1 = chn1(clase1(:,1),:);
data1 = [data1; chn2(clase1(:,2),:)];
data1 = [data1; chn3(clase1(:,3),:)];
data1 = [data1; chn4(clase1(:,4),:)];
data1 = [data1; chn5(clase1(:,5),:)];
data1 = [data1; chn6(clase1(:,6),:)];

data2 = chn1(clase2(:,1),:);
data2 = [data2; chn2(clase2(:,2),:)];
data2 = [data2; chn3(clase2(:,3),:)];
data2 = [data2; chn4(clase2(:,4),:)];
data2 = [data2; chn5(clase2(:,5),:)];
data2 = [data2; chn6(clase2(:,6),:)];

data3 = chn1(clase3(:,1),:);
data3 = [data3; chn2(clase3(:,2),:)];
data3 = [data3; chn3(clase3(:,3),:)];
data3 = [data3; chn4(clase3(:,4),:)];
data3 = [data3; chn5(clase3(:,5),:)];
data3 = [data3; chn6(clase3(:,6),:)];

clear chn1 chn2 chn3 chn4 chn5 chn6;

%% Normalization
dim1 = dataTotal(:,:,1);
dim2 = dataTotal(:,:,2);
dim3 = dataTotal(:,:,3);
dim4 = dataTotal(:,:,4);
dim5 = dataTotal(:,:,5);
dim6 = dataTotal(:,:,6);
dim7 = dataTotal(:,:,7);
dim8 = dataTotal(:,:,8);
dim9 = dataTotal(:,:,9);

max1 = max(max(dim1)); min1 = min(min(dim1));
max2 = max(max(dim2)); min2 = min(min(dim2));
max3 = max(max(dim3)); min3 = min(min(dim3));
max4 = max(max(dim4)); min4 = min(min(dim4));
max5 = max(max(dim5)); min5 = min(min(dim5));
max6 = max(max(dim6)); min6 = min(min(dim6));
max7 = max(max(dim7)); min7 = min(min(dim7));
max8 = max(max(dim8)); min8 = min(min(dim8));
max9 = max(max(dim9)); min9 = min(min(dim9));

dim1_n = arrayfun(@(x) (x - min1)/(max1 - min1), dim1);
dim2_n = arrayfun(@(x) (x - min2)/(max2 - min2), dim2);
dim3_n = arrayfun(@(x) (x - min3)/(max3 - min3), dim3);
dim4_n = arrayfun(@(x) (x - min4)/(max4 - min4), dim4);
dim5_n = arrayfun(@(x) (x - min5)/(max5 - min5), dim5);
dim6_n = arrayfun(@(x) (x - min6)/(max6 - min6), dim6);
dim7_n = arrayfun(@(x) (x - min7)/(max7 - min7), dim7);
dim8_n = arrayfun(@(x) (x - min8)/(max8 - min8), dim8);
dim9_n = arrayfun(@(x) (x - min9)/(max9 - min9), dim9);

% Tenemos 6 canales y 713 minutos
dataTotal_n = zeros(6, 713, features);

dataTotal_n(:,:,1) = dim1_n;
dataTotal_n(:,:,2) = dim2_n;
dataTotal_n(:,:,3) = dim3_n;
dataTotal_n(:,:,4) = dim4_n;
dataTotal_n(:,:,5) = dim5_n;
dataTotal_n(:,:,6) = dim6_n;
dataTotal_n(:,:,7) = dim7_n;
dataTotal_n(:,:,8) = dim8_n;
dataTotal_n(:,:,9) = dim8_n;

clear dim1 dim2 dim3 dim4 dim5 dim6 dim7 dim8 dim9;
%clear dim1_n dim2_n dim3_n dim4_n dim5_n dim6_n dim7_n dim8_n;
clear max1 max2 max3 max4 max5 max6 max7 max8 max9;
clear min1 min2 min3 min4 min5 min6 min7 min8 min9;

chn1_n = squeeze(dataTotal_n(1,:,:));
chn2_n = squeeze(dataTotal_n(2,:,:));
chn3_n = squeeze(dataTotal_n(3,:,:));
chn4_n = squeeze(dataTotal_n(4,:,:));
chn5_n = squeeze(dataTotal_n(5,:,:));
chn6_n = squeeze(dataTotal_n(6,:,:));

data1_n = chn1_n(clase1(:,1),:);
data1_n = [data1_n; chn2_n(clase1(:,2),:)];
data1_n = [data1_n; chn3_n(clase1(:,3),:)];
data1_n = [data1_n; chn4_n(clase1(:,4),:)];
data1_n = [data1_n; chn5_n(clase1(:,5),:)];
data1_n = [data1_n; chn6_n(clase1(:,6),:)];

data2_n = chn1_n(clase2(:,1),:);
data2_n = [data2_n; chn2_n(clase2(:,2),:)];
data2_n = [data2_n; chn3_n(clase2(:,3),:)];
data2_n = [data2_n; chn4_n(clase2(:,4),:)];
data2_n = [data2_n; chn5_n(clase2(:,5),:)];
data2_n = [data2_n; chn6_n(clase2(:,6),:)];

data3_n = chn1_n(clase3(:,1),:);
data3_n = [data3_n; chn2_n(clase3(:,2),:)];
data3_n = [data3_n; chn3_n(clase3(:,3),:)];
data3_n = [data3_n; chn4_n(clase3(:,4),:)];
data3_n = [data3_n; chn5_n(clase3(:,5),:)];
data3_n = [data3_n; chn6_n(clase3(:,6),:)];

clear chn1_n chn2_n chn3_n chn4_n chn5_n chn6_n;
clear clase1 clase2 clase3;

%%
fname = sprintf('d2_%df_v4_normal_2_nocomplex.mat', features);
save(fname, 'dataFC', 'classesFC', ...
    'dataFD', 'classesFD', ...
    'dataJB', 'classesJB', ...
    'dataJC', 'classesJC', ...
    'classesTotal', 'dataTotal', ...
    'data1', 'classes1', ...
    'data2', 'classes2', ...
    'data3', 'classes3', ...
    'dataTotal_n', 'data1_n', ...
    'data2_n', 'data3_n');