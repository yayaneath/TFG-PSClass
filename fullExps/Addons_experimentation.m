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

minRange        = 0;
maxRange        = 1;
draw            = 0;

stdInertia      = 0.90;
stdSwarmSize    = 500;
stdMaxIt        = 100;
stdMaxVel       = 0.001;
stdEps          = 0.0;

stdNeighbours   = 3;
stdDist 		= 'euclidean';
stdWeight 		= 'inverse';

comb12          = [2 6];
comb13          = [1 2 5 6];
comb23          = [1 2 3 4 6 7];
comb123         = [1 2 6 8];

dimensions12    = 2;
dimensions13    = 4;
dimensions23    = 6;
dimensions123   = 4;

features        = 8;

trainPercentage = 0.75; 

sizeTrainData1  = round(size(data1_n,1) * trainPercentage);
sizeTrainData2  = round(size(data2_n,1) * trainPercentage);
sizeTrainData3  = round(size(data3_n,1) * trainPercentage);

dataBinary      = 11;
dataFull        = 23;

% %%                            %%%% Separated Training 1/1 %%%%
% 
% dimensions  = dimensions13;
% comb        = comb13;
% 
% resultsAcc  = zeros(1, dataBinary);
% resultsAux 	= zeros(tests, dataBinary);
% line = 1;
% 
% for it = 1 : tests
%    message      = sprintf('* %d * [1-3] separated 1/1', ...
%        it);
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
%    tic();
% 
%    %%% Training data 1
%    data1Train   = datasample(data1, sizeTrainData1, ...
%        'Replace', false);   
%    classes1     = ones(sizeTrainData1, 1) * 1;
% 
%    data         = [data1Train]; 
%    classes      = [classes1];
%    save(trainFile, 'data', 'classes');
%    
%    [parts1, labels1] = psclass(stdSwarmSize, dimensions, trainFile, ...
%    		stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, stdInertia, draw);
% 
%    delete(trainFile);
% 
%    %%% Training data 3
%    data3Train   = datasample(data3, sizeTrainData3, ...
%        'Replace', false);
%    classes3     = ones(sizeTrainData3, 1) * 1;
% 
%    data         = [data3Train]; 
%    classes      = [classes3];
%    save(trainFile, 'data', 'classes');
%    
%    [parts3, labels3] = psclass(stdSwarmSize, dimensions, trainFile, ...
%    		stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, stdInertia, draw);
% 
%    delete(trainFile);
% 
%    trainTime = toc();
%    
%    labels3 = labels3 .* 2;
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
%    %%% Join separated trained swarm
%    parts  		= [parts1; parts3];
%    lbls 		= [labels1; labels3];
% 
%    % Build the k-NN classifier model
% 	disp('Creating the k-NN model...');
% 	mdl = knn(parts, lbls, stdNeighbours, stdDist, stdWeight);
% 
% 	% Test it with the file data
% 	disp('Testing the model...');
% 	load(testFile);
% 	[accuracy, confusion] = testMdl(mdl, data, classes);
% 
% 	% Cross Validation
% 	disp('Cross Validation...');
% 	foldError = kfold(mdl, 5);
% 
% 	delete(trainFile);
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
%    results      = [ ...
%        parts1 parts3 accuracy foldError trainTime ...
%        tn fp fn tp recall precision];
%    resultsAux(it, :) = results;
% 
%    message      = sprintf('* %d * [1-3] separated 1/1', ...
%        it);
%    message2     = sprintf('[1-3] Accuracy: %d', accuracy);
%    disp(message);  disp(message2); 
% end
% 
% resultsAux(isnan(resultsAux)) = 0.0;
% resultsAcc(line, :) = mean(resultsAux);
% 
% % Write files
% 
% resultsFile  = sprintf('[1-3]-separated-1-1');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
% %%                            %%%% Separated Training 1/2 %%%%
% 
% dimensions  = dimensions13;
% comb        = comb13;
% 
% resultsAcc  = zeros(1, dataBinary);
% resultsAux 	= zeros(tests, dataBinary);
% line = 1;
% 
% for it = 1 : tests
%    message      = sprintf('* %d * [1-3] separated 1/2', ...
%        it);
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
%    tic();
% 
%    %%% Training data 1
%    data1Train   = datasample(data1, sizeTrainData1, ...
%        'Replace', false);   
%    classes1     = ones(sizeTrainData1, 1) * 1;
% 
%    data         = [data1Train]; 
%    classes      = [classes1];
%    save(trainFile, 'data', 'classes');
%    
%    [parts1, labels1] = psclass(stdSwarmSize, dimensions, trainFile, ...
%    		stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, stdInertia, draw);
% 
%    delete(trainFile);
% 
%    %%% Training data 3
%    data3Train   = datasample(data3, sizeTrainData3, ...
%        'Replace', false);
%    classes3     = ones(sizeTrainData3, 1) * 1;
% 
%    data         = [data3Train]; 
%    classes      = [classes3];
%    save(trainFile, 'data', 'classes');
%    
%    [parts3, labels3] = psclass(stdSwarmSize * 2, dimensions, trainFile, ...
%    		stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, stdInertia, draw);
% 
%    delete(trainFile);
% 
%    trainTime = toc();
%    
%    labels3 = labels3 .* 2;
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
%    %%% Join separated trained swarm
%    parts  		= [parts1; parts3];
%    lbls 		= [labels1; labels3];
% 
%    % Build the k-NN classifier model
% 	disp('Creating the k-NN model...');
% 	mdl = knn(parts, lbls, stdNeighbours, stdDist, stdWeight);
% 
% 	% Test it with the file data
% 	disp('Testing the model...');
% 	load(testFile);
% 	[accuracy, confusion] = testMdl(mdl, data, classes);
% 
% 	% Cross Validation
% 	disp('Cross Validation...');
% 	foldError = kfold(mdl, 5);
% 
% 	delete(trainFile);
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
%    results      = [ ...
%        parts1 parts3 accuracy foldError trainTime ...
%        tn fp fn tp recall precision];
%    resultsAux(it, :) = results;
% 
%    message      = sprintf('* %d * [1-3] separated 1/2', ...
%        it);
%    message2     = sprintf('[1-3] Accuracy: %d', accuracy);
%    disp(message);  disp(message2); 
% end
% 
% resultsAux(isnan(resultsAux)) = 0.0;
% resultsAcc(line, :) = mean(resultsAux);
% 
% % Write files
% 
% resultsFile  = sprintf('[1-3]-separated-1-2');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
%
%%                            %%%% Oversampled 1/1 %%%%

