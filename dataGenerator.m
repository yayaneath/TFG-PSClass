%%% Script que genera un data set donde una clase cumple que 0 < x,y < 15 mientras que la otra clase cumple que 35 < x,y < 50

dimensions = 2;
rng(0, 'twister');

size = 10;
minA = 0;
maxA = 15;
numbersA = randi([minA, maxA], size, dimensions);

aux = ones(size, 1);

size = 13;
minA = 35;
maxA = 50;
numbersB = randi([minA, maxA], size, dimensions);

classes = [aux ; 2 .* ones(size, 1)];

data = [numbersA ; numbersB];

save('data.mat', 'data', 'classes');

clear;