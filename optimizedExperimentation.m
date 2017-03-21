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

tests           = 2;

minRange        = 0;
maxRange        = 1;
draw            = 0;

stdInertia      = 0.90;
stdSwarmSize    = 500;
stdMaxIt        = 50;
stdMaxVel       = 0.001;
stdEps          = 0.0;

stdNeighbours   = 3;
stdDist 		= 'euclidean';
stdWeight 		= 'inverse';

comb12          = [2 6];
comb13          = [1 2 5 6];
comb23          = [1 2 3 4 6 7];
comb123         = [1 2 3 4 5 6 7 8 9];

dimensions12    = 2;
dimensions13    = 4;
dimensions23    = 6;
dimensions123   = 9;

features        = 9;

trainPercentage = 0.75; 

sizeTrainData1  = round(size(data1_n,1) * trainPercentage);
sizeTrainData2  = round(size(data2_n,1) * trainPercentage);
sizeTrainData3  = round(size(data3_n,1) * trainPercentage);

dataBinary      = 12;
dataFull        = 25;

% %% p-I/p-II
% 
% dimensions  = dimensions12;
% comb        = comb12;
% 
% resultsAcc  = zeros(2, dataBinary);
% resultsAuxOpt = zeros(tests, dataBinary);
% resultsAuxOri = zeros(tests, dataBinary);
% 
% for it = 1 : tests
%    message      = sprintf('---------------- * %d * [1-2] ----------------', it);
%    disp(message);
% 
%    %%% Extract features data
%    data1 = zeros(size(data1_n, 1), dimensions);
%    data2 = zeros(size(data2_n, 1), dimensions);
% 
%    for j = 1 : dimensions
%        data1(:, j) = data1_n(:, comb(1, j));
%        data2(:, j) = data2_n(:, comb(1, j));
%    end
% 
%    %%% Training data
%    data1Train   = datasample(data1, sizeTrainData1, 'Replace', false);   
%    data2Train   = datasample(data2, sizeTrainData2, 'Replace', false);
%    classes1     = ones(sizeTrainData1, 1) * 1;
%    classes2     = ones(sizeTrainData2, 1) * 2;
% 
%    data         = [data1Train; data2Train]; 
%    classes      = [classes1;   classes2];
%    save(trainFile, 'data', 'classes');
%  
%    %%% Testing data
%    data1Test    = setdiff(data1, data1Train, 'rows');
%    data2Test    = setdiff(data2, data2Train, 'rows');
%    classes1     = ones(size(data1Test, 1), 1) * 1;
%    classes2     = ones(size(data2Test, 1), 1) * 2;
% 
%    data         = [data1Test;   data2Test]; 
%    classes      = [classes1;    classes2];
%    save(testFile, 'data', 'classes');
% 
%    %%% Train and test OPTIMIZED
%    [accuracy, confusion, trainTime, classTime, foldError, lbls] = ...
%        tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%        stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%        stdNeighbours, stdInertia, draw, stdDist, stdWeight);
%    
%    %%% Save results
%    parts1       = sum(lbls == 1);
%    parts2       = sum(lbls == 2);
% 
%    tn           = confusion(1, 1);
%    fp           = confusion(1, 2);
%    fn           = confusion(2, 1);
%    tp           = confusion(2, 2);
%    recall       = tp / (tp + fn);
%    precision    = tp / (tp + fp);
% 
%    results      = [parts1 parts2 accuracy foldError trainTime classTime ...
%        tn fp fn tp recall precision];
%    resultsAuxOpt(it, :) = results;
%    
%    message      = sprintf('* %d * [1-2] optimized', it);
%    message2     = sprintf('[1-2] Accuracy: %d', accuracy);
%    disp(message);  disp(message2);
%    
%    %%% Train and test ORIGINAL
%    clear 'data' 'classes';
%    load(trainFile);
%    
%    disp('Creating the k-NN model...');
%    mdl = knn(data, classes, stdNeighbours, stdDist, stdWeight);
% 
%    % Test it with the file data
%    clear 'data' 'classes';
%    load(testFile);
%    
%    disp('Testing the model...');
%    tic();
%    [accuracy, confusion] = testMdl(mdl, data, classes);
%    classTime = toc();
%    
%    % Cross Validation
%    disp('Cross Validation...');
%    foldError = kfold(mdl, 5);
% 
%    delete(trainFile); delete(testFile);
% 
%    %%% Save results
%    tn           = confusion(1, 1);
%    fp           = confusion(1, 2);
%    fn           = confusion(2, 1);
%    tp           = confusion(2, 2);
%    recall       = tp / (tp + fn);
%    precision    = tp / (tp + fp);
% 
%    results      = [-1 -1 accuracy foldError -1 classTime ...
%        tn fp fn tp recall precision];
%    resultsAuxOri(it, :) = results;
% 
%    message      = sprintf('* %d * [1-2] original', it);
%    message2     = sprintf('[1-2] Accuracy: %d', accuracy);
%    disp(message);  disp(message2); 
% end
% 
% resultsAuxOpt(isnan(resultsAuxOpt)) = 0.0;
% resultsAuxOri(isnan(resultsAuxOri)) = 0.0;
% resultsAcc(1, :) = mean(resultsAuxOpt);
% resultsAcc(2, :) = mean(resultsAuxOri);
% 
% % Write files
% 
% resultsFile  = sprintf('[1-2]-opt-ori');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
% %% p-I/p-III
% 
% dimensions  = dimensions13;
% comb        = comb13;
% 
% resultsAcc  = zeros(2, dataBinary);
% resultsAuxOpt = zeros(tests, dataBinary);
% resultsAuxOri = zeros(tests, dataBinary);
% 
% for it = 1 : tests
%    message      = sprintf('---------------- * %d * [1-3] ----------------', it);
%    disp(message);
% 
%    %%% Extract features data
%    data1 = zeros(size(data1_n, 1), dimensions);
%    data3 = zeros(size(data3_n, 1), dimensions);
% 
%    for j = 1 : dimensions
%        data1(:, j) = data1_n(:, comb(1, j));
%        data3(:, j) = data3_n(:, comb(1, j));
%    end
% 
%    %%% Training data
%    data1Train   = datasample(data1, sizeTrainData1, 'Replace', false);   
%    data3Train   = datasample(data3, sizeTrainData3, 'Replace', false);
%    classes1     = ones(sizeTrainData1, 1) * 1;
%    classes3     = ones(sizeTrainData3, 1) * 2;
% 
%    data         = [data1Train; data3Train]; 
%    classes      = [classes1;   classes3];
%    save(trainFile, 'data', 'classes');
%  
%    %%% Testing data
%    data1Test    = setdiff(data1, data1Train, 'rows');
%    data3Test    = setdiff(data3, data3Train, 'rows');
%    classes1     = ones(size(data1Test, 1), 1) * 1;
%    classes3     = ones(size(data3Test, 1), 1) * 2;
% 
%    data         = [data1Test;   data3Test]; 
%    classes      = [classes1;    classes3];
%    save(testFile, 'data', 'classes');
% 
%    %%% Train and test OPTIMIZED
%    [accuracy, confusion, trainTime, classTime, foldError, lbls] = ...
%        tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%        stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%        stdNeighbours, stdInertia, draw, stdDist, stdWeight);
%    
%    %%% Save results
%    parts1       = sum(lbls == 1);
%    parts3       = sum(lbls == 2);
% 
%    tn           = confusion(1, 1);
%    fp           = confusion(1, 2);
%    fn           = confusion(2, 1);
%    tp           = confusion(2, 2);
%    recall       = tp / (tp + fn);
%    precision    = tp / (tp + fp);
% 
%    results      = [parts1 parts3 accuracy foldError trainTime classTime ...
%        tn fp fn tp recall precision];
%    resultsAuxOpt(it, :) = results;
%    
%    message      = sprintf('* %d * [1-3] optimized', it);
%    message2     = sprintf('[1-3] Accuracy: %d', accuracy);
%    disp(message);  disp(message2);
%    
%    %%% Train and test ORIGINAL
%    clear 'data' 'classes';
%    load(trainFile);
%    
%    disp('Creating the k-NN model...');
%    mdl = knn(data, classes, stdNeighbours, stdDist, stdWeight);
% 
%    % Test it with the file data
%    clear 'data' 'classes';
%    load(testFile);
%    
%    disp('Testing the model...');
%    tic();
%    [accuracy, confusion] = testMdl(mdl, data, classes);
%    classTime = toc();
% 
%    % Cross Validation
%    disp('Cross Validation...');
%    foldError = kfold(mdl, 5);
% 
%    delete(trainFile); delete(testFile);
% 
%    %%% Save results
%    tn           = confusion(1, 1);
%    fp           = confusion(1, 2);
%    fn           = confusion(2, 1);
%    tp           = confusion(2, 2);
%    recall       = tp / (tp + fn);
%    precision    = tp / (tp + fp);
% 
%    results      = [-1 -1 accuracy foldError -1 classTime ...
%        tn fp fn tp recall precision];
%    resultsAuxOri(it, :) = results;
% 
%    message      = sprintf('* %d * [1-3] original', it);
%    message2     = sprintf('[1-3] Accuracy: %d', accuracy);
%    disp(message);  disp(message2); 
% end
% 
% resultsAuxOpt(isnan(resultsAuxOpt)) = 0.0;
% resultsAuxOri(isnan(resultsAuxOri)) = 0.0;
% resultsAcc(1, :) = mean(resultsAuxOpt);
% resultsAcc(2, :) = mean(resultsAuxOri);
% 
% % Write files
% 
% resultsFile  = sprintf('[1-3]-opt-ori');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
% %% p-II/p-III
% 
% dimensions  = dimensions23;
% comb        = comb23;
% 
% resultsAcc  = zeros(2, dataBinary);
% resultsAuxOpt = zeros(tests, dataBinary);
% resultsAuxOri = zeros(tests, dataBinary);
% 
% for it = 1 : tests
%    message      = sprintf('---------------- * %d * [2-3] ----------------', it);
%    disp(message);
% 
%    %%% Extract features data
%    data2 = zeros(size(data2_n, 1), dimensions);
%    data3 = zeros(size(data3_n, 1), dimensions);
% 
%    for j = 1 : dimensions
%        data2(:, j) = data2_n(:, comb(1, j));
%        data3(:, j) = data3_n(:, comb(1, j));
%    end
% 
%    %%% Training data
%    data2Train   = datasample(data2, sizeTrainData2, 'Replace', false);   
%    data3Train   = datasample(data3, sizeTrainData3, 'Replace', false);
%    classes2     = ones(sizeTrainData2, 1) * 1;
%    classes3     = ones(sizeTrainData3, 1) * 2;
% 
%    data         = [data2Train; data3Train]; 
%    classes      = [classes2;   classes3];
%    save(trainFile, 'data', 'classes');
%  
%    %%% Testing data
%    data2Test    = setdiff(data2, data2Train, 'rows');
%    data3Test    = setdiff(data3, data3Train, 'rows');
%    classes2     = ones(size(data2Test, 1), 1) * 1;
%    classes3     = ones(size(data3Test, 1), 1) * 2;
% 
%    data         = [data2Test;   data3Test]; 
%    classes      = [classes2;    classes3];
%    save(testFile, 'data', 'classes');
% 
%    %%% Train and test OPTIMIZED
%    [accuracy, confusion, trainTime, classTime, foldError, lbls] = ...
%        tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%        stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%        stdNeighbours, stdInertia, draw, stdDist, stdWeight);
%    
%    %%% Save results
%    parts2       = sum(lbls == 1);
%    parts3       = sum(lbls == 2);
% 
%    tn           = confusion(1, 1);
%    fp           = confusion(1, 2);
%    fn           = confusion(2, 1);
%    tp           = confusion(2, 2);
%    recall       = tp / (tp + fn);
%    precision    = tp / (tp + fp);
% 
%    results      = [parts2 parts3 accuracy foldError trainTime classTime ...
%        tn fp fn tp recall precision];
%    resultsAuxOpt(it, :) = results;
%    
%    message      = sprintf('* %d * [2-3] optimized', it);
%    message2     = sprintf('[2-3] Accuracy: %d', accuracy);
%    disp(message);  disp(message2);
%    
%    %%% Train and test ORIGINAL
%    clear 'data' 'classes';
%    load(trainFile);
%    
%    disp('Creating the k-NN model...');
%    mdl = knn(data, classes, stdNeighbours, stdDist, stdWeight);
% 
%    % Test it with the file data
%    clear 'data' 'classes';
%    load(testFile);
%    
%    disp('Testing the model...');
%    tic();
%    [accuracy, confusion] = testMdl(mdl, data, classes);
%    classTime = toc();
% 
%    % Cross Validation
%    disp('Cross Validation...');
%    foldError = kfold(mdl, 5);
% 
%    delete(trainFile); delete(testFile);
% 
%    %%% Save results
%    tn           = confusion(1, 1);
%    fp           = confusion(1, 2);
%    fn           = confusion(2, 1);
%    tp           = confusion(2, 2);
%    recall       = tp / (tp + fn);
%    precision    = tp / (tp + fp);
% 
%    results      = [-1 -1 accuracy foldError -1 classTime ...
%        tn fp fn tp recall precision];
%    resultsAuxOri(it, :) = results;
% 
%    message      = sprintf('* %d * [2-3] original', it);
%    message2     = sprintf('[2-3] Accuracy: %d', accuracy);
%    disp(message);  disp(message2); 
% end
% 
% resultsAuxOpt(isnan(resultsAuxOpt)) = 0.0;
% resultsAuxOri(isnan(resultsAuxOri)) = 0.0;
% resultsAcc(1, :) = mean(resultsAuxOpt);
% resultsAcc(2, :) = mean(resultsAuxOri);
% 
% % Write files
% 
% resultsFile  = sprintf('[2-3]-opt-ori');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');

