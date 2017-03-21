function [] = plotSignals( signalMatrix )
%%% Se dibujan las señales según la matriz dada.

colors = ['b', 'm', 'c', 'r', 'g', 'y', '--b', 'k', '--c', '--m'];

for i = 1 : size(signalMatrix, 1)
    plot(signalMatrix(i,:), colors(i))
    hold on
end

xlabel('Samples through time');
ylabel('Value');
legend('sig1', 'sig2', 'sig3', 'sig4', 'sig5', 'sig6', 'sig7', 'sig8', ...
    'sig9', 'sig10');

end

