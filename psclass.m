function [ particles, labels ] = psclass( swarmSize, dimensions, dataFile, ...
    maxIterations, rangeMin, rangeMax, velMax, epsilon, inertia, draw)
%%% Implementacion del PSClass.

% PSO parameters
inertiaWeight = inertia;
cognitiveTerm = 1;
socialTerm = 1;

fprintf('w = %d c1 = %d c2 = %d iterations = %d \n\n', inertiaWeight,...
    cognitiveTerm, socialTerm, maxIterations);

[particles, velocities, localBestParticles, localBestDistances, ...
    globalBestParticles, globalBestDistances, inertiaWeight, labels] ...
    = psc2(swarmSize, dimensions, dataFile, maxIterations, rangeMin, ...
    rangeMax, velMax, epsilon, inertia, draw);
                        
maxIterations = maxIterations;

% Load data to be clustered
load(dataFile);
inputData = data; %#ok<NODEF>
dataSize = size(inputData, 1); 

% Distances initialization
dist = zeros(dataSize, swarmSize);

if (draw)
    writerObj = VideoWriter('psclass.avi');
    open(writerObj);
    
    dl1 = (classes == 1); d1 = data(dl1,:);
    dl2 = (classes == 2); d2 = data(dl2,:);
    dl3 = (classes == 3); d3 = data(dl3,:);

    cl1 = (labels == 1); p1 = particles(cl1,:);
    cl2 = (labels == 2); p2 = particles(cl2,:);
    cl3 = (labels == 3); p3 = particles(cl3,:);

    figure(2);
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

    title('Initialising PSClass...');
    xlabel('X');
    ylabel('Y');
    
    set(findall(gcf,'type','axes'),'fontsize',17)
    set(findall(gcf,'type','text'),'fontSize',17) 
    
    frame = getframe(gcf);
    for z = 0 : 10
        writeVideo(writerObj,frame);
    end
    %print('it-init-psclass.jpg', '-djpeg');
end

% Loop
iter = 0;

while iter < maxIterations 
    nextParticles = particles;
    nextVelocities = velocities;
    victories = zeros(swarmSize, 1);
    
    for i = 1 : dataSize
        % Compute distance from data i to particles
        dist(i,:) = pdist2(inputData(i,:), particles);
        
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
        if labels(minIndex,:) == classes(i, :)
            nextParticles(minIndex,:) = particles(minIndex,:) + nextVelocities(minIndex,:);
        else
            nextParticles(minIndex,:) = particles(minIndex,:) - nextVelocities(minIndex,:);
        end
        
    end
  
    % Update positions and velocities for next iteration    
    diff = abs(particles - nextParticles); 
    particles = nextParticles;
    velocities = nextVelocities;
    
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
        dl1 = (classes == 1); d1 = data(dl1,:);
        dl2 = (classes == 2); d2 = data(dl2,:);
        dl3 = (classes == 3); d3 = data(dl3,:);

        cl1 = (labels == 1); p1 = particles(cl1,:);
        cl2 = (labels == 2); p2 = particles(cl2,:);
        cl3 = (labels == 3); p3 = particles(cl3,:);

        figure(2);
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

        name = sprintf('Iteration %d - PSClass ', iter - 1);
        title(name);
        xlabel('X');
        ylabel('Y');
        
        frame = getframe(gcf);
        for z = 0 : 10
            writeVideo(writerObj,frame);
        end
        
        %name = sprintf('it-%d-psclass.jpg', iter - 1);
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

    title('Final distribution - PSClass ');
    xlabel('X');
    ylabel('Y');
    
    frame = getframe(gcf);
    for z = 0 : 10
        writeVideo(writerObj,frame);
    end
    close(writerObj);
    
    %print('it-final-psclass.jpg', '-djpeg');
end

set(findall(gcf,'type','axes'),'fontsize',17)
set(findall(gcf,'type','text'),'fontSize',17) 

end

