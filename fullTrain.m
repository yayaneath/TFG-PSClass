%%% Script para entregar con un data set y el PSClass, probar el modelo con un data set de prueba y ver los resultados obtenidos por dicho modelo.

clear;
clc;

% trainFile = './bd_3-8_skewkurt/3-8_skewkurt_13_75.mat';
% testFile = './bd_3-8_skewkurt/3-8_skewkurt_13_25.mat';
% 
% swarmSize = 100;
% dimensions = 2;
% dataFile = trainFile;
% maxIts = 1000;
% minRange = -4;
% maxRange = 74;
% maxVel = 0.2;
% eps = 0.0;

trainFile = 'train_75_normal.mat';
testFile = 'train_25_normal.mat';

swarmSize = 100;
dimensions = 2;
dataFile = trainFile;
maxIts = 100;
minRange = 0;
maxRange = 1;
maxVel = 0.001;
eps = 0.0;

tic();

% Build the prototypes swarm
disp('Building the swarm...');
[parts, lbls] = psclass(swarmSize, dimensions, dataFile, maxIts, ...
    minRange, maxRange, maxVel, eps, 1);
%load('swarm.mat');
elapsed = toc();

% Build the k-NN classifier model
disp('Creating the k-NN model...');
mdl = knn(parts, lbls, 3);

% Test it with the file data
disp('Testing the model...');
load(testFile);
testMdl(mdl, data, classes)

% Cross Validation
disp('Cross Validation...');
kfold(mdl, 5)

disp('Elapsed time');
disp(elapsed);