dimensions  = dimensions13;
comb        = comb13;

resultsAcc  = zeros(1, dataBinary);
resultsAux 	= zeros(tests, dataBinary);
line = 1;

for it = 1 : tests
   message      = sprintf('* %d * [1-3] oversampled 1/1', ...
       it);
   disp(message);

   %%% Extract features data
   data1 = zeros(size(data1_n, 1), dimensions);
   data3 = zeros(size(data3_n, 1), dimensions);

   for j = 1 : dimensions
       data1(:, j) = data1_n(:, comb(1, j));
       data3(:, j) = data3_n(:, comb(1, j));
   end

   %%% Training data
   data3Training = datasample(data3, sizeTrainData3, ...
   		'Replace', false);

   data1Train   = datasample(data1, sizeTrainData1, ...
       'Replace', false);   
   data3Train   = datasample(data3Training, sizeTrainData1, ...
       'Replace', true);
   classes1     = ones(sizeTrainData1, 1) * 1;
   classes3     = ones(sizeTrainData1, 1) * 2;

   data         = [data1Train; data3Train]; 
   classes      = [classes1; classes3];
   save(trainFile, 'data', 'classes');
 
   %%% Testing data
   data1Test    = setdiff(data1, data1Train, 'rows');
   data3Test    = setdiff(data3, data3Training, 'rows');
   classes1     = ones(size(data1Test, 1), 1) * 1;
   classes3     = ones(size(data3Test, 1), 1) * 2;

   data         = [data1Test;   data3Test]; 
   classes      = [classes1;    classes3];
   save(testFile, 'data', 'classes');

   %%% Train and test
   [accuracy, confusion, trainTime, foldError, lbls] = ...
       tester(trainFile, testFile, stdSwarmSize, dimensions, ...
       stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
       stdNeighbours, stdInertia, draw, stdDist, stdWeight);

	delete(trainFile); delete(testFile);

   %%% Save results
   parts1       = sum(lbls == 1);
   parts3       = sum(lbls == 2);

   tn           = confusion(1, 1);
   fp           = confusion(1, 2);
   fn           = confusion(2, 1);
   tp           = confusion(2, 2);
   recall       = tp / (tp + fn);
   precision    = tp / (tp + fp);

   results      = [ ...
       parts1 parts3 accuracy foldError trainTime ...
       tn fp fn tp recall precision];
   resultsAux(it, :) = results;

   message      = sprintf('* %d * [1-3] oversampled 1/1', ...
       it);
   message2     = sprintf('[1-3] Accuracy: %d', accuracy);
   disp(message);  disp(message2); 
