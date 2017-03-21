function [ accuracy, confusionMatrix, trainTime, classTime, foldError, lbls ] ...
    = tester( trainFile, testFile, swarmSize, dimensions, maxIts, ...
    minRange, maxRange, maxVel, eps, neighbours, inertia, draw, ...
    dist, weight)

tic();

% Build the prototypes swarm
disp('Building the swarm...');
[parts, lbls] = psclass(swarmSize, dimensions, trainFile, maxIts, ...
    minRange, maxRange, maxVel, eps, inertia, draw);
%load('swarm.mat');
trainTime = toc();

% Build the k-NN classifier model
disp('Creating the k-NN model...');
mdl = knn(parts, lbls, neighbours, dist, weight);

% Test it with the file data
disp('Testing the model...');
load(testFile);
tic();
[accuracy, confusionMatrix] = testMdl(mdl, data, classes);
classTime = toc();

% Cross Validation
disp('Cross Validation...');
foldError = kfold(mdl, 5);

end

