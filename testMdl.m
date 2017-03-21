function [ hitsRate, conf ] = testMdl( mdl, testSet, testLabels )
%%% Dado un modelo de k-NN, un test set con sus labels, se clasifican los datos de entrada y se miden los aciertos. Además se muestra una matriz de confusión.

setSize = size(testSet,1);
hits = 0;

labels = size(unique(testLabels),1);
conf = zeros(labels, labels);

for i = 1 : setSize   
    label = testLabels(i,:);
    pred = predict(mdl, testSet(i,:));
    
    %fprintf('label = %d pred = %d \n', label, pred);
    
    if  label == pred
        hits = hits + 1;
    end
    
    conf(label, pred) = conf(label, pred) + 1;
end

disp(conf);

hitsRate = hits / setSize;

end