end

resultsAux(isnan(resultsAux)) = 0.0;
resultsAcc(line, :) = mean(resultsAux);

% Write files

resultsFile  = sprintf('[1-3]-oversampled-1-1');
csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
save([resMats resultsFile '.mat'], 'resultsAcc');

%%                            %%%% Oversampled 1/2 %%%%

dimensions  = dimensions13;
comb        = comb13;

resultsAcc  = zeros(1, dataBinary);
resultsAux 	= zeros(tests, dataBinary);
line = 1;

for it = 1 : tests
   message      = sprintf('* %d * [1-3] oversampled 1/2', ...
       it);
   disp(message);

   %%% Extract features data
   data1 = zeros(size(data1_n, 1), dimensions);
   data3 = zeros(size(data3_n, 1), dimensions);

   for j = 1 : dimensions
       data1(:, j) = data1_n(:, comb(1, j));
       data3(:, j) = data3_n(:, comb(1, j));
   end

   %%% Training data
   data3Training = datasample(data3, sizeTrainData3, ...
   		'Replace', false);

   data1Train   = datasample(data1, sizeTrainData1, ...
       'Replace', false);   
   data3Train   = datasample(data3Training, sizeTrainData1 * 2, ...
       'Replace', true);
   classes1     = ones(sizeTrainData1, 1) * 1;
   classes3     = ones(sizeTrainData1 * 2, 1) * 2;

   data         = [data1Train; data3Train]; 
   classes      = [classes1; classes3];
   save(trainFile, 'data', 'classes');
 
   %%% Testing data
   data1Test    = setdiff(data1, data1Train, 'rows');
   data3Test    = setdiff(data3, data3Training, 'rows');
   classes1     = ones(size(data1Test, 1), 1) * 1;
   classes3     = ones(size(data3Test, 1), 1) * 2;

   data         = [data1Test;   data3Test]; 
   classes      = [classes1;    classes3];
   save(testFile, 'data', 'classes');

   %%% Train and test
   [accuracy, confusion, trainTime, foldError, lbls] = ...
       tester(trainFile, testFile, stdSwarmSize, dimensions, ...
       stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
       stdNeighbours, stdInertia, draw, stdDist, stdWeight);

	delete(trainFile); delete(testFile);

   %%% Save results
   parts1       = sum(lbls == 1);
   parts3       = sum(lbls == 2);

   tn           = confusion(1, 1);
   fp           = confusion(1, 2);
   fn           = confusion(2, 1);
   tp           = confusion(2, 2);
   recall       = tp / (tp + fn);
   precision    = tp / (tp + fp);

   results      = [ ...
       parts1 parts3 accuracy foldError trainTime ...
       tn fp fn tp recall precision];
   resultsAux(it, :) = results;

   message      = sprintf('* %d * [1-3] oversampled 1/2', ...
       it);
   message2     = sprintf('[1-3] Accuracy: %d', accuracy);
   disp(message);  disp(message2); 
end

