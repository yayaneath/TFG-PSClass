clear; clc;

%% Data base loading
trainFile   = 'tempTrain.mat';
testFile    = 'tempTest.mat';
resMats     = './resultados/mats/';
resCSVs     = './resultados/csvs/';

file = './datos/d2_8f_v3_normal_2_nocomplex.mat';
load(file);
clear classesFC classesFD classesJB classesJC
clear dataFC dataFD dataJB dataJC
clear dataTotal dataTotal_n
clear data1 data2 data3
clear classes1 classes2 classes3
clear classesTotal

%% Global parameters setting

tests           = 10;

swarmSize       = 100;
maxIts          = 100;
minRange        = 0;
maxRange        = 1;
maxVel          = 0.001;
eps             = 0.0;
neighbours      = 3;
draw            = 0;

trainPercentage = 0.75; 

sizeTrainData1  = round(size(data1_n,1) * trainPercentage);
sizeTrainData2  = round(size(data2_n,1) * trainPercentage);
sizeTrainData3  = round(size(data3_n,1) * trainPercentage);

dimensions      = 3;
features        = 8;
combs           = 56;
dataToSave      = 14;

%% Data 1 - 2

resultsAcc  = zeros(combs, dataToSave);
line = 1;

for i = 1 : features - 2
for j = i + 1 : features - 1
   for k = j + 1 : features
       resultsAux = zeros(tests, dataToSave);
       
       for it = 1 : tests
           message      = sprintf('* %d * [1-2] Dimensiones %d - %d - %d *', ...
            it, i, j, k);
           disp(message);

           %%% Extract features data
           data1        = [data1_n(:, i) data1_n(:, j) data1_n(:, k)];
           data2        = [data2_n(:, i) data2_n(:, j) data2_n(:, k)];

           %%% Training data
           data1Train   = datasample(data1, sizeTrainData1, ...
               'Replace', false);
           data2Train   = datasample(data2, sizeTrainData2, ...
               'Replace', false);
           classes1     = ones(sizeTrainData1, 1) * 1;
           classes2     = ones(sizeTrainData2, 1) * 2;

           data         = [data1Train;  data2Train]; 
           classes      = [classes1;    classes2];
           save(trainFile, 'data', 'classes');

           %%% Testing data
           data1Test    = setdiff(data1, data1Train, 'rows');
           data2Test    = setdiff(data2, data2Train, 'rows');
           classes1     = ones(size(data1Test, 1), 1) * 1;
           classes2     = ones(size(data2Test, 1), 1) * 2;

           data         = [data1Test;   data2Test]; 
           classes      = [classes1;    classes2];
           save(testFile, 'data', 'classes');

           %%% Train and test
           [accuracy, confusion, trainTime, foldError, lbls] = ...
               tester(trainFile, testFile, swarmSize, dimensions, ...
               maxIts, minRange, maxRange, maxVel, eps, neighbours, draw);

           delete(trainFile);
           delete(testFile);

           %%% Save results
           parts1       = sum(lbls == 1);
           parts2       = sum(lbls == 2);
           tn           = confusion(1, 1);
           fp           = confusion(1, 2);
           fn           = confusion(2, 1);
           tp           = confusion(2, 2);
           recall       = tp / (tp + fn);
           precision    = tp / (tp + fp);

           results      = [i j k ...
               parts1 parts2 accuracy tn fp fn tp ...
               recall precision foldError trainTime];
           resultsAux(it, :) = results;

           message      = sprintf('[1-2] Dimensiones %d - %d - %d !OK!', ...
               i, j, k);
           message2     = sprintf('[1-2] Accuracy: %d', accuracy);
           disp(message);  disp(message2); 
       end
       
       resultsAux(isnan(resultsAux)) = 0;
       resultsAcc(line, :) = mean(resultsAux);
       line = line + 1;
   end
end
end

%%% Write files

resultsFile  = sprintf('[1-2]-%d', dimensions);
csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
save([resMats resultsFile '.mat'], 'resultsAcc');

%% Data 1 - 3

resultsAcc  = zeros(combs, dataToSave);
line = 1;

