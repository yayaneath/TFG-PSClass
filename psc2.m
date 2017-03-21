function [ particles, velocities, localBestParticles, ...
    localBestDistances, globalBestParticles, globalBestDistances, ...
    inertiaWeight, labels ] = psc2( swarmSize, dimensions, dataFile, ...
    maxIterations, rangeMin, rangeMax, velMax, epsilon, inertia, draw)
%%% Implementacion del PSC con asignacion de etiquetas a las particulas.

% PSC parameters
inertiaWeight = inertia;
cognitiveTerm = 1;  %2
socialTerm = 1;     %2

fprintf('w = %d c1 = %d c2 = %d iterations = %d \n\n', inertiaWeight,...
    cognitiveTerm, socialTerm, maxIterations);

% Load data to be clustered
load(dataFile);
dataSize = size(data, 1); %#ok<NODEF>
dataClasses = size(unique(classes),1); %#ok<NODEF>

% Particles and velocities initialization
particles = randi([rangeMin, rangeMax], swarmSize, dimensions);
velocities = (velMax-(-velMax)) .* rand(swarmSize, dimensions) + (-velMax);

% Initialize labels variables
labels = zeros(swarmSize, 1);

% Distances initialization
dist = zeros(dataSize, swarmSize);

if (draw)    
    writerObj = VideoWriter('psc.avi');
    open(writerObj);
    
    figure(1); 
    
    dl1 = (classes == 1); d1 = data(dl1,:);
    dl2 = (classes == 2); d2 = data(dl2,:);
    dl3 = (classes == 3); d3 = data(dl3,:);

    figure(1);
    h = plot(d1(:, 1), d1(:, 2), 'rx', ...
             d2(:, 1), d2(:, 2), 'bx', ...
             d3(:, 1), d3(:, 2), 'gx', 'MarkerSize', 17);
    axis([rangeMin, rangeMax, rangeMin, rangeMax]);

    if (sum(d3) == 0)
        legend('d1', 'd2', 'Location', 'southeast');
    else
        legend('d1', 'd2', 'd3', 'Location', 'southeast');
    end

    title('Intialising PSC... ');
    xlabel('X');
    ylabel('Y');
    
    set(findall(gcf,'type','axes'),'fontsize',17)
    set(findall(gcf,'type','text'),'fontSize',17) 
    
    frame = getframe(gcf);
    for z = 0 : 10
        writeVideo(writerObj,frame);
    end
    %print('it-init-psc.jpg', '-djpeg');
end

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
    countLabels = zeros(swarmSize, dataClasses);
    
    for i = 1 : dataSize
        % Compute distance from data i to particles
        dist(i,:) = pdist2(data(i,:), particles);
        
        % Get closer particle
        [minDist, minIndex] = min(dist(i,:));
        
        % Count class label
        class = classes(i,:);
        countLabels(minIndex,class) = countLabels(minIndex,class) + 1;
        %countLabels(minIndex,class) = countLabels(minIndex,class) + 1 / inertiaWeight;
        %labels(minIndex) = class;
        
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
        %particlePos = particles(minIndex,:) + nextVelocities(minIndex,:);
        %particlePos(particlePos > rangeMax) = rangeMax;
        %particlePos(particlePos < rangeMin) = rangeMin;
        %nextParticles(minIndex,:) = particlePos;
        
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
            %particlePos = particles(i,:) + nextVelocities(i,:);
            %particlePos(particlePos > rangeMax) = rangeMax;
            %particlePos(particlePos < rangeMin) = rangeMin;
            %nextParticles(i,:) = particlePos;
        end
    end
  
    % Update positions and velocities for next iteration
    diff = abs(particles - nextParticles);    
    particles = nextParticles;
    velocities = nextVelocities;
    
    % Update labels
    [~, labels] = max(countLabels, [], 2);
    
    % Update inerthia weight
    inertiaWeight = 0.95 * inertiaWeight;
    %if inertiaWeight < 0.01
    %    inertiaWeight = 0.01;
    %end
    
    %Update loop
    iter = iter + 1;
    
    %See evolution
    if (mod(iter, 10) == 0)
        display(iter);
    end
    
    if (draw)
        figure(1);
        
        dl1 = (classes == 1); d1 = data(dl1,:);
        dl2 = (classes == 2); d2 = data(dl2,:);
        dl3 = (classes == 3); d3 = data(dl3,:);

        cl1 = (labels == 1); p1 = particles(cl1,:);
        cl2 = (labels == 2); p2 = particles(cl2,:);
        cl3 = (labels == 3); p3 = particles(cl3,:);

        figure(1);
        plot(p1(:, 1), p1(:, 2), 'ro', ...
             p2(:, 1), p2(:, 2), 'bo', ...
             p3(:, 1), p3(:, 2), 'go', ...
             d1(:, 1), d1(:, 2), 'rx', ...
             d2(:, 1), d2(:, 2), 'bx', ...
             d3(:, 1), d3(:, 2), 'gx', 'MarkerSize', 17);
        axis([rangeMin, rangeMax, rangeMin, rangeMax]);

        if (sum(d3) == 0)
            legend('p1', 'p2', 'd1', 'd2', 'Location', 'southeast');
        else
            legend('p1', 'p2','p3', 'd1', 'd2', 'd3', 'Location', 'southeast');
        end

        name = sprintf('Iteration %d - PSC ', iter - 1);
        title(name);
        xlabel('X');
        ylabel('Y');
        
        frame = getframe(gcf);
        for z = 0 : 10
            writeVideo(writerObj,frame);
        end
        
        %name = sprintf('it-%d-psc.jpg', iter - 1);
        %print(name, '-djpeg');
    end
    
    % Test wether swarm has already converged
    if mean(diff) < epsilon
        disp('break');
        disp(iter);
        break;
    end
end

if (draw)
    dl1 = (classes == 1); d1 = data(dl1,:);
    dl2 = (classes == 2); d2 = data(dl2,:);
    dl3 = (classes == 3); d3 = data(dl3,:);

    cl1 = (labels == 1); p1 = particles(cl1,:);
    cl2 = (labels == 2); p2 = particles(cl2,:);
    cl3 = (labels == 3); p3 = particles(cl3,:);

    figure(1);
    plot(p1(:, 1), p1(:, 2), 'ro', ...
         p2(:, 1), p2(:, 2), 'bo', ...
         p3(:, 1), p3(:, 2), 'go', ...
         d1(:, 1), d1(:, 2), 'rx', ...
         d2(:, 1), d2(:, 2), 'bx', ...
         d3(:, 1), d3(:, 2), 'gx', 'MarkerSize', 17);
    axis([rangeMin, rangeMax, rangeMin, rangeMax]);

    if (sum(d3) == 0)
        legend('p1', 'p2', 'd1', 'd2', 'Location', 'southeast');
    else
        legend('p1', 'p2','p3', 'd1', 'd2', 'd3', 'Location', 'southeast');
    end

    title('Final distribution - PSC ');
    xlabel('X');
    ylabel('Y');
    
    frame = getframe(gcf);
    for z = 0 : 10
        writeVideo(writerObj,frame);
    end
    close(writerObj);
    
    %print('it-final-psc.jpg', '-djpeg');
end

set(findall(gcf,'type','axes'),'fontsize',17)
set(findall(gcf,'type','text'),'fontSize',17) 

end