resultsAux(isnan(resultsAux)) = 0.0;
resultsAcc(line, :) = mean(resultsAux);

% Write files

resultsFile  = sprintf('[1-3]-oversampled-1-2');
csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
save([resMats resultsFile '.mat'], 'resultsAcc');

%%                            %%%% undersampled 1/1 %%%%

dimensions  = dimensions13;
comb        = comb13;

resultsAcc  = zeros(1, dataBinary);
resultsAux 	= zeros(tests, dataBinary);
line = 1;

for it = 1 : tests
   message      = sprintf('* %d * [1-3] undersampled 1/1', ...
       it);
   disp(message);

   %%% Extract features data
   data1 = zeros(size(data1_n, 1), dimensions);
   data3 = zeros(size(data3_n, 1), dimensions);

   for j = 1 : dimensions
       data1(:, j) = data1_n(:, comb(1, j));
       data3(:, j) = data3_n(:, comb(1, j));
   end

   %%% Training data
   data1Train   = datasample(data1, sizeTrainData3, ...
       'Replace', false);   
   data3Train   = datasample(data3, sizeTrainData3, ...
       'Replace', false);
   classes1     = ones(sizeTrainData3, 1) * 1;
   classes3     = ones(sizeTrainData3, 1) * 2;

   data         = [data1Train; data3Train]; 
   classes      = [classes1; classes3];
   save(trainFile, 'data', 'classes');
 
   %%% Testing data
   data1Test    = setdiff(data1, data1Train, 'rows');
   data3Test    = setdiff(data3, data3Train, 'rows');
   classes1     = ones(size(data1Test, 1), 1) * 1;
   classes3     = ones(size(data3Test, 1), 1) * 2;

   data         = [data1Test;   data3Test]; 
   classes      = [classes1;    classes3];
   save(testFile, 'data', 'classes');

   %%% Train and test
   [accuracy, confusion, trainTime, foldError, lbls] = ...
       tester(trainFile, testFile, stdSwarmSize, dimensions, ...
       stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
       stdNeighbours, stdInertia, draw, stdDist, stdWeight);

	delete(trainFile); delete(testFile);

   %%% Save results
   parts1       = sum(lbls == 1);
   parts3       = sum(lbls == 2);

   tn           = confusion(1, 1);
   fp           = confusion(1, 2);
   fn           = confusion(2, 1);
   tp           = confusion(2, 2);
   recall       = tp / (tp + fn);
   precision    = tp / (tp + fp);

   results      = [ ...
       parts1 parts3 accuracy foldError trainTime ...
       tn fp fn tp recall precision];
   resultsAux(it, :) = results;

   message      = sprintf('* %d * [1-3] undersampled 1/1', ...
       it);
   message2     = sprintf('[1-3] Accuracy: %d', accuracy);
   disp(message);  disp(message2); 
end

resultsAux(isnan(resultsAux)) = 0.0;
resultsAcc(line, :) = mean(resultsAux);

% Write files

resultsFile  = sprintf('[1-3]-undersampled-1-1');
csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
save([resMats resultsFile '.mat'], 'resultsAcc');

%%                            %%%% undersampled half/1 %%%%

dimensions  = dimensions13;
comb        = comb13;

resultsAcc  = zeros(1, dataBinary);
resultsAux 	= zeros(tests, dataBinary);
line = 1;

