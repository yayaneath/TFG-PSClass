%%% Este script genera los datos normalizados y no normalizados

clc;clear;

%%
file = './datos/d2_8f_v2_normal_2_nocomplex.mat';
load(file);

%%
trainPercentage = 0.75; 

data_1_trainSamples = round(size(data1,1) * trainPercentage);
data_2_trainSamples = round(size(data2,1) * trainPercentage);
data_3_trainSamples = round(size(data3,1) * trainPercentage);

%% data 1 - 2

data = [data1(1:data_1_trainSamples,:);
        data2(1:data_2_trainSamples,:)];
classes = [classes1(1:data_1_trainSamples,:);
           classes2(1:data_2_trainSamples,:)];
save('./non_normal/1-2cl_8f_75.mat', 'data', 'classes'); 

data = [data1(data_1_trainSamples + 1:end,:); 
        data2(data_2_trainSamples + 1:end,:)];
classes = [classes1(data_1_trainSamples + 1:end,:); 
           classes2(data_2_trainSamples + 1:end,:)];
save('./non_normal/1-2cl_8f_25.mat', 'data', 'classes'); 

%% data 1 - 3

data = [data1(1:data_1_trainSamples,:);
        data3(1:data_3_trainSamples,:)];
classes = [classes1(1:data_1_trainSamples,:);
           classes3(1:data_3_trainSamples,:)];
classes(classes == 3) = 2;
save('./non_normal/1-3cl_8f_75.mat', 'data', 'classes'); 

data = [data1(data_1_trainSamples + 1:end,:); 
        data3(data_3_trainSamples + 1:end,:)];
classes = [classes1(data_1_trainSamples + 1:end,:); 
           classes3(data_3_trainSamples + 1:end,:)];
classes(classes == 3) = 2;
save('./non_normal/1-3cl_8f_25.mat', 'data', 'classes'); 

%% data 2 - 3

data = [data2(1:data_2_trainSamples,:);
        data3(1:data_3_trainSamples,:)];
classes = [classes2(1:data_2_trainSamples,:);
           classes3(1:data_3_trainSamples,:)];
classes = classes - 1;       
save('./non_normal/2-3cl_8f_75.mat', 'data', 'classes'); 

data = [data2(data_2_trainSamples + 1:end,:); 
        data3(data_3_trainSamples + 1:end,:)];
classes = [classes2(data_2_trainSamples + 1:end,:); 
           classes3(data_3_trainSamples + 1:end,:)];
classes = classes - 1;
save('./non_normal/2-3cl_8f_25.mat', 'data', 'classes'); 

%% data 1 - 2 - 3

data = [data1(1:data_1_trainSamples,:);
        data2(1:data_2_trainSamples,:);
        data3(1:data_3_trainSamples,:)];
classes = [classes1(1:data_1_trainSamples,:);
           classes2(1:data_2_trainSamples,:);
           classes3(1:data_3_trainSamples,:)];
save('./non_normal/1-2-3cl_8f_75.mat', 'data', 'classes'); 

data = [data1(data_1_trainSamples + 1:end,:); 
        data2(data_2_trainSamples + 1:end,:);
        data3(data_3_trainSamples + 1:end,:)];
classes = [classes1(data_1_trainSamples + 1:end,:); 
           classes2(data_2_trainSamples + 1:end,:);
           classes3(data_3_trainSamples + 1:end,:)];
save('./non_normal/1-2-3cl_8f_25.mat', 'data', 'classes'); 