clear; clc;

%% Data base loading
trainFile   = 'tempTrain.mat';
testFile    = 'tempTest.mat';
resMats     = './resultados/mats/';
resCSVs     = './resultados/csvs/';

file = './datos/d2_9f_v4_normal_2_nocomplex.mat';
load(file);
clear classesFC classesFD classesJB classesJC
clear dataFC dataFD dataJB dataJC
clear dataTotal dataTotal_n
clear data1 data2 data3
clear classes1 classes2 classes3
clear classesTotal

%% Global parameters setting

tests           = 10; % M?nimo 2 para hacer la media bien al guardar fichero

swarmSize       = 100;
maxIts          = 100;
minRange        = 0;
maxRange        = 1;
maxVel          = 0.001;
eps             = 0.0;
neighbours      = 3;
inertia         = 0.90;
draw            = 0;
dist        	= 'euclidean';
weight   		= 'inverse';

trainPercentage = 0.75; 

sizeTrainData1  = round(size(data1_n,1) * trainPercentage);
sizeTrainData2  = round(size(data2_n,1) * trainPercentage);
sizeTrainData3  = round(size(data3_n,1) * trainPercentage);

dimensions      = 1;
features        = 9;
combs           = 9;
dataToSave      = dimensions + 24;

%% Data 1 - 2 - 3

resultsAcc  = zeros(combs, dataToSave);
line = 1;

for i = 1 : features
  resultsAux = zeros(tests, dataToSave);

  for it = 1 : tests
     message      = sprintf('* %d * [1-2-3] Dimensiones %d *', ...
      it, i);
     disp(message);

     %%% Extract features data
     data1        = [data1_n(:, i)];
     data2        = [data2_n(:, i)];
     data3        = [data3_n(:, i)];

     %%% Training data
     data1Train   = datasample(data1, sizeTrainData1, ...
         'Replace', false);
     data2Train   = datasample(data2, sizeTrainData2, ...
         'Replace', false);
     data3Train   = datasample(data3, sizeTrainData3, ...
         'Replace', false);
     classes1     = ones(sizeTrainData1, 1) * 1;
     classes2     = ones(sizeTrainData2, 1) * 2;
     classes3     = ones(sizeTrainData3, 1) * 3;

     data         = [data1Train;  data2Train; data3Train]; 
     classes      = [classes1;    classes2; classes3];
     save(trainFile, 'data', 'classes');

     %%% Testing data
     data1Test    = setdiff(data1, data1Train, 'rows');
     data2Test    = setdiff(data2, data2Train, 'rows');
     data3Test    = setdiff(data3, data3Train, 'rows');
     classes1     = ones(size(data1Test, 1), 1) * 1;
     classes2     = ones(size(data2Test, 1), 1) * 2;
     classes3     = ones(size(data3Test, 1), 1) * 3;

     data         = [data1Test;   data2Test; data3Test]; 
     classes      = [classes1;    classes2; classes3];
     save(testFile, 'data', 'classes');

     %%% Train and test   
     [accuracy, confusion, trainTime, classTime, foldError, lbls] = ...
       tester(trainFile, testFile, swarmSize, dimensions, ...
       maxIts, minRange, maxRange, maxVel, eps, ...
       neighbours, inertia, draw, dist, weight);
     
     delete(trainFile);
     delete(testFile);

     %%% Save results
     parts1       = sum(lbls == 1);
     parts2       = sum(lbls == 2);
     parts3       = sum(lbls == 3);
     
     tn12           = confusion(1, 1);
     fp12           = confusion(1, 2);
     fn12           = confusion(2, 1);
     tp12           = confusion(2, 2);
     recall12       = tp12 / (tp12 + fn12);
     precision12    = tp12 / (tp12 + fp12);
     
     tn13           = confusion(1, 1);
     fp13           = confusion(1, 3);
     fn13           = confusion(3, 1);
     tp13           = confusion(3, 3);
     recall13       = tp13 / (tp13 + fn13);
     precision13    = tp13 / (tp13 + fp13);
     
     tn23           = confusion(2, 2);
     fp23           = confusion(2, 3);
     fn23           = confusion(3, 2);
     tp23           = confusion(3, 3);
     recall23       = tp23 / (tp23 + fn23);
     precision23    = tp23 / (tp23 + fp23);
     
     results      = [i ...
         parts1 parts2 parts3 accuracy foldError trainTime ...
         tn12 fp12 fn12 tp12 recall12 precision12 ...
         tn13 fp13 fn13 tp13 recall13 precision13 ...
         tn23 fp23 fn23 tp23 recall23 precision23]
     resultsAux(it, :) = results;

     message      = sprintf('[1-2-3] Dimensiones %d !OK!', ...
         i);
     message2     = sprintf('[1-2-3] Accuracy: %d', accuracy);
     disp(message);  disp(message2); 
  end

  resultsAux(isnan(resultsAux)) = 0;
  resultsAcc(line, :) = mean(resultsAux);
  line = line + 1;
end

%%% Write files

resultsFile  = sprintf('[1-2-3]-%d', dimensions);
csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
save([resMats resultsFile '.mat'], 'resultsAcc');