for it = 1 : tests
   message      = sprintf('* %d * [1-3] undersampled half/1', ...
       it);
   disp(message);

   %%% Extract features data
   data1 = zeros(size(data1_n, 1), dimensions);
   data3 = zeros(size(data3_n, 1), dimensions);

   for j = 1 : dimensions
       data1(:, j) = data1_n(:, comb(1, j));
       data3(:, j) = data3_n(:, comb(1, j));
   end

   %%% Training data
   data1Train   = datasample(data1, round(sizeTrainData3 / 2), ...
       'Replace', false);   
   data3Train   = datasample(data3, sizeTrainData3, ...
       'Replace', false);
   classes1     = ones(sizeTrainData3, 1) * 1;
   classes3     = ones(sizeTrainData3, 1) * 2;

   data         = [data1Train; data3Train]; 
   classes      = [classes1; classes3];
   save(trainFile, 'data', 'classes');
 
   %%% Testing data
   data1Test    = setdiff(data1, data1Train, 'rows');
   data3Test    = setdiff(data3, data3Train, 'rows');
   classes1     = ones(size(data1Test, 1), 1) * 1;
   classes3     = ones(size(data3Test, 1), 1) * 2;

   data         = [data1Test;   data3Test]; 
   classes      = [classes1;    classes3];
   save(testFile, 'data', 'classes');

   %%% Train and test
   [accuracy, confusion, trainTime, foldError, lbls] = ...
       tester(trainFile, testFile, stdSwarmSize, dimensions, ...
       stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
       stdNeighbours, stdInertia, draw, stdDist, stdWeight);

	delete(trainFile); delete(testFile);

   %%% Save results
   parts1       = sum(lbls == 1);
   parts3       = sum(lbls == 2);

   tn           = confusion(1, 1);
   fp           = confusion(1, 2);
   fn           = confusion(2, 1);
   tp           = confusion(2, 2);
   recall       = tp / (tp + fn);
   precision    = tp / (tp + fp);

   results      = [ ...
       parts1 parts3 accuracy foldError trainTime ...
       tn fp fn tp recall precision];
   resultsAux(it, :) = results;

   message      = sprintf('* %d * [1-3] undersampled half/1', ...
       it);
   message2     = sprintf('[1-3] Accuracy: %d', accuracy);
   disp(message);  disp(message2); 
end

resultsAux(isnan(resultsAux)) = 0.0;
resultsAcc(line, :) = mean(resultsAux);

% Write files

resultsFile  = sprintf('[1-3]-undersampled-half-1');
csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
save([resMats resultsFile '.mat'], 'resultsAcc');

%%                            %%%% Swarmed class 1/1 %%%%

dimensions  = dimensions13;
comb        = comb13;

resultsAcc  = zeros(1, dataBinary);
resultsAux 	= zeros(tests, dataBinary);
line = 1;

for it = 1 : tests
   message      = sprintf('* %d * [1-3] swarmed 1/1', ...
       it);
   disp(message);

   %%% Extract features data
   data1 = zeros(size(data1_n, 1), dimensions);
   data3 = zeros(size(data3_n, 1), dimensions);

   for j = 1 : dimensions
       data1(:, j) = data1_n(:, comb(1, j));
       data3(:, j) = data3_n(:, comb(1, j));
   end

   %%% Training data 1
   data1Train   = datasample(data1, sizeTrainData1, ...
       'Replace', false);   
   classes1     = ones(sizeTrainData1, 1) * 1;

   data         = [data1Train]; 
   classes      = [classes1];
   save(trainFile, 'data', 'classes');
   
   [parts1, labels1] = psclass(sizeTrainData3, dimensions, trainFile, ...
   		stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, stdInertia, draw);

   delete(trainFile);

   %%% Joining swarmed data with data 3
   data3Train   = datasample(data3, sizeTrainData3, ...
       'Replace', false);
   classes3     = ones(sizeTrainData3, 1) * 2;

   data         = [parts1; data3Train]; 
   classes      = [labels1; classes3];
   save(trainFile, 'data', 'classes');
   
	%%% Testing data
   data1Test    = setdiff(data1, data1Train, 'rows');
   data3Test    = setdiff(data3, data3Train, 'rows');
   classes1     = ones(size(data1Test, 1), 1) * 1;
   classes3     = ones(size(data3Test, 1), 1) * 2;

   data         = [data1Test;   data3Test]; 
   classes      = [classes1;    classes3];
   save(testFile, 'data', 'classes');

   %%% Train and test
   [accuracy, confusion, trainTime, foldError, lbls] = ...
       tester(trainFile, testFile, stdSwarmSize, dimensions, ...
       stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
       stdNeighbours, stdInertia, draw, stdDist, stdWeight);

	delete(trainFile); delete(testFile);

   %%% Save results
   parts1       = sum(lbls == 1);
   parts3       = sum(lbls == 2);

   tn           = confusion(1, 1);
   fp           = confusion(1, 2);
   fn           = confusion(2, 1);
   tp           = confusion(2, 2);
   recall       = tp / (tp + fn);
   precision    = tp / (tp + fp);

   results      = [ ...
       parts1 parts3 accuracy foldError trainTime ...
       tn fp fn tp recall precision];
   resultsAux(it, :) = results;

   message      = sprintf('* %d * [1-3] swarmed 1/1', ...
       it);
   message2     = sprintf('[1-3] Accuracy: %d', accuracy);
   disp(message);  disp(message2); 
