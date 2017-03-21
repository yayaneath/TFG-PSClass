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

inertias        = [1.3 1.2 1.1 1.0 0.9 0.8 0.7 0.6 0.5 0.4];
stdInertia      = 0.90;

%swarmSizes      = [50 100 150 200 250 300 350 400 450 500];
%swarmSizes      = [2300 2400 2500 2600 2700 2800 2900 3000 3100 3200];
swarmSizes       = [500];
stdSwarmSize    = 100;

maxIts          = [50 100 150 200 250 300 350 400 450 500];
stdMaxIt        = 100;

maxVels         = [1.0 0.1 0.01 0.001 0.0001 0.00001 0.000001 0.0000001];
stdMaxVel       = 0.001;

eps             = [1.0 0.1 0.01 0.001 0.0001 0.0];
stdEps          = 0.0;

neighbours      = [1 3 5 7 9 11 13 15 17 19];
stdNeighbours   = 3;

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

%% Data 1 - 2
% 
% 
%                             %%%% Dist / Weight %%%%
% 
% dimensions  = dimensions12;
% comb        = comb12;
% 
% resultsAcc  = zeros(4 * 3, 2 + dataBinary);
% line = 1;
% 
% for i = 1 : 4
%     dist = '';
%     
%     switch i
%         case 1
%             dist = 'cityblock';
%         case 2
%             dist = 'chebychev';
%         case 3
%             dist = 'euclidean';
%         case 4
%             dist = 'minkowski';
%     end
%     
%     for j = 1 : 3
%         resultsAux = zeros(tests, 2 + dataBinary);
%         weight = '';
%         
%         switch j
%             case 1
%                 weight = 'equal';
%             case 2
%                 weight = 'inverse';
%             case 3
%                 weight = 'squaredinverse';
%         end
%     
%         for it = 1 : tests
%            message      = sprintf('* %d * [1-2] dist %s weight %s*', ...
%                it, dist, weight);
%            disp(message);
% 
%            %%% Extract features data
%            data1 = zeros(size(data1_n, 1), dimensions);
%            data2 = zeros(size(data2_n, 1), dimensions);
% 
%            for j = 1 : dimensions
%                data1(:, j) = data1_n(:, comb(1, j));
%                data2(:, j) = data2_n(:, comb(1, j));
%            end
% 
%            %%% Training data
%            data1Train   = datasample(data1, sizeTrainData1, ...
%                'Replace', false);
%            data2Train   = datasample(data2, sizeTrainData2, ...
%                'Replace', false);
%            classes1     = ones(sizeTrainData1, 1) * 1;
%            classes2     = ones(sizeTrainData2, 1) * 2;
% 
%            data         = [data1Train;  data2Train]; 
%            classes      = [classes1;    classes2];
%            save(trainFile, 'data', 'classes');
% 
%            %%% Testing data
%            data1Test    = setdiff(data1, data1Train, 'rows');
%            data2Test    = setdiff(data2, data2Train, 'rows');
%            classes1     = ones(size(data1Test, 1), 1) * 1;
%            classes2     = ones(size(data2Test, 1), 1) * 2;
% 
%            data         = [data1Test;   data2Test]; 
%            classes      = [classes1;    classes2];
%            save(testFile, 'data', 'classes');
% 
%            %%% Train and test
%            [accuracy, confusion, trainTime, foldError, lbls] = ...
%                tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%                stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%                stdNeighbours, stdInertia, draw, dist, weight);
% 
%            delete(trainFile);
%            delete(testFile);
% 
%            %%% Save results
%            parts1       = sum(lbls == 1);
%            parts2       = sum(lbls == 2);
% 
%            tn           = confusion(1, 1);
%            fp           = confusion(1, 2);
%            fn           = confusion(2, 1);
%            tp           = confusion(2, 2);
%            recall       = tp / (tp + fn);
%            precision    = tp / (tp + fp);
% 
%            results      = [i j ...
%                parts1 parts2 accuracy foldError trainTime ...
%                tn fp fn tp recall precision];
%            resultsAux(it, :) = results;
% 
%            message      = sprintf('* %d * [1-2] dist %s weight %s*', ...
%                it, dist, weight);
%            message2     = sprintf('[1-2] Accuracy: %d', accuracy);
%            disp(message);  disp(message2); 
%         end
% 
%         resultsAux(isnan(resultsAux)) = 0.0;
%         resultsAcc(line, :) = mean(resultsAux);
%         line = line + 1;
%     end
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-2]-dist-weight');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
%
%                             %%%% Inertia %%%%
% 
% dimensions  = dimensions12;
% comb        = comb12;
% 
% resultsAcc  = zeros(size(inertias, 2), 1 + dataBinary);
% line = 1;
% 
% for i = 1 : size(inertias, 2)
%     resultsAux = zeros(tests, 1 + dataBinary);
%     inertia = inertias(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-2] inertia %d *', ...
%            it, inertia);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data2 = zeros(size(data2_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data2(:, j) = data2_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes2     = ones(sizeTrainData2, 1) * 2;
% 
%        data         = [data1Train;  data2Train]; 
%        classes      = [classes1;    classes2];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes2     = ones(size(data2Test, 1), 1) * 2;
% 
%        data         = [data1Test;   data2Test]; 
%        classes      = [classes1;    classes2];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%            stdNeighbours, inertia, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts2       = sum(lbls == 2);
% 
%        tn           = confusion(1, 1);
%        fp           = confusion(1, 2);
%        fn           = confusion(2, 1);
%        tp           = confusion(2, 2);
%        recall       = tp / (tp + fn);
%        precision    = tp / (tp + fp);
% 
%        results      = [inertia ...
%            parts1 parts2 accuracy foldError trainTime ...
%            tn fp fn tp recall precision];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-2] inertia %d *', ...
%            it, inertia);
%        message2     = sprintf('[1-2] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-2]-inertia');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
%
                           %%%% Swarm Size %%%%

