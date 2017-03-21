function [ optimum ] = pso( type, swarmSize, dimensions, objFunction, ...
    maxIterations, rangeMin, rangeMax )
%%% Implementación del PSO básico.

% Initializing parameters
inertiaWeight = 0.95;
cognitiveTerm = 2;
socialTerm = 2;

fprintf('w = %d c1 = %d c2 = %d iterations = %d \n\n', inertiaWeight,...
    cognitiveTerm, socialTerm, maxIterations);

% Initializing swarm positions and velocities
% particles = rand(swarmSize, dimensions)
particles = randi([rangeMin, rangeMax], swarmSize, dimensions);
velocities = rand(swarmSize, dimensions);

figure(10);
plot(particles(:, 1), particles(:, 2), 'bo');
axis([rangeMin, rangeMax, rangeMin, rangeMax]);
title('Initial population');
xlabel('X');
ylabel('Y');

disp('Particles')
disp(particles)

disp('Velocities')
disp(velocities)

% Evaluate population
values = [];

for row = 1 : swarmSize
    particle = particles(row, :);
    parms = num2cell(particle);
    values = cat(1, values, objFunction(parms{:}));
end

disp('Values')
disp(values)

% Initialize global and local optimum values
if type == 0
    [globalBestValue, globalBestIndex] = max(values);
else
    [globalBestValue, globalBestIndex] = min(values);
end

globalBestParticle = particles(globalBestIndex, :);

iterBest = zeros(maxIterations, 1);
globalBest = zeros(maxIterations, 1);
iterBest(1) = globalBestValue;
globalBest(1) = globalBestValue;

localBestParticles = particles;
localBestValues = values;

% Start iterations
iter = 0;

while iter < maxIterations
    iter = iter + 1;
    
    % Update velocities
    r1 = rand(swarmSize, dimensions);
    r2 = rand(swarmSize, dimensions);
    velocities = inertiaWeight * velocities + cognitiveTerm * r1.* ...
        (localBestParticles - particles) + socialTerm * r2.* ...
        (ones(swarmSize, 1) * globalBestParticle - particles);
    
    % Update positions
    particles = particles + velocities;
    particles(particles > rangeMax) = rangeMax;
    particles(particles < rangeMin) = rangeMin;
   
    % Evaluate the new swarm
    values = [];
    for row = 1 : swarmSize
        particle = particles(row, :);
        parms = num2cell(particle);
        values = cat(1, values, objFunction(parms{:}));
    end
    
    % Update best local positions
    if type == 0
        betterValues = values > localBestValues;
    else
        betterValues = values < localBestValues;
    end
    
    localBestValues = localBestValues .* not(betterValues) + ...
        values .* betterValues;
    localBestParticles(betterValues, :) = ...
        particles(betterValues, :);
    
    % Update global best
    if type == 0
        [auxBest, indexAux] = max(localBestValues);
        
        if auxBest > globalBestValue
            globalBestParticle = particles(indexAux, :);
            globalBestValue = auxBest;
        end
    else
        [auxBest, indexAux] = min(localBestValues);
        
        if auxBest < globalBestValue
            globalBestParticle = particles(indexAux, :);
            globalBestValue = auxBest;
        end
    end
    
    % Update inerthia weight
    inertiaWeight = 0.95 * inertiaWeight;
    
    % Plot information
    globalBest(iter+1) = globalBestValue;
    if type == 0
        iterBest(iter+1) = max(values);
    else
        iterBest(iter+1) = min(values);
    end
    
    figure(10);
    plot(particles(:, 1), particles(:, 2), 'bo');
    axis([rangeMin, rangeMax, rangeMin, rangeMax]);
    title('Running...');
    xlabel('X');
    ylabel('Y');
end

% Plot final distribution
figure(10);
plot(particles(:, 1), particles(:, 2), 'bo');
axis([rangeMin, rangeMax, rangeMin, rangeMax]);
title('Final distribution');
xlabel('X');
ylabel('Y');

% Plot evolution
figure(1)
iters = 0 : length(iterBest) - 1;
plot(iters, iterBest, '-ro', iters, globalBest, '-.b');
xlabel('Generation');
ylabel('Value');
legend('iterBest', 'globalBest');

optimum = globalBestParticle;

end

