function [gcx, gcy] = FractalPreview(arc)

%% Generating the fractal curve
N = 2;
store = [];
for tt = 1:6
            xs = [tt-1,10];                                           % Initialize the line segment for N = 1
            ys = [1,1];
            xk = [0, 1/3,.5,(2/3),1];
            yk = [0, 0,sin(pi/3)*(1/3),0,0 ];                     % This follows from the geometry
            temp = [xs',ys'];                                     % Create N = 1 vector of (x,y) values
            kochs=zeros(4^N+1,2);
            max_seg = 4^N;

            for ii = 1:N  % For the number of iterations
                numseg = 4^(ii-1);                                  % Total number of segments in curve
                length =(1/3)^(ii-1);                               % Length of each segment
                b = 0;                                              % Initialize x value of segment start
                    for jj = 1:numseg                               % For the number of segments in current iteration
                         x =[temp(jj,1),temp(jj+1,1)];              % Get new straight segment
                         y =[temp(jj,2),temp(jj+1,2)];
                         t =atan2(y(2)-y(1),x(2)-x(1));             % Get angle of segment
                         R = [cos(t),-sin(t);sin(t) cos(t)] ;       % Perform rotation 
                                                                    %  of N =1 segment

                         for i = 1:5  
                           coord(i,:) = length *R*[xk(i);yk(i)];    % Do scaling
                         end
                        coord(:,1) = coord(:,1) + x(1);             % Put segment at correct spot
                        coord(:,2) = coord(:,2) + y(1);
                        r2=5;
                     if jj ~= numseg
                         coord(5,:) = [];                           % If segment is not the last segment
                               %  delete last point
                         r2 = 4;
                     end  
                       a = b+1;                                     % Update the x values of the segment
                       b = a+r2-1;                                  % Update the x values
                     kochs(a:b,:)= [coord];                         % Updates the kochs sample value
                    end
                    temp(1:(4^ii+1),:) = kochs(1:(4^ii+1),:);       % Update temp
            end
            plot(temp(:,1),temp(:,2),'k');
            axis equal;
            hold on;
            store=[store;temp(:,1), temp(:,2)];
end

%% offsetting the fractal curve and storing it in a variable
fractal_store = store;
for pul = 1:70
    hold on;
    xlim([0 2]);
    ylim([0 2]);
    [x,y] = bufferm(store(:,1), store(:,2), 0.04*pul);
    plot(x,y, 'black');
    fractal_store = [fractal_store; x,y];
end

%% determining the points of intersection of the polygon and fractal
closed_matrix = [];
new_total = [];
for movement = 1:size(fractal_store(:,1))-1
    lineseg = [fractal_store(movement,1),fractal_store(movement,2); fractal_store(movement+1,1),fractal_store(movement+1,2)];
    [xi, yi] = polyxpoly(lineseg(:,1), lineseg(:,2), arc(:,1), arc(:,2));
    arb = [xi, yi];
    closed_matrix = [closed_matrix; arb];
    if isempty(arb)
        new_total = [new_total; fractal_store(movement,1), fractal_store(movement,2); arb];
    else
        new_total = [new_total; fractal_store(movement,1), fractal_store(movement,2); arb; NaN, NaN];
    end
end

xq = new_total(:,1);
yq = new_total(:,2);
xv = arc(:,1);
yv = arc(:,2);
[in,on] = inpolygon(xq,yq,xv,yv);
detect_in = [xq(in), yq(in)];
detect_on = [xq(on), yq(on)];

% plot(xq(in), yq(in), 'red'); hold on;
% plot(arc(:,1), arc(:,2), 'blue', 'LineWidth', 1.5); hold on;
% str01 = 'This is your 2D intersection view';
% title(str01);

%% Presentation plot for the viewing
plot_barc = [];
xlim([0 2]);
ylim([0 2]);
for scans = 1:size(detect_on(:,1))
    if rem(scans,2)==0
        [idx, idy] = ismember(detect_on(scans,:), detect_in(:,:), 'rows');
        plot_barc = [plot_barc; idx, idy];
%         plot_barc_temp = detect_in(next:idx,:);
%         plot_barc = [plot_barc; plot_barc_temp; NaN, NaN];
%         next = next + idx + 1;
    end
end

next = 1;
plotting_barc = [];
for inloc = 1:size(plot_barc(:,1))
    plotting_barc = [plotting_barc; detect_in(next:plot_barc(inloc,2),:)];
    plotting_barc = [plotting_barc; NaN(1,2, 'single')];
    next = plot_barc(inloc,2) + 1;
end

plot(plotting_barc(:,1), plotting_barc(:,2), 'red'); hold on;
plot(arc(:,1), arc(:,2), 'blue', 'LineWidth', 1.5); hold on;
str01 = 'This is your 2D intersection view';
title(str01);

gcx = plotting_barc(:,1);
gcy = plotting_barc(:,2);

end