dimensions  = dimensions13;
comb        = comb13;

resultsAcc  = zeros(size(swarmSizes, 2), 1 + dataBinary);
line = 1;

for i = 1 : size(swarmSizes, 2)
    resultsAux = zeros(tests, 1 + dataBinary);
    swarmSize = swarmSizes(1, i);
    
    for it = 1 : tests
       message      = sprintf('* %d * [1-2] Swarm size %d *', ...
           it, swarmSize);
       disp(message);

       %%% Extract features data
       data1 = zeros(size(data1_n, 1), dimensions);
       data2 = zeros(size(data3_n, 1), dimensions);
       
       for j = 1 : dimensions
           data1(:, j) = data1_n(:, comb(1, j));
           data2(:, j) = data3_n(:, comb(1, j));
       end

       %%% Training data
       data1Train   = datasample(data1, sizeTrainData1, ...
           'Replace', false);
       data2Train   = datasample(data2, sizeTrainData3, ...
           'Replace', false);
       classes1     = ones(sizeTrainData1, 1) * 1;
       classes2     = ones(sizeTrainData3, 1) * 2;

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
           stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
           stdNeighbours, stdInertia, draw, 'euclidean', ...
           'inverse');

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

       results      = [swarmSize ...
           parts1 parts2 accuracy foldError trainTime ...
           tn fp fn tp recall precision];
       resultsAux(it, :) = results;

       message      = sprintf('* %d * [1-2] Swarm size %d *', ...
           it, swarmSize);
       message2     = sprintf('[1-2] Accuracy: %d', accuracy);
       disp(message);  disp(message2); 
    end

    resultsAux(isnan(resultsAux)) = 0.0;
    resultsAcc(line, :) = mean(resultsAux);
    line = line + 1;
end

% Write files

resultsFile  = sprintf('[1-2]-swarm22');
csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
save([resMats resultsFile '.mat'], 'resultsAcc');