for i = 1 : features - 2
for j = i + 1 : features - 1
    for k = j + 1 : features
       resultsAux = zeros(tests, dataToSave);
       
       for it = 1 : tests
           message      = sprintf('* %d * [1-3] Dimensiones %d - %d - %d *', ...
            it, i, j, k);
           disp(message);

           %%% Extract features data
           data1        = [data1_n(:, i) data1_n(:, j) data1_n(:, k)];
           data3        = [data3_n(:, i) data3_n(:, j) data3_n(:, k)];

           %%% Training data
           data1Train   = datasample(data1, sizeTrainData1, ...
               'Replace', false);
           data3Train   = datasample(data3, sizeTrainData3, ...
               'Replace', false);
           classes1     = ones(sizeTrainData1, 1) * 1;
           classes2     = ones(sizeTrainData3, 1) * 2;

           data         = [data1Train;  data3Train]; 
           classes      = [classes1;    classes2];
           save(trainFile, 'data', 'classes');

           %%% Testing data
           data1Test    = setdiff(data1, data1Train, 'rows');
           data3Test    = setdiff(data3, data3Train, 'rows');
           classes1     = ones(size(data1Test, 1), 1) * 1;
           classes2     = ones(size(data3Test, 1), 1) * 2;

           data         = [data1Test;   data3Test]; 
           classes      = [classes1;    classes2];
           save(testFile, 'data', 'classes');

           %%% Train and test
           [accuracy, confusion, trainTime, foldError, lbls] = ...
               tester(trainFile, testFile, swarmSize, dimensions, ...
               maxIts, minRange, maxRange, maxVel, eps, neighbours, draw);

           delete(trainFile);
           delete(testFile);

           %%% Save results
           parts1       = sum(lbls == 1);
           parts2       = sum(lbls == 2);
           tn           = confusion(1, 1);
           fp           = confusion(1, 2);
           fn           = confusion(2, 1);
           tp           = confusion(2, 2);
           recall       = tp / (tp + fn);
           precision    = tp / (tp + fp);

           results      = [i j k ...
               parts1 parts2 accuracy tn fp fn tp ...
               recall precision foldError trainTime];
           resultsAux(it, :) = results;

           message      = sprintf('[1-3] Dimensiones %d - %d - %d !OK!', ...
               i, j, k);
           message2     = sprintf('[1-3] Accuracy: %d', accuracy);
           disp(message);  disp(message2); 
       end
       
       resultsAux(isnan(resultsAux)) = 0;
       resultsAcc(line, :) = mean(resultsAux);
       line = line + 1;
    end
end
end

%%% Write files

resultsFile  = sprintf('[1-3]-%d', dimensions);
csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
save([resMats resultsFile '.mat'], 'resultsAcc');

%% Data 2 - 3

resultsAcc  = zeros(combs, dataToSave);
line = 1;

for i = 1 : features - 2
for j = i + 1 : features - 1
    for k = j + 1 : features
       resultsAux = zeros(tests, dataToSave);
       
       for it = 1 : tests
           message      = sprintf('* %d * [2-3] Dimensiones %d - %d - %d *', ...
            it, i, j, k);
           disp(message);

           %%% Extract features data
           data2        = [data2_n(:, i) data2_n(:, j) data2_n(:, k)];
           data3        = [data3_n(:, i) data3_n(:, j) data3_n(:, k)];

           %%% Training data
           data2Train   = datasample(data2, sizeTrainData2, ...
               'Replace', false);
           data3Train   = datasample(data3, sizeTrainData3, ...
               'Replace', false);
           classes1     = ones(sizeTrainData2, 1) * 1;
           classes2     = ones(sizeTrainData3, 1) * 2;

           data         = [data2Train;  data3Train]; 
           classes      = [classes1;    classes2];
           save(trainFile, 'data', 'classes');

           %%% Testing data
           data2Test    = setdiff(data2, data2Train, 'rows');
           data3Test    = setdiff(data3, data3Train, 'rows');
           classes1     = ones(size(data2Test, 1), 1) * 1;
           classes2     = ones(size(data3Test, 1), 1) * 2;

           data         = [data2Test;   data3Test]; 
           classes      = [classes1;    classes2];
           save(testFile, 'data', 'classes');

           %%% Train and test
           [accuracy, confusion, trainTime, foldError, lbls] = ...
               tester(trainFile, testFile, swarmSize, dimensions, ...
               maxIts, minRange, maxRange, maxVel, eps, neighbours, draw);

           delete(trainFile);
           delete(testFile);

           %%% Save results
           parts1       = sum(lbls == 1);
           parts2       = sum(lbls == 2);
           tn           = confusion(1, 1);
           fp           = confusion(1, 2);
           fn           = confusion(2, 1);
           tp           = confusion(2, 2);
           recall       = tp / (tp + fn);
           precision    = tp / (tp + fp);

           results      = [i j k ...
               parts1 parts2 accuracy tn fp fn tp ...
               recall precision foldError trainTime];
           resultsAux(it, :) = results;

           message      = sprintf('[2-3] Dimensiones %d - %d - %d !OK!', ...
               i, j, k);
           message2     = sprintf('[2-3] Accuracy: %d', accuracy);
           disp(message);  disp(message2); 
       end
       
       resultsAux(isnan(resultsAux)) = 0;
       resultsAcc(line, :) = mean(resultsAux);
       line = line + 1;
   end
end
end

%%% Write files

resultsFile  = sprintf('[2-3]-%d', dimensions);
csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
save([resMats resultsFile '.mat'], 'resultsAcc');