%% p-I/p-II/p-III

dimensions  = dimensions123;
comb        = comb123;

resultsAcc  = zeros(2, dataFull);
resultsAuxOpt = zeros(tests, dataFull);
resultsAuxOri = zeros(tests, dataFull);

for it = 1 : tests
   message      = sprintf('---------------- * %d * [1-2-3] ----------------', it);
   disp(message);

   %%% Extract features data
   data1 = zeros(size(data1_n, 1), dimensions);
   data2 = zeros(size(data2_n, 1), dimensions);
   data3 = zeros(size(data3_n, 1), dimensions);

   for j = 1 : dimensions
       data1(:, j) = data1_n(:, comb(1, j));
       data2(:, j) = data2_n(:, comb(1, j));
       data3(:, j) = data3_n(:, comb(1, j));
   end

   %%% Training data
   data1Train   = datasample(data1, sizeTrainData1, 'Replace', false);
   data2Train   = datasample(data2, sizeTrainData2, 'Replace', false);
   data3Train   = datasample(data3, sizeTrainData3, 'Replace', false);
   classes1     = ones(sizeTrainData1, 1) * 1;
   classes2     = ones(sizeTrainData2, 1) * 2;
   classes3     = ones(sizeTrainData3, 1) * 3;

   data         = [data1Train; data2Train; data3Train]; 
   classes      = [classes1;   classes2;   classes3];
   save(trainFile, 'data', 'classes');
 
   %%% Testing data
   data1Test    = setdiff(data1, data1Train, 'rows');
   data2Test    = setdiff(data2, data2Train, 'rows');
   data3Test    = setdiff(data3, data3Train, 'rows');
   classes1     = ones(size(data1Test, 1), 1) * 1;
   classes2     = ones(size(data2Test, 1), 1) * 2;
   classes3     = ones(size(data3Test, 1), 1) * 3;

   data         = [data1Test;  data2Test;   data3Test]; 
   classes      = [classes1;   classes2;    classes3];
   save(testFile, 'data', 'classes');

   %%% Train and test OPTIMIZED
   [accuracy, confusion, trainTime, classTime, foldError, lbls] = ...
       tester(trainFile, testFile, stdSwarmSize, dimensions, ...
       stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
       stdNeighbours, stdInertia, draw, stdDist, stdWeight);
   
   %%% Save results
   parts1       = sum(lbls == 1);
   parts2       = sum(lbls == 2);
   parts3       = sum(lbls == 3);

   tn12         = confusion(1, 1);
   fp12         = confusion(1, 2);
   fn12         = confusion(2, 1);
   tp12         = confusion(2, 2);
   recall12     = tp12 / (tp12 + fn12);
   precision12  = tp12 / (tp12 + fp12);
   
   tn13         = confusion(1, 1);
   fp13         = confusion(1, 3);
   fn13         = confusion(3, 1);
   tp13         = confusion(3, 3);
   recall13     = tp13 / (tp13 + fn13);
   precision13  = tp13 / (tp13 + fp13);
   
   tn23         = confusion(1, 1);
   fp23         = confusion(2, 3);
   fn23         = confusion(3, 2);
   tp23         = confusion(3, 3);
   recall23     = tp23 / (tp23 + fn23);
   precision23  = tp23 / (tp23 + fp23);
   
   results      = [
      parts1 parts2 parts3 accuracy foldError trainTime classTime ...
      tn12 fp12 fn12 tp12 recall12 precision12 ...
      tn13 fp13 fn13 tp13 recall13 precision13 ...
      tn23 fp23 fn23 tp23 recall23 precision23];
   resultsAuxOpt(it, :) = results;
   
   message      = sprintf('* %d * [1-2-3] optimized', it);
   message2     = sprintf('[1-2-3] Accuracy: %d', accuracy);
   disp(message);  disp(message2);
   
   %%% Train and test ORIGINAL
   clear 'data' 'classes';
   load(trainFile);
   
   disp('Creating the k-NN model...');
   mdl = knn(data, classes, stdNeighbours, stdDist, stdWeight);

   % Test it with the file data
   clear 'data' 'classes';
   load(testFile);
   
   disp('Testing the model...');
   tic();
   [accuracy, confusion] = testMdl(mdl, data, classes);
   classTime = toc();

   % Cross Validation
   disp('Cross Validation...');
   foldError = kfold(mdl, 5);

   delete(trainFile); delete(testFile);

   %%% Save results
   tn12         = confusion(1, 1);
   fp12         = confusion(1, 2);
   fn12         = confusion(2, 1);
   tp12         = confusion(2, 2);
   recall12     = tp12 / (tp12 + fn12);
   precision12  = tp12 / (tp12 + fp12);
   
   tn13         = confusion(1, 1);
   fp13         = confusion(1, 3);
   fn13         = confusion(3, 1);
   tp13         = confusion(3, 3);
   recall13     = tp13 / (tp13 + fn13);
   precision13  = tp13 / (tp13 + fp13);
   
   tn23         = confusion(1, 1);
   fp23         = confusion(2, 3);
   fn23         = confusion(3, 2);
   tp23         = confusion(3, 3);
   recall23     = tp23 / (tp23 + fn23);
   precision23  = tp23 / (tp23 + fp23);
   
   results      = [
      -1 -1 -1 accuracy foldError -1 classTime ...
      tn12 fp12 fn12 tp12 recall12 precision12 ...
      tn13 fp13 fn13 tp13 recall13 precision13 ...
      tn23 fp23 fn23 tp23 recall23 precision23];
   resultsAuxOri(it, :) = results;

   message      = sprintf('* %d * [1-2-3] original', it);
   message2     = sprintf('[1-2-3] Accuracy: %d', accuracy);
   disp(message);  disp(message2); 
end

resultsAuxOpt(isnan(resultsAuxOpt)) = 0.0;
resultsAuxOri(isnan(resultsAuxOri)) = 0.0;
resultsAcc(1, :) = mean(resultsAuxOpt);
resultsAcc(2, :) = mean(resultsAuxOri);

% Write files

resultsFile  = sprintf('[1-2-3]-opt-ori');
csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
save([resMats resultsFile '.mat'], 'resultsAcc');