%                             %%%% Max Its %%%%
% 
% dimensions  = dimensions12;
% comb        = comb12;
% 
% resultsAcc  = zeros(size(maxIts, 2), 1 + dataBinary);
% line = 1;
% 
% for i = 1 : size(maxIts, 2)
%     resultsAux = zeros(tests, 1 + dataBinary);
%     maxIt = maxIts(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-2] Max it %d *', ...
%            it, maxIt);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data2 = zeros(size(data2_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data2(:, j) = data2_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes2     = ones(sizeTrainData2, 1) * 2;
% 
%        data         = [data1Train;  data2Train]; 
%        classes      = [classes1;    classes2];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes2     = ones(size(data2Test, 1), 1) * 2;
% 
%        data         = [data1Test;   data2Test]; 
%        classes      = [classes1;    classes2];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            maxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%            stdNeighbours, stdInertia, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts2       = sum(lbls == 2);
% 
%        tn           = confusion(1, 1);
%        fp           = confusion(1, 2);
%        fn           = confusion(2, 1);
%        tp           = confusion(2, 2);
%        recall       = tp / (tp + fn);
%        precision    = tp / (tp + fp);
% 
%        results      = [maxIt ...
%            parts1 parts2 accuracy foldError trainTime ...
%            tn fp fn tp recall precision];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-2] Max it %d *', ...
%            it, maxIt);
%        message2     = sprintf('[1-2] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-2]-maxit');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
%
%                             %%%% Max Vels %%%%
% 
% dimensions  = dimensions12;
% comb        = comb12;
% 
% resultsAcc  = zeros(size(maxVels, 2), 1 + dataBinary);
% line = 1;
% 
% for i = 1 : size(maxVels, 2)
%     resultsAux = zeros(tests, 1 + dataBinary);
%     maxVel = maxVels(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-2] Max vel %d *', ...
%            it, maxVel);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data2 = zeros(size(data2_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data2(:, j) = data2_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes2     = ones(sizeTrainData2, 1) * 2;
% 
%        data         = [data1Train;  data2Train]; 
%        classes      = [classes1;    classes2];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes2     = ones(size(data2Test, 1), 1) * 2;
% 
%        data         = [data1Test;   data2Test]; 
%        classes      = [classes1;    classes2];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, maxVel, stdEps, ...
%            stdNeighbours, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts2       = sum(lbls == 2);
% 
%        tn           = confusion(1, 1);
%        fp           = confusion(1, 2);
%        fn           = confusion(2, 1);
%        tp           = confusion(2, 2);
%        recall       = tp / (tp + fn);
%        precision    = tp / (tp + fp);
% 
%        results      = [maxVel ...
%            parts1 parts2 accuracy foldError trainTime ...
%            tn fp fn tp recall precision];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-2] Max vel %d *', ...
%            it, maxVel);
%        message2     = sprintf('[1-2] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-2]-maxvel');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
%
%                             %%%% Eps %%%%
% 
% dimensions  = dimensions12;
% comb        = comb12;
% 
% resultsAcc  = zeros(size(eps, 2), 1 + dataBinary);
% line = 1;
% 
% for i = 1 : size(eps, 2)
%     resultsAux = zeros(tests, 1 + dataBinary);
%     epss = eps(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-2] eps %d *', ...
%            it, epss);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data2 = zeros(size(data2_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data2(:, j) = data2_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes2     = ones(sizeTrainData2, 1) * 2;
% 
%        data         = [data1Train;  data2Train]; 
%        classes      = [classes1;    classes2];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes2     = ones(size(data2Test, 1), 1) * 2;
% 
%        data         = [data1Test;   data2Test]; 
%        classes      = [classes1;    classes2];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, stdMaxVel, epss, ...
%            stdNeighbours, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts2       = sum(lbls == 2);
% 
%        tn           = confusion(1, 1);
%        fp           = confusion(1, 2);
%        fn           = confusion(2, 1);
%        tp           = confusion(2, 2);
%        recall       = tp / (tp + fn);
%        precision    = tp / (tp + fp);
% 
%        results      = [epss ...
%            parts1 parts2 accuracy foldError trainTime ...
%            tn fp fn tp recall precision];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-2] eps %d *', ...
%            it, epss);
%        message2     = sprintf('[1-2] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-2]-eps');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
%                             %%%% knn %%%%
% 
% dimensions  = dimensions12;
% comb        = comb12;
% 
% resultsAcc  = zeros(size(neighbours, 2), 1 + dataBinary);
% line = 1;
% 
% for i = 1 : size(neighbours, 2)
%     resultsAux = zeros(tests, 1 + dataBinary);
%     neigh = neighbours(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-2] neigh %d *', ...
%            it, neigh);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data2 = zeros(size(data2_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data2(:, j) = data2_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes2     = ones(sizeTrainData2, 1) * 2;
% 
%        data         = [data1Train;  data2Train]; 
%        classes      = [classes1;    classes2];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes2     = ones(size(data2Test, 1), 1) * 2;
% 
%        data         = [data1Test;   data2Test]; 
%        classes      = [classes1;    classes2];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%            neigh, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts2       = sum(lbls == 2);
% 
%        tn           = confusion(1, 1);
%        fp           = confusion(1, 2);
%        fn           = confusion(2, 1);
%        tp           = confusion(2, 2);
%        recall       = tp / (tp + fn);
%        precision    = tp / (tp + fp);
% 
%        results      = [neigh ...
%            parts1 parts2 accuracy foldError trainTime ...
%            tn fp fn tp recall precision];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-2] neigh %d *', ...
%            it, neigh);
%        message2     = sprintf('[1-2] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-2]-neigh');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
%
% %% Data 1 - 3
% 
%                             %%%% Swarm Size %%%%
% 
% dimensions  = dimensions13;
% comb        = comb13;
% 
% resultsAcc  = zeros(size(swarmSizes, 2), 1 + dataBinary);
% line = 1;
% 
% for i = 1 : size(swarmSizes, 2)
%     resultsAux = zeros(tests, 1 + dataBinary);
%     swarmSize = swarmSizes(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-3] Swarm size %d *', ...
%            it, swarmSize);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data3 = zeros(size(data3_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data3(:, j) = data3_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data3Train   = datasample(data3, sizeTrainData3, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes3     = ones(sizeTrainData3, 1) * 2;
% 
%        data         = [data1Train;  data3Train]; 
%        classes      = [classes1;    classes3];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data3Test    = setdiff(data3, data3Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes3     = ones(size(data3Test, 1), 1) * 2;
% 
%        data         = [data1Test;   data3Test]; 
%        classes      = [classes1;    classes3];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, swarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%            stdNeighbours, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts3       = sum(lbls == 2);
% 
%        tn           = confusion(1, 1);
%        fp           = confusion(1, 2);
%        fn           = confusion(2, 1);
%        tp           = confusion(2, 2);
%        recall       = tp / (tp + fn);
%        precision    = tp / (tp + fp);
% 
%        results      = [swarmSize ...
%            parts1 parts3 accuracy foldError trainTime ...
%            tn fp fn tp recall precision];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-3] Swarm size %d *', ...
%            it, swarmSize);
%        message2     = sprintf('[1-3] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-3]-swarm');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
%                             %%%% Max Its %%%%
% 
% dimensions  = dimensions13;
% comb        = comb13;
% 
% resultsAcc  = zeros(size(maxIts, 2), 1 + dataBinary);
% line = 1;
% 
% for i = 1 : size(maxIts, 2)
%     resultsAux = zeros(tests, 1 + dataBinary);
%     maxIt = maxIts(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-3] Max it %d *', ...
%            it, maxIt);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data3 = zeros(size(data3_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data3(:, j) = data3_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data3Train   = datasample(data3, sizeTrainData3, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes3     = ones(sizeTrainData3, 1) * 2;
% 
%        data         = [data1Train;  data3Train]; 
%        classes      = [classes1;    classes3];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data3Test    = setdiff(data3, data3Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes3     = ones(size(data3Test, 1), 1) * 2;
% 
%        data         = [data1Test;   data3Test]; 
%        classes      = [classes1;    classes3];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            maxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%            stdNeighbours, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts3       = sum(lbls == 2);
% 
%        tn           = confusion(1, 1);
%        fp           = confusion(1, 2);
%        fn           = confusion(2, 1);
%        tp           = confusion(2, 2);
%        recall       = tp / (tp + fn);
%        precision    = tp / (tp + fp);
% 
%        results      = [maxIt ...
%            parts1 parts3 accuracy foldError trainTime ...
%            tn fp fn tp recall precision];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-3] Max it %d *', ...
%            it, maxIt);
%        message2     = sprintf('[1-3] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-3]-maxit');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
%                             %%%% Max Vels %%%%
% 
% dimensions  = dimensions13;
% comb        = comb13;
% 
% resultsAcc  = zeros(size(maxVels, 2), 1 + dataBinary);
% line = 1;
% 
% for i = 1 : size(maxVels, 2)
%     resultsAux = zeros(tests, 1 + dataBinary);
%     maxVel = maxVels(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-3] Max vel %d *', ...
%            it, maxVel);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data3 = zeros(size(data3_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data3(:, j) = data3_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data3Train   = datasample(data3, sizeTrainData3, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes3     = ones(sizeTrainData3, 1) * 2;
% 
%        data         = [data1Train;  data3Train]; 
%        classes      = [classes1;    classes3];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data3Test    = setdiff(data3, data3Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes3     = ones(size(data3Test, 1), 1) * 2;
% 
%        data         = [data1Test;   data3Test]; 
%        classes      = [classes1;    classes3];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, maxVel, stdEps, ...
%            stdNeighbours, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts3       = sum(lbls == 2);
% 
%        tn           = confusion(1, 1);
%        fp           = confusion(1, 2);
%        fn           = confusion(2, 1);
%        tp           = confusion(2, 2);
%        recall       = tp / (tp + fn);
%        precision    = tp / (tp + fp);
% 
%        results      = [maxVel ...
%            parts1 parts3 accuracy foldError trainTime ...
%            tn fp fn tp recall precision];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-3] Max vel %d *', ...
%            it, maxVel);
%        message2     = sprintf('[1-3] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-3]-maxvel');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
%                             %%%% Eps %%%%
% 
% dimensions  = dimensions13;
% comb        = comb13;
% 
% resultsAcc  = zeros(size(eps, 2), 1 + dataBinary);
% line = 1;
% 
% for i = 1 : size(eps, 2)
%     resultsAux = zeros(tests, 1 + dataBinary);
%     epss = eps(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-3] eps %d *', ...
%            it, epss);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data3 = zeros(size(data3_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data3(:, j) = data3_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data3Train   = datasample(data3, sizeTrainData3, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes3     = ones(sizeTrainData3, 1) * 2;
% 
%        data         = [data1Train;  data3Train]; 
%        classes      = [classes1;    classes3];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data3Test    = setdiff(data3, data3Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes3     = ones(size(data3Test, 1), 1) * 2;
% 
%        data         = [data1Test;   data3Test]; 
%        classes      = [classes1;    classes3];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, stdMaxVel, epss, ...
%            stdNeighbours, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts3       = sum(lbls == 2);
% 
%        tn           = confusion(1, 1);
%        fp           = confusion(1, 2);
%        fn           = confusion(2, 1);
%        tp           = confusion(2, 2);
%        recall       = tp / (tp + fn);
%        precision    = tp / (tp + fp);
% 
%        results      = [epss ...
%            parts1 parts3 accuracy foldError trainTime ...
%            tn fp fn tp recall precision];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-3] eps %d *', ...
%            it, epss);
%        message2     = sprintf('[1-3] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-3]-eps');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
% %% Data 2 - 3
% 
%                             %%%% Swarm Size %%%%
% 
% dimensions  = dimensions23;
% comb        = comb23;
% 
% resultsAcc  = zeros(size(swarmSizes, 2), 1 + dataBinary);
% line = 1;
% 
% for i = 1 : size(swarmSizes, 2)
%     resultsAux = zeros(tests, 1 + dataBinary);
%     swarmSize = swarmSizes(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [2-3] Swarm size %d *', ...
%            it, swarmSize);
%        disp(message);
% 
%        %%% Extract features data
%        data2 = zeros(size(data2_n, 1), dimensions);
%        data3 = zeros(size(data3_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data2(:, j) = data2_n(:, comb(1, j));
%            data3(:, j) = data3_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        data3Train   = datasample(data3, sizeTrainData3, ...
%            'Replace', false);
%        classes2     = ones(sizeTrainData2, 1) * 1;
%        classes3     = ones(sizeTrainData3, 1) * 2;
% 
%        data         = [data2Train;  data3Train]; 
%        classes      = [classes2;    classes3];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        data3Test    = setdiff(data3, data3Train, 'rows');
%        classes2     = ones(size(data2Test, 1), 1) * 1;
%        classes3     = ones(size(data3Test, 1), 1) * 2;
% 
%        data         = [data2Test;   data3Test]; 
%        classes      = [classes2;    classes3];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, swarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%            stdNeighbours, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts2       = sum(lbls == 1);
%        parts3       = sum(lbls == 2);
% 
%        tn           = confusion(1, 1);
%        fp           = confusion(1, 2);
%        fn           = confusion(2, 1);
%        tp           = confusion(2, 2);
%        recall       = tp / (tp + fn);
%        precision    = tp / (tp + fp);
% 
%        results      = [swarmSize ...
%            parts2 parts3 accuracy foldError trainTime ...
%            tn fp fn tp recall precision];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [2-3] Swarm size %d *', ...
%            it, swarmSize);
%        message2     = sprintf('[2-3] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[2-3]-swarm');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
%                             %%%% Max Its %%%%
% 
% dimensions  = dimensions23;
% comb        = comb23;
% 
% resultsAcc  = zeros(size(maxIts, 2), 1 + dataBinary);
% line = 1;
% 
% for i = 1 : size(maxIts, 2)
%     resultsAux = zeros(tests, 1 + dataBinary);
%     maxIt = maxIts(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [2-3] Max it %d *', ...
%            it, maxIt);
%        disp(message);
% 
%        %%% Extract features data
%        data2 = zeros(size(data2_n, 1), dimensions);
%        data3 = zeros(size(data3_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data2(:, j) = data2_n(:, comb(1, j));
%            data3(:, j) = data3_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        data3Train   = datasample(data3, sizeTrainData3, ...
%            'Replace', false);
%        classes2     = ones(sizeTrainData2, 1) * 1;
%        classes3     = ones(sizeTrainData3, 1) * 2;
% 
%        data         = [data2Train;  data3Train]; 
%        classes      = [classes2;    classes3];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        data3Test    = setdiff(data3, data3Train, 'rows');
%        classes2     = ones(size(data2Test, 1), 1) * 1;
%        classes3     = ones(size(data3Test, 1), 1) * 2;
% 
%        data         = [data2Test;   data3Test]; 
%        classes      = [classes2;    classes3];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            maxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%            stdNeighbours, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts2       = sum(lbls == 1);
%        parts3       = sum(lbls == 2);
% 
%        tn           = confusion(1, 1);
%        fp           = confusion(1, 2);
%        fn           = confusion(2, 1);
%        tp           = confusion(2, 2);
%        recall       = tp / (tp + fn);
%        precision    = tp / (tp + fp);
% 
%        results      = [maxIt ...
%            parts2 parts3 accuracy foldError trainTime ...
%            tn fp fn tp recall precision];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [2-3] Max it %d *', ...
%            it, maxIt);
%        message2     = sprintf('[2-3] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[2-3]-maxit');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
%                             %%%% Max Vels %%%%
% 
% dimensions  = dimensions23;
% comb        = comb23;
% 
% resultsAcc  = zeros(size(maxVels, 2), 1 + dataBinary);
% line = 1;
% 
% for i = 1 : size(maxVels, 2)
%     resultsAux = zeros(tests, 1 + dataBinary);
%     maxVel = maxVels(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [2-3] Max vel %d *', ...
%            it, maxVel);
%        disp(message);
% 
%        %%% Extract features data
%        data2 = zeros(size(data2_n, 1), dimensions);
%        data3 = zeros(size(data3_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data2(:, j) = data2_n(:, comb(1, j));
%            data3(:, j) = data3_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        data3Train   = datasample(data3, sizeTrainData3, ...
%            'Replace', false);
%        classes2     = ones(sizeTrainData2, 1) * 1;
%        classes3     = ones(sizeTrainData3, 1) * 2;
% 
%        data         = [data2Train;  data3Train]; 
%        classes      = [classes2;    classes3];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        data3Test    = setdiff(data3, data3Train, 'rows');
%        classes2     = ones(size(data2Test, 1), 1) * 1;
%        classes3     = ones(size(data3Test, 1), 1) * 2;
% 
%        data         = [data2Test;   data3Test]; 
%        classes      = [classes2;    classes3];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, maxVel, stdEps, ...
%            stdNeighbours, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts2       = sum(lbls == 1);
%        parts3       = sum(lbls == 2);
% 
%        tn           = confusion(1, 1);
%        fp           = confusion(1, 2);
%        fn           = confusion(2, 1);
%        tp           = confusion(2, 2);
%        recall       = tp / (tp + fn);
%        precision    = tp / (tp + fp);
% 
%        results      = [maxVel ...
%            parts2 parts3 accuracy foldError trainTime ...
%            tn fp fn tp recall precision];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [2-3] Max vel %d *', ...
%            it, maxVel);
%        message2     = sprintf('[2-3] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[2-3]-maxvel');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
%                             %%%% Eps %%%%
% 
% dimensions  = dimensions23;
% comb        = comb23;
% 
% resultsAcc  = zeros(size(eps, 2), 1 + dataBinary);
% line = 1;
% 
% for i = 1 : size(eps, 2)
%     resultsAux = zeros(tests, 1 + dataBinary);
%     epss = eps(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [2-3] eps %d *', ...
%            it, epss);
%        disp(message);
% 
%        %%% Extract features data
%        data2 = zeros(size(data2_n, 1), dimensions);
%        data3 = zeros(size(data3_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data2(:, j) = data2_n(:, comb(1, j));
%            data3(:, j) = data3_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        data3Train   = datasample(data3, sizeTrainData3, ...
%            'Replace', false);
%        classes2     = ones(sizeTrainData2, 1) * 1;
%        classes3     = ones(sizeTrainData3, 1) * 2;
% 
%        data         = [data2Train;  data3Train]; 
%        classes      = [classes2;    classes3];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        data3Test    = setdiff(data3, data3Train, 'rows');
%        classes2     = ones(size(data2Test, 1), 1) * 1;
%        classes3     = ones(size(data3Test, 1), 1) * 2;
% 
%        data         = [data2Test;   data3Test]; 
%        classes      = [classes2;    classes3];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, stdMaxVel, epss, ...
%            stdNeighbours, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts2       = sum(lbls == 1);
%        parts3       = sum(lbls == 2);
% 
%        tn           = confusion(1, 1);
%        fp           = confusion(1, 2);
%        fn           = confusion(2, 1);
%        tp           = confusion(2, 2);
%        recall       = tp / (tp + fn);
%        precision    = tp / (tp + fp);
% 
%        results      = [epss ...
%            parts2 parts3 accuracy foldError trainTime ...
%            tn fp fn tp recall precision];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [2-3] eps %d *', ...
%            it, epss);
%        message2     = sprintf('[2-3] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[2-3]-eps');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');

%% Data 1 - 2 - 3
% 
%                             %%%% Swarm Size %%%%
% 
% dimensions  = dimensions123;
% comb        = comb123;
% 
% resultsAcc  = zeros(size(swarmSizes, 2), 1 + dataFull);
% line = 1;
% 
% for i = 1 : size(swarmSizes, 2)
%     resultsAux = zeros(tests, 1 + dataFull);
%     swarmSize = swarmSizes(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-2-3] Swarm size %d *', ...
%            it, swarmSize);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data2 = zeros(size(data2_n, 1), dimensions);
%        data3 = zeros(size(data3_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data2(:, j) = data2_n(:, comb(1, j));
%            data3(:, j) = data3_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        data3Train   = datasample(data3, sizeTrainData3, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes2     = ones(sizeTrainData2, 1) * 2;
%        classes3     = ones(sizeTrainData3, 1) * 3;
% 
%        data         = [data1Train; data2Train;  data3Train]; 
%        classes      = [classes1; classes2;    classes3];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        data3Test    = setdiff(data3, data3Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes2     = ones(size(data2Test, 1), 1) * 2;
%        classes3     = ones(size(data3Test, 1), 1) * 3;
% 
%        data         = [data1Test; data2Test;   data3Test]; 
%        classes      = [classes1; classes2;    classes3];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, swarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%            stdNeighbours, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts2       = sum(lbls == 2);
%        parts3       = sum(lbls == 3);
% 
%        tn12           = confusion(1, 1);
%        fp12           = confusion(1, 2);
%        fn12           = confusion(2, 1);
%        tp12           = confusion(2, 2);
%        recall12       = tp12 / (tp12 + fn12);
%        precision12    = tp12 / (tp12 + fp12);
% 
%        tn13           = confusion(1, 1);
%        fp13           = confusion(1, 3);
%        fn13           = confusion(3, 1);
%        tp13           = confusion(3, 3);
%        recall13       = tp13 / (tp13 + fn13);
%        precision13    = tp13 / (tp13 + fp13);
% 
%        tn23           = confusion(1, 1);
%        fp23           = confusion(2, 3);
%        fn23           = confusion(3, 2);
%        tp23           = confusion(3, 3);
%        recall23       = tp23 / (tp23 + fn23);
%        precision23    = tp23 / (tp23 + fp23);
% 
%        results      = [swarmSize ...
%            parts2 parts3 accuracy foldError trainTime ...
%            tn12 fp12 fn12 tp12 recall12 precision12 ...
%            tn13 fp13 fn13 tp13 recall13 precision13 ...
%            tn23 fp23 fn23 tp23 recall23 precision23];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-2-3] Swarm size %d *', ...
%            it, swarmSize);
%        message2     = sprintf('[1-2-3] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-2-3]-swarm');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
%                             %%%% Max Its %%%%
% 
% dimensions  = dimensions123;
% comb        = comb123;
% 
% resultsAcc  = zeros(size(maxIts, 2), 1 + dataFull);
% line = 1;
% 
% for i = 1 : size(maxIts, 2)
%     resultsAux = zeros(tests, 1 + dataFull);
%     maxIt = maxIts(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-2-3] Max it %d *', ...
%            it, maxIt);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data2 = zeros(size(data2_n, 1), dimensions);
%        data3 = zeros(size(data3_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data2(:, j) = data2_n(:, comb(1, j));
%            data3(:, j) = data3_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        data3Train   = datasample(data3, sizeTrainData3, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes2     = ones(sizeTrainData2, 1) * 2;
%        classes3     = ones(sizeTrainData3, 1) * 3;
% 
%        data         = [data1Train; data2Train;  data3Train]; 
%        classes      = [classes1; classes2;    classes3];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        data3Test    = setdiff(data3, data3Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes2     = ones(size(data2Test, 1), 1) * 2;
%        classes3     = ones(size(data3Test, 1), 1) * 3;
% 
%        data         = [data1Test; data2Test;   data3Test]; 
%        classes      = [classes1; classes2;    classes3];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            maxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%            stdNeighbours, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts2       = sum(lbls == 2);
%        parts3       = sum(lbls == 3);
% 
%        tn12           = confusion(1, 1);
%        fp12           = confusion(1, 2);
%        fn12           = confusion(2, 1);
%        tp12           = confusion(2, 2);
%        recall12       = tp12 / (tp12 + fn12);
%        precision12    = tp12 / (tp12 + fp12);
% 
%        tn13           = confusion(1, 1);
%        fp13           = confusion(1, 3);
%        fn13           = confusion(3, 1);
%        tp13           = confusion(3, 3);
%        recall13       = tp13 / (tp13 + fn13);
%        precision13    = tp13 / (tp13 + fp13);
% 
%        tn23           = confusion(1, 1);
%        fp23           = confusion(2, 3);
%        fn23           = confusion(3, 2);
%        tp23           = confusion(3, 3);
%        recall23       = tp23 / (tp23 + fn23);
%        precision23    = tp23 / (tp23 + fp23);
% 
%        results      = [maxIt ...
%            parts2 parts3 accuracy foldError trainTime ...
%            tn12 fp12 fn12 tp12 recall12 precision12 ...
%            tn13 fp13 fn13 tp13 recall13 precision13 ...
%            tn23 fp23 fn23 tp23 recall23 precision23];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-2-3] Max it %d *', ...
%            it, maxIt);
%        message2     = sprintf('[1-2-3] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-2-3]-maxit');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
%                             %%%% Max Vels %%%%
% 
% dimensions  = dimensions123;
% comb        = comb123;
% 
% resultsAcc  = zeros(size(maxVels, 2), 1 + dataFull);
% line = 1;
% 
% for i = 1 : size(maxVels, 2)
%     resultsAux = zeros(tests, 1 + dataFull);
%     maxVel = maxVels(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-2-3] Max vel %d *', ...
%            it, maxVel);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data2 = zeros(size(data2_n, 1), dimensions);
%        data3 = zeros(size(data3_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data2(:, j) = data2_n(:, comb(1, j));
%            data3(:, j) = data3_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        data3Train   = datasample(data3, sizeTrainData3, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes2     = ones(sizeTrainData2, 1) * 2;
%        classes3     = ones(sizeTrainData3, 1) * 3;
% 
%        data         = [data1Train; data2Train;  data3Train]; 
%        classes      = [classes1; classes2;    classes3];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        data3Test    = setdiff(data3, data3Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes2     = ones(size(data2Test, 1), 1) * 2;
%        classes3     = ones(size(data3Test, 1), 1) * 3;
% 
%        data         = [data1Test; data2Test;   data3Test]; 
%        classes      = [classes1; classes2;    classes3];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, maxVel, stdEps, ...
%            stdNeighbours, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts2       = sum(lbls == 2);
%        parts3       = sum(lbls == 3);
% 
%        tn12           = confusion(1, 1);
%        fp12           = confusion(1, 2);
%        fn12           = confusion(2, 1);
%        tp12           = confusion(2, 2);
%        recall12       = tp12 / (tp12 + fn12);
%        precision12    = tp12 / (tp12 + fp12);
% 
%        tn13           = confusion(1, 1);
%        fp13           = confusion(1, 3);
%        fn13           = confusion(3, 1);
%        tp13           = confusion(3, 3);
%        recall13       = tp13 / (tp13 + fn13);
%        precision13    = tp13 / (tp13 + fp13);
% 
%        tn23           = confusion(1, 1);
%        fp23           = confusion(2, 3);
%        fn23           = confusion(3, 2);
%        tp23           = confusion(3, 3);
%        recall23       = tp23 / (tp23 + fn23);
%        precision23    = tp23 / (tp23 + fp23);
% 
%        results      = [maxVel ...
%            parts2 parts3 accuracy foldError trainTime ...
%            tn12 fp12 fn12 tp12 recall12 precision12 ...
%            tn13 fp13 fn13 tp13 recall13 precision13 ...
%            tn23 fp23 fn23 tp23 recall23 precision23];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-2-3] Max vel %d *', ...
%            it, maxVel);
%        message2     = sprintf('[1-2-3] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-2-3]-maxvel');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
%                             %%%% Eps %%%%
% 
% dimensions  = dimensions123;
% comb        = comb123;
% 
% resultsAcc  = zeros(size(eps, 2), 1 + dataFull);
% line = 1;
% 
% for i = 1 : size(eps, 2)
%     resultsAux = zeros(tests, 1 + dataFull);
%     epss = eps(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-2-3] eps %d *', ...
%            it, epss);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data2 = zeros(size(data2_n, 1), dimensions);
%        data3 = zeros(size(data3_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data2(:, j) = data2_n(:, comb(1, j));
%            data3(:, j) = data3_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        data3Train   = datasample(data3, sizeTrainData3, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes2     = ones(sizeTrainData2, 1) * 2;
%        classes3     = ones(sizeTrainData3, 1) * 3;
% 
%        data         = [data1Train; data2Train;  data3Train]; 
%        classes      = [classes1; classes2;    classes3];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        data3Test    = setdiff(data3, data3Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes2     = ones(size(data2Test, 1), 1) * 2;
%        classes3     = ones(size(data3Test, 1), 1) * 3;
% 
%        data         = [data1Test; data2Test;   data3Test]; 
%        classes      = [classes1; classes2;    classes3];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, stdMaxVel, epss, ...
%            stdNeighbours, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts2       = sum(lbls == 2);
%        parts3       = sum(lbls == 3);
% 
%        tn12           = confusion(1, 1);
%        fp12           = confusion(1, 2);
%        fn12           = confusion(2, 1);
%        tp12           = confusion(2, 2);
%        recall12       = tp12 / (tp12 + fn12);
%        precision12    = tp12 / (tp12 + fp12);
% 
%        tn13           = confusion(1, 1);
%        fp13           = confusion(1, 3);
%        fn13           = confusion(3, 1);
%        tp13           = confusion(3, 3);
%        recall13       = tp13 / (tp13 + fn13);
%        precision13    = tp13 / (tp13 + fp13);
% 
%        tn23           = confusion(1, 1);
%        fp23           = confusion(2, 3);
%        fn23           = confusion(3, 2);
%        tp23           = confusion(3, 3);
%        recall23       = tp23 / (tp23 + fn23);
%        precision23    = tp23 / (tp23 + fp23);
% 
%        results      = [epss ...
%            parts2 parts3 accuracy foldError trainTime ...
%            tn12 fp12 fn12 tp12 recall12 precision12 ...
%            tn13 fp13 fn13 tp13 recall13 precision13 ...
%            tn23 fp23 fn23 tp23 recall23 precision23];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-2-3] eps %d *', ...
%            it, epss);
%        message2     = sprintf('[1-2-3] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-2-3]-eps');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
%
%                             %%%% knn %%%%
% 
% dimensions  = dimensions123;
% comb        = comb123;
% 
% resultsAcc  = zeros(size(neighbours, 2), 1 + dataFull);
% line = 1;
% 
% for i = 1 : size(neighbours, 2)
%     resultsAux = zeros(tests, 1 + dataFull);
%     neigh = neighbours(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-2-3] neigh %d *', ...
%            it, neigh);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data2 = zeros(size(data2_n, 1), dimensions);
%        data3 = zeros(size(data3_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data2(:, j) = data2_n(:, comb(1, j));
%            data3(:, j) = data3_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        data3Train   = datasample(data3, sizeTrainData3, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes2     = ones(sizeTrainData2, 1) * 2;
%        classes3     = ones(sizeTrainData3, 1) * 3;
% 
%        data         = [data1Train; data2Train;  data3Train]; 
%        classes      = [classes1; classes2;    classes3];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        data3Test    = setdiff(data3, data3Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes2     = ones(size(data2Test, 1), 1) * 2;
%        classes3     = ones(size(data3Test, 1), 1) * 3;
% 
%        data         = [data1Test; data2Test;   data3Test]; 
%        classes      = [classes1; classes2;    classes3];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%            neigh, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts2       = sum(lbls == 2);
%        parts3       = sum(lbls == 3);
% 
%        tn12           = confusion(1, 1);
%        fp12           = confusion(1, 2);
%        fn12           = confusion(2, 1);
%        tp12           = confusion(2, 2);
%        recall12       = tp12 / (tp12 + fn12);
%        precision12    = tp12 / (tp12 + fp12);
% 
%        tn13           = confusion(1, 1);
%        fp13           = confusion(1, 3);
%        fn13           = confusion(3, 1);
%        tp13           = confusion(3, 3);
%        recall13       = tp13 / (tp13 + fn13);
%        precision13    = tp13 / (tp13 + fp13);
% 
%        tn23           = confusion(1, 1);
%        fp23           = confusion(2, 3);
%        fn23           = confusion(3, 2);
%        tp23           = confusion(3, 3);
%        recall23       = tp23 / (tp23 + fn23);
%        precision23    = tp23 / (tp23 + fp23);
% 
%        results      = [neigh ...
%            parts2 parts3 accuracy foldError trainTime ...
%            tn12 fp12 fn12 tp12 recall12 precision12 ...
%            tn13 fp13 fn13 tp13 recall13 precision13 ...
%            tn23 fp23 fn23 tp23 recall23 precision23];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-2-3] neigh %d *', ...
%            it, neigh);
%        message2     = sprintf('[1-2-3] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-2-3]-neigh');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');
% 
%                             %%%% inertia %%%%
% 
% dimensions  = dimensions123;
% comb        = comb123;
% 
% resultsAcc  = zeros(size(inertias, 2), 1 + dataFull);
% line = 1;
% 
% for i = 1 : size(inertias, 2)
%     resultsAux = zeros(tests, 1 + dataFull);
%     inertia = inertias(1, i);
%     
%     for it = 1 : tests
%        message      = sprintf('* %d * [1-2-3] inertia %d *', ...
%            it, inertia);
%        disp(message);
% 
%        %%% Extract features data
%        data1 = zeros(size(data1_n, 1), dimensions);
%        data2 = zeros(size(data2_n, 1), dimensions);
%        data3 = zeros(size(data3_n, 1), dimensions);
%        
%        for j = 1 : dimensions
%            data1(:, j) = data1_n(:, comb(1, j));
%            data2(:, j) = data2_n(:, comb(1, j));
%            data3(:, j) = data3_n(:, comb(1, j));
%        end
% 
%        %%% Training data
%        data1Train   = datasample(data1, sizeTrainData1, ...
%            'Replace', false);
%        data2Train   = datasample(data2, sizeTrainData2, ...
%            'Replace', false);
%        data3Train   = datasample(data3, sizeTrainData3, ...
%            'Replace', false);
%        classes1     = ones(sizeTrainData1, 1) * 1;
%        classes2     = ones(sizeTrainData2, 1) * 2;
%        classes3     = ones(sizeTrainData3, 1) * 3;
% 
%        data         = [data1Train; data2Train;  data3Train]; 
%        classes      = [classes1; classes2;    classes3];
%        save(trainFile, 'data', 'classes');
% 
%        %%% Testing data
%        data1Test    = setdiff(data1, data1Train, 'rows');
%        data2Test    = setdiff(data2, data2Train, 'rows');
%        data3Test    = setdiff(data3, data3Train, 'rows');
%        classes1     = ones(size(data1Test, 1), 1) * 1;
%        classes2     = ones(size(data2Test, 1), 1) * 2;
%        classes3     = ones(size(data3Test, 1), 1) * 3;
% 
%        data         = [data1Test; data2Test;   data3Test]; 
%        classes      = [classes1; classes2;    classes3];
%        save(testFile, 'data', 'classes');
% 
%        %%% Train and test
%        [accuracy, confusion, trainTime, foldError, lbls] = ...
%            tester(trainFile, testFile, stdSwarmSize, dimensions, ...
%            stdMaxIt, minRange, maxRange, stdMaxVel, stdEps, ...
%            stdNeighbours, inertia, draw);
% 
%        delete(trainFile);
%        delete(testFile);
% 
%        %%% Save results
%        parts1       = sum(lbls == 1);
%        parts2       = sum(lbls == 2);
%        parts3       = sum(lbls == 3);
% 
%        tn12           = confusion(1, 1);
%        fp12           = confusion(1, 2);
%        fn12           = confusion(2, 1);
%        tp12           = confusion(2, 2);
%        recall12       = tp12 / (tp12 + fn12);
%        precision12    = tp12 / (tp12 + fp12);
% 
%        tn13           = confusion(1, 1);
%        fp13           = confusion(1, 3);
%        fn13           = confusion(3, 1);
%        tp13           = confusion(3, 3);
%        recall13       = tp13 / (tp13 + fn13);
%        precision13    = tp13 / (tp13 + fp13);
% 
%        tn23           = confusion(1, 1);
%        fp23           = confusion(2, 3);
%        fn23           = confusion(3, 2);
%        tp23           = confusion(3, 3);
%        recall23       = tp23 / (tp23 + fn23);
%        precision23    = tp23 / (tp23 + fp23);
% 
%        results      = [inertia ...
%            parts2 parts3 accuracy foldError trainTime ...
%            tn12 fp12 fn12 tp12 recall12 precision12 ...
%            tn13 fp13 fn13 tp13 recall13 precision13 ...
%            tn23 fp23 fn23 tp23 recall23 precision23];
%        resultsAux(it, :) = results;
% 
%        message      = sprintf('* %d * [1-2-3] inertia %d *', ...
%            it, inertia);
%        message2     = sprintf('[1-2-3] Accuracy: %d', accuracy);
%        disp(message);  disp(message2); 
%     end
% 
%     resultsAux(isnan(resultsAux)) = 0.0;
%     resultsAcc(line, :) = mean(resultsAux);
%     line = line + 1;
% end
% 
% % Write files
% 
% resultsFile  = sprintf('[1-2-3]-inertia');
% csvwrite([resCSVs resultsFile '.csv'], resultsAcc);
% save([resMats resultsFile '.mat'], 'resultsAcc');