end

resultsAux(isnan(resultsAux)) = 0.0;
resultsAcc(line, :) = mean(resultsAux);

% Write files

resultsFile  = sprintf('[1-3]-swarmed-1-1');
csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
save([resMats resultsFile '.mat'], 'resultsAcc');

%%                            %%%% Swarmed class half/1 %%%%

dimensions  = dimensions13;
comb        = comb13;

resultsAcc  = zeros(1, dataBinary);
resultsAux 	= zeros(tests, dataBinary);
line = 1;

for it = 1 : tests
   message      = sprintf('* %d * [1-3] swarmed half/1', ...
       it);
   disp(message);

   %%% Extract features data
   data1 = zeros(size(data1_n, 1), dimensions);
   data3 = zeros(size(data3_n, 1), dimensions);

   for j = 1 : dimensions
       data1(:, j) = data1_n(:, comb(1, j));
       data3(:, j) = data3_n(:, comb(1, j));
   end

   %%% Training data 1
   data1Train   = datasample(data1, sizeTrainData1, ...
       'Replace', false);   
   classes1     = ones(sizeTrainData1, 1) * 1;

   data         = [data1Train]; 
   classes      = [classes1];
   save(trainFile, 'data', 'classes');
   
   [parts1, labels1] = psclass(round(sizeTrainData3 / 2), dimensions, trainFile, ...
   		stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, stdInertia, draw);

   delete(trainFile);

   %%% Joining swarmed data with data 3
   data3Train   = datasample(data3, sizeTrainData3, ...
       'Replace', false);
   classes3     = ones(sizeTrainData3, 1) * 2;

   data         = [parts1; data3Train]; 
   classes      = [labels1; classes3];
   save(trainFile, 'data', 'classes');
   
	%%% Testing data
   data1Test    = setdiff(data1, data1Train, 'rows');
   data3Test    = setdiff(data3, data3Train, 'rows');
   classes1     = ones(size(data1Test, 1), 1) * 1;
   classes3     = ones(size(data3Test, 1), 1) * 2;

   data         = [data1Test;   data3Test]; 
   classes      = [classes1;    classes3];
   save(testFile, 'data', 'classes');

   %%% Train and test
   [accuracy, confusion, trainTime, foldError, lbls] = ...
       tester(trainFile, testFile, stdSwarmSize, dimensions, ...
       stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
       stdNeighbours, stdInertia, draw, stdDist, stdWeight);

	delete(trainFile); delete(testFile);

   %%% Save results
   parts1       = sum(lbls == 1);
   parts3       = sum(lbls == 2);

   tn           = confusion(1, 1);
   fp           = confusion(1, 2);
   fn           = confusion(2, 1);
   tp           = confusion(2, 2);
   recall       = tp / (tp + fn);
   precision    = tp / (tp + fp);

   results      = [ ...
       parts1 parts3 accuracy foldError trainTime ...
       tn fp fn tp recall precision];
   resultsAux(it, :) = results;

   message      = sprintf('* %d * [1-3] swarmed half/1', ...
       it);
   message2     = sprintf('[1-3] Accuracy: %d', accuracy);
   disp(message);  disp(message2); 
end

resultsAux(isnan(resultsAux)) = 0.0;
resultsAcc(line, :) = mean(resultsAux);

% Write files

resultsFile  = sprintf('[1-3]-swarmed-half-1');
csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
save([resMats resultsFile '.mat'], 'resultsAcc');