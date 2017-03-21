function [ mdl ] = knn( prototypes, labels, k, dist, weight )
%%% Dados unos prototipos con sus etiquetas m?s un valor de 'k', se crea un modelo de clasificador k-NN.

mdl = ClassificationKNN.fit(prototypes, labels, 'NumNeighbors', k);

mdl.Distance = dist;
mdl.DistanceWeight = weight;

end

