function [ particles ] = psc( swarmSize, dimensions, dataFile, maxIterations, ...
    rangeMin, rangeMax, velMax)
%%% Implementación del PSC.

% PSC parameters
inertiaWeight = 0.90;
cognitiveTerm = 2;
socialTerm = 2;

fprintf('w = %d c1 = %d c2 = %d iterations = %d \n\n', inertiaWeight,...
    cognitiveTerm, socialTerm, maxIterations);

% Load data to be clustered
load(dataFile, 'data');
dataSize = size(data, 1); %#ok<NODEF>

% Particles and velocities initialization
particles = randi([25, 25], swarmSize, dimensions);
velocities = (velMax-(-velMax)) .* rand(swarmSize, dimensions) + (-velMax);

% Distances initialization
dist = zeros(dataSize, swarmSize);

% Display initial situation
disp('Data')
disp(data);

disp('Particles')
disp(particles)

disp('Velocities')
disp(velocities)

figure(10);
plot(particles(:, 1), particles(:, 2), 'ro');
axis([rangeMin, rangeMax, rangeMin, rangeMax]);
title('Initial population');
xlabel('X');
ylabel('Y');

% Initialize global best. For each input data, the best
% found distance to a particle and the particle's position is stored.
globalBestDistances = inf(dataSize, 1);
globalBestParticles = zeros(dataSize, dimensions);

% Initialize local best. For each particle, the best
% found distance to an input data and the particle's position is stored.
localBestDistances = inf(swarmSize, 1); 
localBestParticles = particles;

% Loop
iter = 0;

while iter < maxIterations 
    nextParticles = particles;
    nextVelocities = velocities;
    victories = zeros(swarmSize, 1);
    
    for i = 1 : dataSize
        % Compute distance from data i to particles
        dist(i,:) = pdist2(data(i,:), particles);
        
        % Get closer particle
        [minDist, minIndex] = min(dist(i,:));
        
        % Update victories count
        victories(minIndex) = victories(minIndex) + 1;
        
        % Update particle's local best
        if minDist < localBestDistances(minIndex) 
            localBestDistances(minIndex) = minDist;
            localBestParticles(minIndex,:) = particles(minIndex,:);
        end
        
        % Update data's global best
        if minDist < globalBestDistances(i)
            globalBestDistances(i) = minDist;
            globalBestParticles(i,:) = particles(minIndex,:);
        end
        
        % Update winning particle's velocity
        r1 = rand(1, dimensions);
        r2 = rand(1, dimensions);
        r3 = rand(1, dimensions);

        nextVelocities(minIndex,:) = velocities(minIndex,:) ...
            + cognitiveTerm * r1 .* (localBestParticles(minIndex,:) - particles(minIndex,:)) ...
            + socialTerm * r2 .* (globalBestParticles(i,:) - particles(minIndex,:)) ...
            + r3 .* (data(i,:) - particles(minIndex,:));
        
        % Ensure velocity is in range
        vel = nextVelocities(minIndex,:);
        vel(vel > velMax) = velMax;
        vel(vel < -velMax) = -velMax;
        nextVelocities(minIndex,:) = vel;
        
        % Update winning particle's position
        nextParticles(minIndex,:) = particles(minIndex,:) + nextVelocities(minIndex,:);
        
    end
   
    % Update non-winning particles moving them toward the most winner.
    [~, indexMostWinner] = max(victories);
    for i = 1 : swarmSize
        if victories(i) == 0
            % Update non-winning particle's velocity
            r4 = rand(1, dimensions);
            nextVelocities(i,:) = inertiaWeight * velocities(i,:) ...
                + r4 .* (particles(indexMostWinner,:) - particles(i,:));

            % Update non-winning particle's position
            nextParticles(i,:) = particles(i,:) + nextVelocities(i,:);
        end
    end
  
    % Update positions and velocities for next iteration
    particles = nextParticles;
    velocities = nextVelocities;
    
    % Update inerthia weight
    inertiaWeight = 0.95 * inertiaWeight;
    if inertiaWeight < 0.01
        inertiaWeight = 0.01;
    end
    
    %Update loop
    iter = iter + 1;
    
    %See evolution
    figure(10);
    plot(particles(:, 1), particles(:, 2), 'ro');
    axis([rangeMin, rangeMax, rangeMin, rangeMax]);
    title('Running...');
    xlabel('X');
    ylabel('Y');
end

% Final distribution
figure(10);
plot(particles(:, 1), particles(:, 2), 'ro');
hold on;
plot(data(:, 1), data(:, 2), 'bx');
axis([rangeMin, rangeMax, rangeMin, rangeMax]);
legend('Particles', 'Data', 'Location', 'southeast');
title('Final distrubtion');
xlabel('X');
ylabel('Y');

end

