function [ loss ] = kfold( mdl, k )
%%% Dado un modelo de clasificador y un valor de 'k', se realiza un k-fold cross validation.

cvmdl = crossval(mdl, 'kfold', k);
loss = kfoldLoss(cvmdl);

end

