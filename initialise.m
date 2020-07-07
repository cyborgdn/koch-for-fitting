function [x,y] = initialise

%% Initialisation
xlim([0 50]);
ylim([0 2]);

str = sprintf('Welcome to the plot (Follow the instructions on the command line)');
title(str);

x_int = [];
y_int = [];
n = 0;
but = 1;

while but == 1
    xlim([0 2]);
    ylim([0 2]);
    [xi,yi,but] = ginput(1);
    plot(xi, yi, 'go'); hold on;
    str = sprintf('Keep adding points');
    title(str);
    n = n + 1;
    x_int(n,1) = xi;
    y_int(n,1) = yi;
end

arc = [x_int, y_int];
arc(end+1,:) = arc(1,:);

cla('reset');
plot(arc(:,1), arc(:,2), 'blue'); hold on;
x = arc(:,1);
y = arc(:,2);

str = sprintf('You drew a Figure, Impressive!');
title(str);

axis equal;
hold on;

end